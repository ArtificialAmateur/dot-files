"""Extract compact API reference from Ghidra pypredef type stubs."""

import ast
import re
import sys
import textwrap
from dataclasses import dataclass, field
from datetime import date
from pathlib import Path

BOILERPLATE_METHODS = frozenset(
    {
        "class_",
        "equals",
        "hashCode",
        "toString",
        "compareTo",
        "notify",
        "notifyAll",
        "wait",
        "getClass",
        "clone",
        "finalize",
    }
)

JPYPE_TYPE_MAP = {
    "jpype.JInt": "int",
    "jpype.JLong": "long",
    "jpype.JShort": "short",
    "jpype.JByte": "byte",
    "jpype.JFloat": "float",
    "jpype.JDouble": "double",
    "jpype.JBoolean": "boolean",
    "jpype.JChar": "char",
}

JAVA_GENERIC_TYPES = frozenset(
    {
        "java.util.List",
        "java.util.Collection",
        "java.util.Set",
        "java.util.Map",
        "java.util.Iterator",
        "java.lang.Iterable",
        "java.util.Optional",
        "java.util.Comparator",
        "java.util.function.Predicate",
        "java.util.function.Function",
        "java.util.function.Consumer",
        "java.util.function.Supplier",
    }
)

EXTRACTION_MAP = {
    "loaders.md": {
        "sources": ["ghidra.app.util.opinion"],
        "include": {
            "Loader",
            "ImporterSettings",
            "AbstractProgramLoader",
            "AbstractLibrarySupportLoader",
            "AbstractProgramWrapperLoader",
            "AbstractOrdinalSupportLoader",
            "LoadSpec",
            "LoadResults",
            "Loaded",
            "LoadedOpen",
            "LoaderTier",
            "LoaderService",
            "LoadException",
            "BinaryLoader",
            "LoaderMap",
        },
        "title": "Loaders",
        "description": "Loader interface, abstract base classes, and supporting types.",
    },
    "binary-io.md": {
        "sources": ["ghidra.app.util.bin"],
        "include": {
            "ByteProvider",
            "ByteProviderWrapper",
            "BinaryReader",
            "StructConverter",
            "ByteArrayConverter",
            "FileBytesProvider",
            "InputStreamByteProvider",
            "InvalidDataException",
            "ObfuscatedInputStream",
            "ObfuscatedOutputStream",
        },
        "title": "Binary I/O",
        "description": "ByteProvider, BinaryReader, and binary data utilities.",
    },
    "program-model.md": {
        "sources": [
            "ghidra.program.model.address",
            "ghidra.program.model.mem",
            "ghidra.program.model.listing",
            "ghidra.program.model.symbol",
        ],
        "include": {
            "Address",
            "AddressFactory",
            "AddressSpace",
            "AddressSet",
            "AddressSetView",
            "AddressRange",
            "AddressRangeIterator",
            "GenericAddress",
            "SegmentedAddress",
            "Memory",
            "MemoryBlock",
            "MemoryAccessException",
            "Program",
            "Listing",
            "Function",
            "FunctionManager",
            "CodeUnit",
            "Data",
            "Instruction",
            "Bookmark",
            "Symbol",
            "SymbolTable",
            "Namespace",
            "SourceType",
            "Reference",
            "ReferenceManager",
            "FlowType",
            "RefType",
            "ExternalLocation",
            "ExternalManager",
        },
        "title": "Program Model",
        "description": "Address, Memory, Listing, Symbol — core program data model.",
    },
    "data-types.md": {
        "sources": ["ghidra.program.model.data"],
        "include": {
            "DataType",
            "DataTypeManager",
            "DataTypeComponent",
            "Structure",
            "StructureDataType",
            "Union",
            "UnionDataType",
            "ArrayDataType",
            "Pointer",
            "PointerDataType",
            "TypeDef",
            "TypedefDataType",
            "Enum",
            "EnumDataType",
            "FunctionDefinition",
            "FunctionDefinitionDataType",
            "CategoryPath",
            "DataUtilities",
            "DataOrganization",
            "AbstractIntegerDataType",
            "AbstractFloatDataType",
            "CharDataType",
            "StringDataType",
            "TerminatedStringDataType",
            "BooleanDataType",
            "VoidDataType",
            "ByteDataType",
            "WordDataType",
            "DWordDataType",
            "QWordDataType",
            "SignedByteDataType",
            "ShortDataType",
            "IntegerDataType",
            "LongDataType",
            "LongLongDataType",
            "FloatDataType",
            "DoubleDataType",
            "UnsignedIntegerDataType",
            "UnsignedLongDataType",
            "UnsignedShortDataType",
            "UnsignedLongLongDataType",
        },
        "title": "Data Types",
        "description": "DataType hierarchy, structures, and type management.",
    },
    "flatapi.md": {
        "sources": ["ghidra.program.flatapi"],
        "include": {"FlatProgramAPI"},
        "title": "Flat Program API",
        "description": "FlatProgramAPI — simplified program manipulation interface.",
    },
    "analyzers.md": {
        "sources": ["ghidra.app.services"],
        "include": {
            "Analyzer",
            "AbstractAnalyzer",
            "AnalyzerType",
            "AnalysisPriority",
        },
        "title": "Analyzers",
        "description": "Analyzer interface and abstract base class.",
    },
    "decompiler.md": {
        "sources": ["ghidra.app.decompiler"],
        "include": {
            "DecompInterface",
            "DecompileResults",
            "DecompileOptions",
            "ClangNode",
            "ClangToken",
            "ClangTokenGroup",
            "ClangFunction",
            "ClangStatement",
            "ClangVariableDecl",
        },
        "title": "Decompiler",
        "description": "DecompInterface and decompilation result types.",
    },
    "plugins.md": {
        "sources": [
            "ghidra.framework.plugintool",
            "ghidra.framework.model",
        ],
        "include": {
            "PluginTool",
            "Plugin",
            "ProgramPlugin",
            "DomainObject",
            "DomainFile",
            "DomainFolder",
            "Project",
            "ProjectData",
            "ProjectManager",
        },
        "title": "Plugins & Framework",
        "description": "Plugin framework, domain objects, and project model.",
    },
}


def get_dotted_name(node):
    """Reconstruct a dotted name from an AST Attribute chain."""
    parts = []
    while isinstance(node, ast.Attribute):
        parts.append(node.attr)
        node = node.value
    if isinstance(node, ast.Name):
        parts.append(node.id)
    return ".".join(reversed(parts))


def simplify_java_type(full_name):
    """Simplify a fully-qualified Java/Ghidra type to its short name."""
    if full_name in JPYPE_TYPE_MAP:
        return JPYPE_TYPE_MAP[full_name]
    if full_name in ("typing.Final", "typing.ClassVar"):
        return full_name
    if full_name == "typing.Any":
        return "?"
    if full_name == "jpype.protocol.SupportsPath":
        return "File"
    if full_name.startswith(
        ("ghidra.", "java.", "javax.", "generic.", "docking.", "org.", "utility.")
    ):
        return full_name.rsplit(".", 1)[-1]
    return full_name


def convert_type(node):
    """Convert a Python type annotation AST node to a Java type string."""
    if node is None:
        return "void"
    if isinstance(node, ast.Constant):
        return str(node.value)
    if isinstance(node, ast.Name):
        mapped = JPYPE_TYPE_MAP.get(f"jpype.{node.id}", None)
        if mapped:
            return mapped
        return {
            "str": "String",
            "int": "int",
            "bool": "boolean",
            "float": "double",
            "bytes": "byte[]",
            "Any": "?",
        }.get(node.id, node.id)
    if isinstance(node, ast.Attribute):
        full = get_dotted_name(node)
        return simplify_java_type(full)
    if isinstance(node, ast.Subscript):
        base = (
            get_dotted_name(node.value)
            if not isinstance(node.value, ast.Name)
            else node.value.id
        )
        if isinstance(node.value, ast.Attribute):
            base = get_dotted_name(node.value)
        if base in ("typing.Union",):
            return _convert_union(node.slice)
        if base in ("typing.ClassVar", "typing.Final"):
            return convert_type(node.slice)
        if base == "typing.Generic":
            return None
        if base == "jpype.JArray":
            inner = convert_type(node.slice)
            return f"{inner}[]"
        inner = _convert_subscript_args(node.slice)
        short_base = simplify_java_type(base)
        return f"{short_base}<{inner}>"
    if isinstance(node, ast.Tuple):
        return ", ".join(convert_type(e) for e in node.elts)
    if isinstance(node, ast.BinOp):
        return convert_type(node.left)
    return "Object"


def _convert_union(slice_node):
    """Convert typing.Union to the Java-relevant type."""
    if isinstance(slice_node, ast.Tuple):
        elts = slice_node.elts
    else:
        elts = [slice_node]
    for elt in elts:
        full = ""
        if isinstance(elt, ast.Attribute):
            full = get_dotted_name(elt)
        elif isinstance(elt, ast.Name):
            full = elt.id
        if full in JPYPE_TYPE_MAP:
            return JPYPE_TYPE_MAP[full]
        if full.startswith("java.lang.String") or full == "str":
            return "String"
    return convert_type(elts[0])


def _convert_subscript_args(node):
    """Convert subscript arguments to comma-separated Java generics."""
    if isinstance(node, ast.Tuple):
        return ", ".join(convert_type(e) for e in node.elts)
    return convert_type(node)


@dataclass
class MethodInfo:
    """Extracted method metadata."""

    name: str
    params: list[tuple[str, str]]  # (name, java_type)
    return_type: str
    docstring: str
    is_static: bool = False
    is_deprecated: bool = False
    overload_index: int = 0


@dataclass
class FieldInfo:
    """Extracted field metadata."""

    name: str
    java_type: str
    value: str | None = None
    docstring: str = ""


@dataclass
class ClassInfo:
    """Extracted class metadata."""

    name: str
    bases: list[str]
    docstring: str
    methods: list[MethodInfo] = field(default_factory=list)
    fields: list[FieldInfo] = field(default_factory=list)
    inner_classes: list["ClassInfo"] = field(default_factory=list)
    is_internal: bool = False


def extract_classes(source_path, include_set):
    """Parse a pypredef file and extract relevant classes."""
    text = source_path.read_text()
    tree = ast.parse(text, filename=str(source_path))

    type_check_only_next = False
    classes = []

    for node in ast.iter_child_nodes(tree):
        if isinstance(node, ast.Expr) and isinstance(node.value, ast.Name):
            continue
        if isinstance(node, ast.ClassDef):
            cls = _extract_class(node, include_set, type_check_only_next)
            type_check_only_next = False
            if cls:
                classes.append(cls)
        elif _is_type_check_only_decorator(node):
            type_check_only_next = True
        else:
            type_check_only_next = False

    return classes


def _is_type_check_only_decorator(node):
    """Check if node is a @typing.type_check_only decorator."""
    if not isinstance(node, ast.FunctionDef | ast.ClassDef):
        return False
    for dec in getattr(node, "decorator_list", []):
        name = (
            get_dotted_name(dec)
            if isinstance(dec, ast.Attribute)
            else getattr(dec, "id", "")
        )
        if "type_check_only" in name:
            return True
    return False


def _has_type_check_only(node):
    """Check if a class node has @typing.type_check_only decorator."""
    for dec in getattr(node, "decorator_list", []):
        name = (
            get_dotted_name(dec)
            if isinstance(dec, ast.Attribute)
            else getattr(dec, "id", "")
        )
        if "type_check_only" in name:
            return True
    return False


def _extract_class(node, include_set, parent_internal=False):
    """Extract a ClassInfo from an ast.ClassDef node."""
    if node.name not in include_set:
        return None

    is_internal = parent_internal or _has_type_check_only(node)
    bases = []
    for base in node.bases:
        base_type = convert_type(base)
        if base_type and base_type not in ("Object", "Generic"):
            bases.append(base_type)

    docstring = ast.get_docstring(node) or ""
    docstring = _clean_docstring(docstring)

    cls = ClassInfo(
        name=node.name,
        bases=bases,
        docstring=docstring,
        is_internal=is_internal,
    )

    overload_counts = {}
    for child in ast.iter_child_nodes(node):
        if isinstance(child, ast.FunctionDef):
            method = _extract_method(child)
            if method and method.name not in BOILERPLATE_METHODS:
                count = overload_counts.get(method.name, 0)
                method.overload_index = count
                overload_counts[method.name] = count + 1
                cls.methods.append(method)
        elif isinstance(child, ast.AnnAssign):
            fld = _extract_field(child)
            if fld and fld.name not in ("class_",):
                cls.fields.append(fld)
        elif isinstance(child, ast.ClassDef):
            inner = _extract_class(child, include_set | {child.name})
            if inner:
                cls.inner_classes.append(inner)

    return cls


def _extract_method(node):
    """Extract a MethodInfo from an ast.FunctionDef node."""
    name = node.name
    if name.startswith("_") and name != "__init__":
        return None

    is_static = any(
        (isinstance(d, ast.Name) and d.id == "staticmethod")
        or (isinstance(d, ast.Attribute) and d.attr == "staticmethod")
        for d in node.decorator_list
    )

    is_deprecated = any(
        (isinstance(d, ast.Name) and d.id == "deprecated")
        or (
            isinstance(d, ast.Call)
            and getattr(d.func, "id", getattr(d.func, "attr", "")) == "deprecated"
        )
        for d in node.decorator_list
    )

    # NOTE: Skip property accessors that duplicate getter methods
    is_property = any(
        (isinstance(d, ast.Name) and d.id == "property")
        or (isinstance(d, ast.Attribute) and d.attr in ("property", "setter", "getter"))
        for d in node.decorator_list
    )
    if is_property:
        return None

    params = []
    for arg in node.args.args:
        if arg.arg == "self":
            continue
        param_type = convert_type(arg.annotation) if arg.annotation else "Object"
        params.append((arg.arg, param_type))

    return_type = convert_type(node.returns) if node.returns else "void"
    if name == "__init__":
        return_type = ""

    docstring = ast.get_docstring(node) or ""
    docstring = _clean_docstring(docstring)

    return MethodInfo(
        name=name,
        params=params,
        return_type=return_type,
        docstring=docstring,
        is_static=is_static,
        is_deprecated=is_deprecated,
    )


def _infer_type_from_value(value_node):
    """Infer a Java type from an AST value node."""
    if isinstance(value_node, ast.Constant):
        val = value_node.value
        if isinstance(val, bool):
            return "boolean"
        if isinstance(val, str):
            return "String"
        if isinstance(val, int):
            return "int"
        if isinstance(val, float):
            return "double"
    if isinstance(value_node, ast.UnaryOp) and isinstance(value_node.op, ast.USub):
        return _infer_type_from_value(value_node.operand)
    return None


def _extract_field(node):
    """Extract a FieldInfo from an ast.AnnAssign node."""
    if not isinstance(node.target, ast.Name):
        return None

    name = node.target.id
    ann_type = convert_type(node.annotation)
    if ann_type is None:
        return None

    value = None
    if node.value is not None:
        if isinstance(node.value, ast.Constant):
            value = repr(node.value.value)
        elif isinstance(node.value, ast.UnaryOp):
            value = ast.literal_eval(node.value)

    # NOTE: Infer type from value when annotation is bare typing.Final
    if ann_type == "typing.Final" and node.value is not None:
        inferred = _infer_type_from_value(node.value)
        if inferred:
            ann_type = inferred

    docstring = ""
    return FieldInfo(name=name, java_type=ann_type, value=value, docstring=docstring)


def _clean_docstring(doc):
    """Clean up RST-style docstring to plain text."""
    if not doc:
        return ""
    doc = re.sub(r":obj:`~?([^`]*)`", r"`\1`", doc)
    doc = re.sub(r":meth:`[^`]*?(\w+(?:\([^)]*\))?)\s*<[^>]+>`", r"`\1`", doc)
    doc = re.sub(r":meth:`~?([^`]*)`", r"`\1`", doc)
    doc = re.sub(r":ref:`([^`]*)`", r"`\1`", doc)
    doc = re.sub(r"\.\. seealso::.*", "", doc, flags=re.DOTALL)
    doc = re.sub(r"\.\. deprecated::.*", "", doc, flags=re.DOTALL)
    doc = re.sub(r"``([^`]+)``", r"`\1`", doc)
    lines = doc.strip().split("\n")
    cleaned = []
    skip = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith(":param "):
            skip = True
            continue
        if stripped.startswith(":return:") or stripped.startswith(":rtype:"):
            skip = True
            continue
        if stripped.startswith(":raises "):
            skip = True
            continue
        if skip and stripped and not stripped.startswith(":"):
            continue
        if stripped.startswith(":"):
            skip = True
            continue
        skip = False
        cleaned.append(stripped)
    result = " ".join(cleaned).strip()
    if len(result) > 300:
        result = result[:297] + "..."
    return result


def render_method_signature(method):
    """Render a method as a compact Java-style signature."""
    params_str = ", ".join(f"{t} {n}" for n, t in method.params)
    prefix = "static " if method.is_static else ""
    if method.name == "__init__":
        return f"{prefix}**new**({params_str})"
    ret = f" → {method.return_type}" if method.return_type else ""
    return f"{prefix}`{method.name}`({params_str}){ret}"


def render_class(cls, heading_level=2):
    """Render a ClassInfo as markdown."""
    lines = []
    hashes = "#" * heading_level
    kind = ""
    if any("Enum" in b for b in cls.bases):
        kind = " (enum)"
    elif cls.is_internal:
        kind = " (internal)"

    base_str = ""
    if cls.bases:
        filtered = [
            b
            for b in cls.bases
            if b
            not in (
                "Object",
                "Serializable",
                "Closeable",
                "AutoCloseable",
                "Iterable",
                "Comparable",
            )
        ]
        if filtered:
            base_str = f" extends {', '.join(filtered)}"

    lines.append(f"{hashes} `{cls.name}`{kind}{base_str}")
    lines.append("")

    if cls.docstring:
        lines.append(cls.docstring)
        lines.append("")

    visible_fields = [f for f in cls.fields if not f.name.startswith("_")]
    if visible_fields:
        lines.append("**Fields:**")
        for fld in visible_fields:
            val = f" = {fld.value}" if fld.value else ""
            lines.append(f"- `{fld.name}`: {fld.java_type}{val}")
        lines.append("")

    if cls.methods:
        lines.append("**Methods:**")
        seen_overloads = {}
        for method in cls.methods:
            if method.is_deprecated:
                continue
            sig = render_method_signature(method)
            key = method.name
            if key in seen_overloads:
                seen_overloads[key] += 1
                sig += f" *(overload {seen_overloads[key]})*"
            else:
                seen_overloads[key] = 1
            doc_suffix = ""
            if method.docstring:
                short_doc = method.docstring.split(".")[0].strip()
                if short_doc and len(short_doc) < 120:
                    doc_suffix = f" — {short_doc}"
            lines.append(f"- {sig}{doc_suffix}")
        lines.append("")

    for inner in cls.inner_classes:
        lines.extend(render_class(inner, heading_level + 1).split("\n"))

    return "\n".join(lines)


def render_file(output_name, classes, config):
    """Render a complete markdown file."""
    today = date.today().isoformat()
    lines = [
        f"<!-- Extracted from Ghidra 12.1 DEV, {today} -->",
        f"# {config['title']}",
        "",
        config["description"],
        "",
        f"*Package(s): {', '.join(config['sources'])}*",
        "",
    ]
    for cls in classes:
        lines.append(render_class(cls))
    return "\n".join(lines)


def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <ghidra-install-dir> [output-dir]")
        print("  ghidra-install-dir: path to Ghidra installation root")
        print("  output-dir: defaults to ~/.claude/docs/ghidra/")
        sys.exit(1)

    ghidra_dir = Path(sys.argv[1])
    output_dir = (
        Path(sys.argv[2])
        if len(sys.argv) > 2
        else (Path.home() / ".claude" / "docs" / "ghidra")
    )

    pypredef_dir = ghidra_dir / "docs" / "ghidra_stubs" / "pypredef"
    if not pypredef_dir.is_dir():
        print(f"Error: pypredef directory not found at {pypredef_dir}")
        sys.exit(1)

    output_dir.mkdir(parents=True, exist_ok=True)

    for output_name, config in EXTRACTION_MAP.items():
        all_classes = []
        include_set = config["include"]

        for source_pkg in config["sources"]:
            stub_name = f"{source_pkg}.pypredef"
            stub_path = pypredef_dir / stub_name
            if not stub_path.exists():
                print(f"  Warning: {stub_path} not found, skipping")
                continue
            classes = extract_classes(stub_path, include_set)
            all_classes.extend(classes)

        content = render_file(output_name, all_classes, config)
        out_path = output_dir / output_name
        out_path.write_text(content)
        class_names = [c.name for c in all_classes]
        print(
            f"  {output_name}: {len(all_classes)} classes "
            f"({', '.join(class_names[:5])}{'...' if len(class_names) > 5 else ''})"
        )

    print(f"\nDone. Output in {output_dir}")


if __name__ == "__main__":
    main()
