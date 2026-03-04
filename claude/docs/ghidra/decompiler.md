<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Decompiler

DecompInterface and decompilation result types.

*Package(s): ghidra.app.decompiler*

## `DecompileResults`

Class for getting at the various structures returned by the decompiler.  Depending on how the DecompInterface was called, you can get C code (with markup), the function' syntax tree, the prototype, etc.  To check if the decompileFunction call completed normally use the decompileCompleted method. ...

**Methods:**
- **new**(Function f, Language language, CompilerSpec compilerSpec, PcodeDataTypeManager d, String e, Decoder decoder, DecompileProcess.DisposeState processState)
- `decompileCompleted`() → boolean — Returns true if the decompilation producing these results completed without aborting
- `failedToStart`() → boolean
- `getCCodeMarkup`() → ClangTokenGroup — Get the marked up C code associated with these decompilation results
- `getDecompiledFunction`() → DecompiledFunction — Converts the C code results into an unadorned string
- `getErrorMessage`() → String — Return any error message associated with the decompilation producing these results
- `getFunction`() → Function
- `getHighFunction`() → HighFunction
- `getHighParamID`() → HighParamID
- `isCancelled`() → boolean
- `isTimedOut`() → boolean
- `isValid`() → boolean — Returns true if the decompile completed normally

## `ClangNode`

A collection of source code text elements, with associated attributes, grouped in a tree structure.

**Methods:**
- `Child`(int i) → ClangNode — Get the i-th child grouping
- `Parent`() → ClangNode — Get the immediate grouping (parent) containing this text element
- `flatten`(List<ClangNode> list) → void — Flatten this text into a list of tokens (see ClangToken)
- `getClangFunction`() → ClangFunction — Get the text representing an entire function of which this is part
- `getMaxAddress`() → Address — Get the biggest Program address associated with the code that this text represents
- `getMinAddress`() → Address — Get the smallest Program address associated with the code that this text represents
- `numChildren`() → int — Return the number of immediate groupings this text breaks up into
- `setHighlight`(Color c) → void — Set a highlighting background color for all text elements

## `ClangVariableDecl` extends ClangTokenGroup

A grouping of source code tokens representing a variable declaration. This can be for a one line declaration (as for local variables) or as part of a function prototype declaring a parameter.

**Methods:**
- **new**(ClangNode par)
- `getDataType`() → DataType
- `getHighSymbol`() → HighSymbol
- `getHighVariable`() → HighVariable

## `ClangStatement` extends ClangTokenGroup

A source code statement (as typically terminated by ';' in C) A statement must have a p-code operation associated with it. In the case of conditional flow control operations, there are usually two lines associated with the statement one containing the '{' and one containing '}'. The one containin...

**Methods:**
- **new**(ClangNode par)
- `getPcodeOp`() → PcodeOp

## `DecompInterface`

This is a self-contained interface to a single decompile process, suitable for an open-ended number of function decompilations for a single program. The interface is persistent. It caches all the initialization data passed to it, and if the underlying decompiler process crashes, it automatically ...

**Methods:**
- **new**()
- `closeProgram`() → void — Shutdown any existing decompiler process and free resources
- `debugEnabled`() → boolean
- `debugSignatures`(Function func, int timeoutSecs, TaskMonitor monitor) → ArrayList<DebugSignature> — Generate a signature, using the current signature settings, for the given function
- `decompileFunction`(Function func, int timeoutSecs, TaskMonitor monitor) → DecompileResults — Decompile function
- `dispose`() → void
- `enableDebug`(File debugfile) → void — Turn on debugging dump for the next decompiled function
- `flushCache`() → int — Tell the decompiler to clear any function and symbol information it gathered from the database
- `generateSignatures`(Function func, boolean keepcalllist, int timeoutSecs, TaskMonitor monitor) → SignatureResult — Generate a signature, using the current signature settings, for the given function
- `getCompilerSpec`() → CompilerSpec
- `getDataTypeManager`() → PcodeDataTypeManager
- `getLanguage`() → Language
- `getLastMessage`() → String — Get the last message produced by the decompiler process
- `getMajorVersion`() → int
- `getMinorVersion`() → int
- `getOptions`() → DecompileOptions — Get the options currently in effect for the decompiler
- `getProgram`() → Program
- `getSignatureSettings`() → int
- `getSimplificationStyle`() → String — Return the identifier for the current simplification style
- `openProgram`(Program prog) → boolean — This call initializes a new decompiler process to do decompilations for a new program
- `resetDecompiler`() → void — Resets the native decompiler process
- `setOptions`(DecompileOptions options) → boolean — Set the object controlling the list of global options used by the decompiler
- `setSignatureSettings`(int value) → boolean — Set the desired signature generation settings
- `setSimplificationStyle`(String actionstring) → boolean
- `stopProcess`() → void — Stop the decompile process
- `structureGraph`(BlockGraph ingraph, int timeoutSecs, TaskMonitor monitor) → BlockGraph
- `toggleCCode`(boolean val) → boolean — Toggle whether or not calls to the decompiler process (via the decompileFunction method) produce C code
- `toggleJumpLoads`(boolean val) → boolean — Toggle whether or not the decompiler process should return information about tables used to recover switch statements
- `toggleParamMeasures`(boolean val) → boolean — Toggle whether or not calls to the decompiler process (via the decompileFunction method) produce Parameter Measures
- `toggleSyntaxTree`(boolean val) → boolean — This method toggles whether or not the decompiler produces a syntax tree (via calls to decompileFunction)

### `EncodeDecodeSet`

**Fields:**
- `overlay`: OverlayAddressSpace
- `mainQuery`: CachedEncoder
- `mainResponse`: PackedDecode
- `callbackQuery`: PackedDecode
- `callbackResponse`: PatchPackedEncode

**Methods:**
- **new**(Program program) — Set up encoders and decoders for functions that are not in overlay address spaces
- **new**(Program program, OverlayAddressSpace spc) *(overload 2)* — Set up encoders and decoders for functions in an overlay space
- `setOverlay`(OverlayAddressSpace spc) → void

## `ClangToken` extends ClangNode

Class representing a source code language token. A token has numerous display attributes and may link to the data-flow analysis

**Fields:**
- `KEYWORD_COLOR`: int = 0
- `COMMENT_COLOR`: int = 1
- `TYPE_COLOR`: int = 2
- `FUNCTION_COLOR`: int = 3
- `VARIABLE_COLOR`: int = 4
- `CONST_COLOR`: int = 5
- `PARAMETER_COLOR`: int = 6
- `GLOBAL_COLOR`: int = 7
- `DEFAULT_COLOR`: int = 8
- `ERROR_COLOR`: int = 9
- `SPECIAL_COLOR`: int = 10
- `MAX_COLOR`: int = 11

**Methods:**
- **new**(ClangNode par)
- **new**(ClangNode par, String txt) *(overload 2)*
- **new**(ClangNode par, String txt, int color) *(overload 3)*
- static `buildSpacer`(ClangNode par, int indent, String indentStr) → ClangToken — Add a spacer token to the given text grouping
- static `buildToken`(int node, ClangNode par, Decoder decoder, PcodeFactory pfactory) → ClangToken — Decode one specialized token from the current position in an encoded stream
- `decode`(Decoder decoder, PcodeFactory pfactory) → void — Decode this token from the current position in an encoded stream
- `getHighSymbol`(HighFunction highFunction) → HighSymbol — Get the symbol associated with this token or null otherwise
- `getHighVariable`() → HighVariable — Get the high-level variable associate with this token or null otherwise
- `getHighlight`() → Color — Get the background highlight color used to render this token, or null if not highlighted
- `getLineParent`() → ClangLine — Get the element representing an entire line of text that contains this element
- `getPcodeOp`() → PcodeOp — Many tokens directly represent a pcode operator in the data-flow
- `getScalar`() → Scalar — If the token represents an underlying integer constant, return the constant as a Scalar
- `getSyntaxType`() → int — Get the "syntax" type (color) associated with this token (keyword, type, etc)
- `getText`() → String
- `getVarnode`() → Varnode — Many tokens directly represent a variable in the data-flow
- `isMatchingToken`() → boolean
- `isVariableRef`() → boolean
- `iterator`(boolean forward) → Iterator<ClangToken> — Get an iterator over tokens starting with this ClangToken
- `setLineParent`(ClangLine line) → void — Set (change) the line which this text element part of
- `setMatchingToken`(boolean matchingToken) → void — Set whether or not additional "matching" highlighting is applied to this token

## `DecompileOptions`

Configuration options for the decompiler This stores the options and can create an XML string to be sent to the decompiler process

**Fields:**
- `SUGGESTED_DECOMPILE_TIMEOUT_SECS`: int = 30
- `SUGGESTED_MAX_PAYLOAD_BYTES`: int = 50
- `SUGGESTED_MAX_INSTRUCTIONS`: int = 100000
- `SUGGESTED_MAX_JUMPTABLE_ENTRIES`: int = 1024
- `DEFAULT_FONT_ID`: String = 'font.decompiler'

**Methods:**
- **new**()
- `encode`(Encoder encoder, DecompInterface iface) → void — Encode all the configuration options to a stream for the decompiler process
- `getBackgroundColor`() → Color
- `getCacheSize`() → int
- `getCommentColor`() → Color
- `getCommentStyle`() → DecompileOptions.CommentStyleEnum
- `getConstantColor`() → Color
- `getCurrentVariableHighlightColor`() → Color
- `getDefaultColor`() → Color
- `getDefaultFont`() → Font
- `getDefaultTimeout`() → int — If the time a decompiler process is allowed to analyze a single function exceeds this value, decompilation is aborted
- `getDisplayLanguage`() → DecompilerLanguage
- `getErrorColor`() → Color
- `getFunctionBraceFormat`() → DecompileOptions.BraceStyle
- `getGlobalColor`() → Color
- `getIfElseBraceFormat`() → DecompileOptions.BraceStyle
- `getKeywordColor`() → Color
- `getLoopBraceFormat`() → DecompileOptions.BraceStyle
- `getMaxInstructions`() → int — If the number of assembly instructions in a function exceeds this value, the function is not decompiled
- `getMaxJumpTableEntries`() → int
- `getMaxPayloadMBytes`() → int
- `getMaxWidth`() → int
- `getMiddleMouseHighlightButton`() → int
- `getMiddleMouseHighlightColor`() → Color
- `getNameTransformer`() → NameTransformer — Retrieve the transformer being applied to data-type, function, and namespace names
- `getParameterColor`() → Color
- `getProtoEvalModel`() → String
- `getSearchHighlightColor`() → Color
- `getSpecialColor`() → Color
- `getSwitchBraceFormat`() → DecompileOptions.BraceStyle
- `getTypeColor`() → Color
- `getVariableColor`() → Color
- `grabFromProgram`(Program program) → void — Grab all the decompiler options from the program specifically and cache them in this object
- `grabFromToolAndProgram`(ToolOptions fieldOptions, ToolOptions opt, Program program) → void — Grab all the decompiler options from various sources within a specific tool and program and cache them in this object
- `isConventionPrint`() → boolean
- `isDisplayLineNumbers`() → boolean
- `isEOLCommentIncluded`() → boolean
- `isEliminateUnreachable`() → boolean
- `isHeadCommentIncluded`() → boolean
- `isNoCastPrint`() → boolean
- `isPLATECommentIncluded`() → boolean
- `isPOSTCommentIncluded`() → boolean
- `isPRECommentIncluded`() → boolean
- `isRespectReadOnly`() → boolean
- `isSimplifyDoublePrecision`() → boolean
- `isWARNCommentIncluded`() → boolean
- `registerOptions`(ToolOptions fieldOptions, ToolOptions opt, Program program) → void
- `setCommentStyle`(DecompileOptions.CommentStyleEnum commentStyle) → void — Set the style in which comments are printed as part of decompiler output
- `setConventionPrint`(boolean conventionPrint) → void — Set whether the calling convention name should be displayed as part of function signatures in decompiler output
- `setDefaultTimeout`(int timeout) → void — Set the maximum time (in seconds) a decompiler process is allowed to analyze a single function
- `setDisplayLanguage`(DecompilerLanguage val) → void — Set the source programming language that decompiler output should be rendered in
- `setEOLCommentIncluded`(boolean commentEOLInclude) → void — Set whether End-of-line comments are displayed as part of decompiler output
- `setEliminateUnreachable`(boolean eliminateUnreachable) → void — Set whether the decompiler should eliminate unreachable code as part of its analysis
- `setFunctionBraceFormat`(DecompileOptions.BraceStyle style) → void — Set how braces are formatted around a function body
- `setHeadCommentIncluded`(boolean commentHeadInclude) → void — Set whether function header comments are included as part of decompiler output
- `setIfElseBraceFormat`(DecompileOptions.BraceStyle style) → void — Set how braces are formatted around an if/else code block
- `setLoopBraceFormat`(DecompileOptions.BraceStyle style) → void — Set how braces are formatted a loop body
- `setMaxInstructions`(int num) → void — Set the maximum number of assembly instructions in a function to decompile
- `setMaxJumpTableEntries`(int num) → void — Set the maximum number of entries the decompiler will recover from a single jumptable
- `setMaxPayloadMBytes`(int mbytes) → void
- `setMaxWidth`(int maxwidth) → void — Set the maximum number of characters the decompiler displays in a single line of output
- `setNameTransformer`(NameTransformer transformer) → void — Set a specific transformer to be applied to all data-type, function, and namespace names in decompiler output
- `setNoCastPrint`(boolean noCastPrint) → void — Set whether decompiler output should display cast operations
- `setPLATECommentIncluded`(boolean commentPLATEInclude) → void — Set whether Plate comments are displayed as part of decompiler output
- `setPOSTCommentIncluded`(boolean commentPOSTInclude) → void — Set whether Post comments are displayed as part of decompiler output
- `setPRECommentIncluded`(boolean commentPREInclude) → void — Set whether Pre comments are displayed as part of decompiler output
- `setProtoEvalModel`(String protoEvalModel) → void — Set the default prototype model for the decompiler
- `setRespectReadOnly`(boolean readOnly) → void — Set whether the decompiler should respect read-only flags as part of its analysis
- `setSimplifyDoublePrecision`(boolean simplifyDoublePrecision) → void
- `setSwitchBraceFormat`(DecompileOptions.BraceStyle style) → void — Set how braces are formatted around a switch block
- `setWARNCommentIncluded`(boolean commentWARNInclude) → void — Set whether automatically generated WARNING comments are displayed as part of decompiler output

### `NanIgnoreEnum` (enum) extends Enum<DecompileOptions.NanIgnoreEnum>

**Fields:**
- `None_`: DecompileOptions.NanIgnoreEnum
- `Compare`: DecompileOptions.NanIgnoreEnum
- `All`: DecompileOptions.NanIgnoreEnum

**Methods:**
- `getOptionString`() → String
- static `valueOf`(String name) → DecompileOptions.NanIgnoreEnum
- static `values`() → DecompileOptions.NanIgnoreEnum[]

### `AliasBlockEnum` (enum) extends Enum<DecompileOptions.AliasBlockEnum>

**Fields:**
- `None_`: DecompileOptions.AliasBlockEnum
- `Struct`: DecompileOptions.AliasBlockEnum
- `Array`: DecompileOptions.AliasBlockEnum
- `All`: DecompileOptions.AliasBlockEnum

**Methods:**
- `getOptionString`() → String
- static `valueOf`(String name) → DecompileOptions.AliasBlockEnum
- static `values`() → DecompileOptions.AliasBlockEnum[]

### `BraceStyle` (enum) extends Enum<DecompileOptions.BraceStyle>

**Fields:**
- `Same`: DecompileOptions.BraceStyle
- `Next`: DecompileOptions.BraceStyle
- `Skip`: DecompileOptions.BraceStyle

**Methods:**
- `getOptionString`() → String
- static `valueOf`(String name) → DecompileOptions.BraceStyle
- static `values`() → DecompileOptions.BraceStyle[]

### `CommentStyleEnum` (enum) extends Enum<DecompileOptions.CommentStyleEnum>

**Fields:**
- `CStyle`: DecompileOptions.CommentStyleEnum
- `CPPStyle`: DecompileOptions.CommentStyleEnum

**Methods:**
- static `valueOf`(String name) → DecompileOptions.CommentStyleEnum
- static `values`() → DecompileOptions.CommentStyleEnum[]

### `NamespaceStrategy` (enum) extends Enum<DecompileOptions.NamespaceStrategy>

**Fields:**
- `Minimal`: DecompileOptions.NamespaceStrategy
- `All`: DecompileOptions.NamespaceStrategy
- `Never`: DecompileOptions.NamespaceStrategy

**Methods:**
- `getOptionString`() → String
- static `valueOf`(String name) → DecompileOptions.NamespaceStrategy
- static `values`() → DecompileOptions.NamespaceStrategy[]

### `IntegerFormatEnum` (enum) extends Enum<DecompileOptions.IntegerFormatEnum>

**Fields:**
- `Hexadecimal`: DecompileOptions.IntegerFormatEnum
- `Decimal`: DecompileOptions.IntegerFormatEnum
- `BestFit`: DecompileOptions.IntegerFormatEnum

**Methods:**
- `getOptionString`() → String
- static `valueOf`(String name) → DecompileOptions.IntegerFormatEnum
- static `values`() → DecompileOptions.IntegerFormatEnum[]

## `ClangFunction` extends ClangTokenGroup

A grouping of source code tokens representing an entire function

**Methods:**
- **new**(ClangNode parent, HighFunction hfunc)
- `getHighFunction`() → HighFunction

## `ClangTokenGroup` extends ClangNode, Iterable<ClangNode>

A sequence of tokens that form a meaningful group in source code.  This group may break up into subgroups and may be part of a larger group.

**Methods:**
- **new**(ClangNode par)
- `AddTokenGroup`(ClangNode obj) → void — Add additional text to this group
- `decode`(Decoder decoder, PcodeFactory pfactory) → void — Decode this text from an encoded stream
- `stream`() → Stream<ClangNode> — Gets a stream over this group's children
- `tokenIterator`(boolean forward) → Iterator<ClangToken> — Create iterator across all ClangToken objects in this group
