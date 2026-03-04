---
globs: ["*.java", "build.gradle", "extension.properties"]
---

## Ghidra 12.x Extension Development

### Loader class hierarchy

```
Loader (interface, ghidra.app.util.opinion)
├── AbstractProgramLoader — framework for loading Programs
│   ├── AbstractLibrarySupportLoader — adds library linking
│   │   └── AbstractOrdinalSupportLoader — ordinal-based libs (PE/NE)
│   └── AbstractProgramWrapperLoader — convenience wrapper (least boilerplate)
```

### 12.x ImporterSettings API change

`Loader.load()` and `Loader.loadInto()` now take a single `ImporterSettings` record:

```java
// OLD (pre-12.x) — DO NOT USE
load(ByteProvider, String, Project, String, LoadSpec, List<Option>, MessageLog, Object, TaskMonitor)

// NEW (12.x)
load(ImporterSettings settings) → LoadResults<DomainObject>
loadInto(Program program, ImporterSettings settings)
```

`ImporterSettings` fields: `provider()`, `importName()`, `project()`, `projectRootPath()`,
`mirrorFsLayout()`, `loadSpec()`, `options()`, `consumer()`, `log()`, `monitor()`

`AbstractProgramWrapperLoader` subclasses override the *protected* `load(ByteProvider, LoadSpec, List<Option>, Program, TaskMonitor, MessageLog)` — the wrapper unpacks `ImporterSettings` automatically.

### Extension types

| Type | Base Class | Package |
|---|---|---|
| Loader | `AbstractLibrarySupportLoader` / `AbstractProgramWrapperLoader` | `ghidra.app.util.opinion` |
| Analyzer | `AbstractAnalyzer` | `ghidra.app.services` |
| Plugin | `ProgramPlugin` | `ghidra.framework.plugintool` |
| Exporter | `Exporter` | `ghidra.app.util.exporter` |
| FileSystem | `GFileSystem` | `ghidra.formats.gfilesystem` |

### Common loader imports

```java
import ghidra.app.util.opinion.*;
import ghidra.app.util.opinion.Loader.ImporterSettings;
import ghidra.app.util.bin.ByteProvider;
import ghidra.app.util.bin.BinaryReader;
import ghidra.app.util.importer.MessageLog;
import ghidra.program.model.listing.Program;
import ghidra.program.model.address.*;
import ghidra.program.model.mem.*;
import ghidra.program.model.lang.LanguageCompilerSpecPair;
import ghidra.util.task.TaskMonitor;
```

### Build

```bash
gradle buildExtension    # produces zip in dist/
```

### API reference

Full method signatures extracted from Ghidra 12.1 DEV stubs: `~/.claude/docs/ghidra/*.md`
