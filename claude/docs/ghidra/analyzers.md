<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Analyzers

Analyzer interface and abstract base class.

*Package(s): ghidra.app.services*

## `AnalysisPriority`

Class to specify priority within the Automated Analysis pipeline.

**Fields:**
- `FORMAT_ANALYSIS`: AnalysisPriority
- `BLOCK_ANALYSIS`: AnalysisPriority
- `DISASSEMBLY`: AnalysisPriority
- `CODE_ANALYSIS`: AnalysisPriority
- `FUNCTION_ANALYSIS`: AnalysisPriority
- `REFERENCE_ANALYSIS`: AnalysisPriority
- `DATA_ANALYSIS`: AnalysisPriority
- `FUNCTION_ID_ANALYSIS`: AnalysisPriority
- `DATA_TYPE_PROPOGATION`: AnalysisPriority
- `LOW_PRIORITY`: AnalysisPriority
- `HIGHEST_PRIORITY`: AnalysisPriority

**Methods:**
- **new**(int priority)
- **new**(String name, int priority) *(overload 2)* — Construct a new priority object
- `after`() → AnalysisPriority — Get a priority that is a little lower than this one
- `before`() → AnalysisPriority — Get a priority that is a little higher than this one
- static `getInitial`(String name) → AnalysisPriority — Return first gross priority
- `getNext`(String nextName) → AnalysisPriority — Get the next gross priority
- `priority`() → int — Return the priority specified for this analysis priority

## `Analyzer` extends ExtensionPoint

Interface to perform automatic analysis.  NOTE:  ALL ANALYZER CLASSES MUST END IN "Analyzer".  If not, the ClassSearcher will not find them.

**Methods:**
- `added`(Program program, AddressSetView set, TaskMonitor monitor, MessageLog log) → boolean — Called when the requested information type has been added, for example, when a function is added
- `analysisEnded`(Program program) → void — Called when an auto-analysis session ends
- `canAnalyze`(Program program) → boolean — Can this analyzer work on this program
- `getAnalysisType`() → AnalyzerType — Get the type of analysis this analyzer performs
- `getDefaultEnablement`(Program program) → boolean — Returns true if this analyzer should be enabled by default
- `getDescription`() → String — Get a longer description of what this analyzer does
- `getName`() → String — Get the name of this analyzer
- `getOptionsUpdater`() → AnalysisOptionsUpdater — Returns an optional options updater that allows clients to migrate old options to new options
- `getPriority`() → AnalysisPriority — Get the priority that this analyzer should run at
- `isPrototype`() → boolean — Returns true if this analyzer is a prototype
- `optionsChanged`(Options options, Program program) → void — Analyzers should initialize their options from the values in the given Options, providing appropriate default values
- `registerOptions`(Options options, Program program) → void — Analyzers should register their options with associated default value, help content and description
- `removed`(Program program, AddressSetView set, TaskMonitor monitor, MessageLog log) → boolean — Called when the requested information type has been removed, for example, when a function is removed
- `supportsOneTimeAnalysis`() → boolean — Returns true if it makes sense for this analyzer to directly invoked on an address or addressSet

## `AnalyzerType` (enum) extends Enum<AnalyzerType>

AnalyzerType defines various types of analyzers that Ghidra provides.  Analyzers get kicked off based on certain events or conditions, such as a function being defined at a location.  Currently there are four types (although only three are used, Data really has no analyzers yet).  BYTES - analyze...

**Fields:**
- `BYTE_ANALYZER`: AnalyzerType
- `INSTRUCTION_ANALYZER`: AnalyzerType
- `FUNCTION_ANALYZER`: AnalyzerType
- `FUNCTION_MODIFIERS_ANALYZER`: AnalyzerType
- `FUNCTION_SIGNATURES_ANALYZER`: AnalyzerType
- `DATA_ANALYZER`: AnalyzerType

**Methods:**
- `getDescription`() → String
- `getName`() → String
- static `valueOf`(String name) → AnalyzerType
- static `values`() → AnalyzerType[]

## `AbstractAnalyzer` extends Analyzer

**Methods:**
- `analyzeLocation`(Program program, Address start, AddressSetView set, TaskMonitor monitor) → AddressSetView — Analyze a single location
