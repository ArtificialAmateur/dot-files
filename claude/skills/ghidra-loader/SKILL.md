---
name: ghidra-loader
description: Scaffold a new Ghidra loader extension with correct 12.x API patterns
user_invocable: true
---

# Ghidra Loader Extension Scaffold

Workflow for creating a new Ghidra loader extension targeting Ghidra 12.x.

## Step 1: Gather Requirements

Ask the user for:
- **Format name** — human-readable name (e.g., "MyCorp Firmware Image")
- **Loader class name** — must end in "Loader" (e.g., `MyCorpFirmwareLoader`)
- **Magic bytes** — byte signature to identify the format (hex pattern and offset)
- **Target architecture** — processor, endianness, address size (e.g., ARM:LE:32:v8)
- **Image base address** — default load address (e.g., `0x00000000`)
- **Header structure** — key header fields (sizes, offsets, entry point)
- **Memory sections** — blocks to create (name, permissions, source offset, size)
- **Ghidra install directory** — for building

## Step 2: Read API Reference

Read these extracted API docs for accurate 12.x signatures:
- `~/.claude/docs/ghidra/loaders.md` — Loader, ImporterSettings, LoadSpec, LoadResults
- `~/.claude/docs/ghidra/binary-io.md` — ByteProvider, BinaryReader

## Step 3: Generate Project Structure

```
<project-root>/
  build.gradle
  extension.properties
  Module.manifest                 # empty, required
  src/main/java/<package>/
    <Name>Loader.java
    <Name>Header.java             # if format has a header
    <Name>Constants.java          # magic bytes, format constants
```

### build.gradle

```groovy
apply plugin: 'java'

def ghidraDir = "<GHIDRA_INSTALL_DIR>"

apply from: new File(ghidraDir, "support/buildExtension.gradle").getPath()
```

### extension.properties

```properties
name=<ExtensionName>
description=<Format> loader for Ghidra
author=
createdOn=
version=@extversion@
```

### Loader class (AbstractProgramWrapperLoader)

Use `AbstractProgramWrapperLoader` for most loaders — it handles `ImporterSettings` unpacking automatically. Subclasses override the **protected** `load()`:

```java
public class <Name>Loader extends AbstractProgramWrapperLoader {

    public static final String LOADER_NAME = "<Format Name>";

    @Override
    public String getName() {
        return LOADER_NAME;
    }

    @Override
    public Collection<LoadSpec> findSupportedLoadSpecs(ByteProvider provider)
            throws IOException {
        List<LoadSpec> loadSpecs = new ArrayList<>();
        byte[] magic = provider.readBytes(0, MAGIC_LENGTH);
        if (Arrays.equals(magic, EXPECTED_MAGIC)) {
            loadSpecs.add(new LoadSpec(this, IMAGE_BASE,
                new LanguageCompilerSpecPair(LANG_ID, COMPILER_ID), true));
        }
        return loadSpecs;
    }

    @Override
    protected void load(ByteProvider provider, LoadSpec loadSpec,
            List<Option> options, Program program, TaskMonitor monitor,
            MessageLog log) throws CancelledException, IOException {
        BinaryReader reader = new BinaryReader(provider, LITTLE_ENDIAN);
        // Parse header
        // Create memory blocks
        // Add entry points and labels
    }
}
```

### Direct Loader/AbstractProgramLoader override

If extending `Loader` or `AbstractProgramLoader` directly, override the **public** `load(ImporterSettings)`:

```java
@Override
public LoadResults<DomainObject> load(ImporterSettings settings)
        throws IOException, CancelledException, LoadException {
    ByteProvider provider = settings.provider();
    LoadSpec loadSpec = settings.loadSpec();
    MessageLog log = settings.log();
    TaskMonitor monitor = settings.monitor();
    // Create Program, load data, wrap in Loaded, return LoadResults
}
```

## Step 4: Build and Verify

```bash
gradle buildExtension    # produces zip in dist/
```

Install: Ghidra → File → Install Extensions → Add → select zip.

## Common Patterns

### Parse binary data

```java
BinaryReader reader = new BinaryReader(provider, /* littleEndian= */ true);
reader.setPointerIndex(offset);
int magic = reader.readNextInt();
long size = reader.readNextLong();
String name = reader.readNextAsciiString(16);
```

### Create memory blocks

```java
Address addr = program.getAddressFactory()
    .getDefaultAddressSpace().getAddress(baseAddr);
MemoryBlock block = program.getMemory().createInitializedBlock(
    name, addr, provider.getInputStream(fileOffset),
    size, monitor, /* overlay= */ false);
block.setRead(true);
block.setWrite(writable);
block.setExecute(executable);
```

### Add entry point

```java
Address entry = program.getAddressFactory()
    .getDefaultAddressSpace().getAddress(entryAddr);
program.getSymbolTable().addExternalEntryPoint(entry);
program.getSymbolTable().createLabel(entry, "_entry", SourceType.IMPORTED);
```

### Set program properties

```java
program.setExecutableFormat(LOADER_NAME);
program.setExecutablePath(provider.getAbsolutePath());
```
