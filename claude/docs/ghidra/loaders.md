<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Loaders

Loader interface, abstract base classes, and supporting types.

*Package(s): ghidra.app.util.opinion*

## `LoaderService`

Factory and utility methods for working with `Loader`s.

**Fields:**
- `ACCEPT_ALL`: Predicate<Loader>

**Methods:**
- **new**()
- static `getAllLoaderNames`() → Collection<String> — Gets all known `Loader`s' names
- static `getAllSupportedLoadSpecs`(ByteProvider provider) → LoaderMap — Gets all supported `LoadSpec`s for loading the given `ByteProvider`
- static `getLoaderClassByName`(String name) → Class<Loader> — Gets the `Loader` `Class` that corresponds to the given simple `Class` name
- static `getSupportedLoadSpecs`(ByteProvider provider, Predicate<Loader> loaderFilter) → LoaderMap — Gets all supported `LoadSpec`s for loading the given `ByteProvider`

## `BinaryLoader` extends AbstractProgramLoader

**Fields:**
- `BINARY_NAME`: String = 'Raw Binary'
- `OPTION_NAME_LEN`: String = 'Length'
- `OPTION_NAME_FILE_OFFSET`: String = 'File Offset'
- `OPTION_NAME_BASE_ADDR`: String = 'Base Address'
- `OPTION_NAME_BLOCK_NAME`: String = 'Block Name'
- `OPTION_NAME_IS_OVERLAY`: String = 'Overlay'

**Methods:**
- **new**()

## `LoaderMap` extends TreeMap<Loader, Collection<LoadSpec>>

A `Map` of `Loader`s to their respective `LoadSpec`s.   The `Loader` keys are sorted according to their `ordering`.

**Methods:**
- **new**()

## `AbstractLibrarySupportLoader` extends AbstractProgramLoader

An abstract `Loader` that provides a framework to conveniently load `Program`s with support for linking against libraries contained in other `Program`s.   Subclasses may override various protected methods to customize how libraries are loaded.

**Fields:**
- `LINK_EXISTING_OPTION_NAME`: String = 'Link Existing Project Libraries'
- `LINK_SEARCH_FOLDER_OPTION_NAME`: String = 'Project Library Search Folder'
- `LOAD_LIBRARY_OPTION_NAME`: String = 'Load Libraries From Disk'
- `LIBRARY_SEARCH_PATH_DUMMY_OPTION_NAME`: String = 'Library Search Paths'
- `DEPTH_OPTION_NAME`: String = 'Recursive Library Load Depth'
- `LIBRARY_DEST_FOLDER_OPTION_NAME`: String = 'Library Destination Folder'
- `MIRROR_LAYOUT_OPTION_NAME`: String = 'Mirror Library Disk Layout'
- `LOAD_ONLY_LIBRARIES_OPTION_NAME`: String = 'Only Load Libraries'

**Methods:**
- **new**()

### `UnprocessedLibrary` (internal) extends Record

A library that has not been processed by the loader yet

**Methods:**
- `depth`() → int
- `name`() → String
- `temporary`() → boolean

### `LibrarySearchPath` (internal) extends Record

A library search path

**Methods:**
- `fsRef`() → FileSystemRef
- `relativeFsPath`() → String

## `Loader` extends ExtensionPoint, Comparable<Loader>

An interface that all loaders must implement. A particular loader implementation should be designed to identify one and only one file format.   NOTE:  ALL loader CLASSES MUST END IN "Loader".  If not, the `ClassSearcher` will not find them.

**Fields:**
- `COMMAND_LINE_ARG_PREFIX`: String = '-loader'
- `OPTIONS_PROJECT_SAVE_STATE_KEY`: String = 'LOADER_OPTIONS'
- `loggingDisabled`: boolean

**Methods:**
- `findSupportedLoadSpecs`(ByteProvider provider) → Collection<LoadSpec>
- `getDefaultOptions`(ByteProvider provider, LoadSpec loadSpec, DomainObject domainObject, boolean loadIntoProgram, boolean mirrorFsLayout) → List<Option> — Gets the default `Loader` options
- `getName`() → String — Gets the `Loader`'s name, which is used both for display purposes, and to identify the `Loader` in the opinion files
- `getPreferredFileName`(ByteProvider provider) → String — The preferred file name to use when loading
- `getTier`() → LoaderTier — For ordering purposes; lower tier numbers are more important (and listed first)
- `getTierPriority`() → int — For ordering purposes; lower numbers are more important (and listed first, within its tier)
- `load`(Loader.ImporterSettings settings) → LoadResults<DomainObject> — Loads bytes in a particular format as a new `Loaded` `DomainObject`
- `loadInto`(Program program, Loader.ImporterSettings settings) → void — Loads bytes into the specified `Program`
- `loadsIntoNewFolder`() → boolean — Checks to see if this `Loader` loads into a new `DomainFolder` instead of a new `DomainFile`
- `supportsLoadIntoProgram`(Program program) → boolean — Checks to see if this `Loader` supports loading into the given `Program`
- `validateOptions`(ByteProvider provider, LoadSpec loadSpec, List<Option> options, Program program) → String

### `ImporterSettings` extends Record

A `Loader` configuration

**Methods:**
- **new**(ByteProvider provider, String importName, Project project, String projectRootPath, boolean mirrorFsLayout, LoadSpec loadSpec, List<Option> options, Object consumer, MessageLog log, TaskMonitor monitor)
- `consumer`() → Object
- `importName`() → String
- `importNameOnly`() → String
- `importPathOnly`() → String
- `loadSpec`() → LoadSpec
- `log`() → MessageLog
- `mirrorFsLayout`() → boolean
- `monitor`() → TaskMonitor
- `options`() → List<Option>
- `project`() → Project
- `projectRootPath`() → String
- `provider`() → ByteProvider

## `LoadResults` extends Iterable<Loaded<T>>

The result of a `load(ghidra.app.util.opinion.Loader.ImporterSettings)`. Provides convenient access to and operations on the underlying `Loaded` `DomainObject`s that got loaded.

**Methods:**
- **new**(List<Loaded<T>> loadedList) — Creates a new `LoadResults` that contains the given non-empty `List` of `Loaded` `DomainObject`s
- **new**(Loaded<T> loaded) *(overload 2)* — Creates a new `LoadResults` that contains the given `Loaded` `DomainObject`
- `close`() → void — Closes this `LoadResults` and releases the reference on the object consuming it
- `getNonPrimary`() → List<Loaded<T>> — Gets the "non-primary" `Loaded` `DomainObject`s, whose meaning is defined by each `Loader` implementation
- `getPrimary`() → Loaded<T> — Gets the "primary" `Loaded` `DomainObject`, whose meaning is defined by each `Loader` implementation
- `getPrimaryDomainObject`(Object consumer) → T — Gets the "primary" `DomainObject`, whose meaning is defined by each `Loader` implementation
- `save`(TaskMonitor monitor) → void — `Saves` each `Loaded` `DomainObject` to the given `Project`
- `size`() → int — Gets the number of `Loaded` `DomainObject`s in this `LoadResults`

## `LoaderTier` (enum) extends Enum<LoaderTier>

**Fields:**
- `SPECIALIZED_TARGET_LOADER`: LoaderTier
- `GENERIC_TARGET_LOADER`: LoaderTier
- `AMBIGUOUS_TARGET_LOADER`: LoaderTier
- `UNTARGETED_LOADER`: LoaderTier

**Methods:**
- static `valueOf`(String name) → LoaderTier
- static `values`() → LoaderTier[]

## `LoadException` extends IOException

Thrown when a `load` fails in an expected way.  The supplied message should explain the reason.

**Methods:**
- **new**(String message) — Create a new `LoadException` with the given message
- **new**(String message, Throwable cause) *(overload 2)* — Create a new `LoadException` with the given message and cause
- **new**(Throwable cause) *(overload 3)* — Create a new `LoadException` with the given cause

## `Loaded`

A loaded `DomainObject` produced by a `Loader`.  In addition to storing the loaded `DomainObject`, it also stores the `Loader`'s desired name and project folder path for the loaded `DomainObject`, should it get saved to a project.

**Methods:**
- **new**(T domainObject, String name, FSRL fsrl, Project project, String projectRootPath, boolean mirrorFsLayout, Object consumer) — Creates a new `Loaded` object
- **new**(T domainObject, Loader.ImporterSettings settings) *(overload 2)* — Creates a new `Loaded` object
- `apply`(Consumer<T> operation) → void — Safely applies the given operation to the loaded `DomainObject` without the need to worry about resource management
- `check`(Predicate<T> predicate) → boolean — Safely tests the given predicate on the loaded `DomainObject` without the need to worry about resource management
- `close`() → void — Closes this `Loaded` `DomainObject` and releases the reference on the object consuming it
- `getDomainObject`(Object consumer) → T — Gets the loaded `DomainObject`
- `getDomainObjectType`() → Class<DomainObject> — Gets the loaded `DomainObject`'s type
- `getName`() → String — Gets the name of the loaded `DomainObject`
- `getProject`() → Project — Gets the `Project` this will get saved to during a `save(TaskMonitor)` operation
- `getProjectFolderPath`() → String — Gets the project folder path this will get saved to during a `save(TaskMonitor)` operation
- `getSavedDomainFile`() → DomainFile — Gets the loaded `DomainObject`'s associated `DomainFile` that was `saved`
- `save`(TaskMonitor monitor) → DomainFile — Saves the loaded `DomainObject` to the given `Project` at this object's project folder path, using this object's name
- `setProjectFolderPath`(String projectRootPath) → void — Sets the project folder path this will get saved to during a `save(TaskMonitor)` operation

### `MirroredLink` (internal) extends Record

A project link and its associated metadata that was created during the mirror process

**Methods:**
- `linkFile`() → DomainFile
- `projectLinkTarget`() → String
- `relative`() → boolean
- `symlink`() → String

## `LoadSpec`

Represents a possible way for a `Loader` to load something.

**Methods:**
- **new**(Loader loader, long imageBase, LanguageCompilerSpecPair languageCompilerSpec, boolean isPreferred) — Constructs a `LoadSpec` from a manually supplied `LanguageCompilerSpecPair`
- **new**(Loader loader, long imageBase, QueryResult languageCompilerSpecQueryResult) *(overload 2)* — Constructs a `LoadSpec` from a `QueryResult`
- **new**(Loader loader, long imageBase, boolean requiresLanguageCompilerSpec) *(overload 3)* — Constructs a `LoadSpec` with an unknown language/compiler
- `getDesiredImageBase`() → int — Gets the desired image base to use during the load
- `getLanguageCompilerSpec`() → LanguageCompilerSpecPair — Gets this `LoadSpec`'s `LanguageCompilerSpecPair`
- `getLoader`() → Loader — Gets this `LoadSpec`'s `Loader`
- `isComplete`() → boolean — Gets whether or not this `LoadSpec` is complete
- `isPreferred`() → boolean — Gets whether or not this `LoadSpec` is a preferred `LoadSpec`
- `requiresLanguageCompilerSpec`() → boolean — Gets whether or not this `LoadSpec` requires a language/compiler to load something

## `LoadedOpen` extends Loaded<T>

A loaded, open `DomainObject` that has already been saved to a `DomainFile`

**Methods:**
- **new**(T domainObject, DomainFile domainFile, FSRL fsrl, Object consumer) — Creates a `Loaded` view on an existing `DomainFile`

## `AbstractOrdinalSupportLoader` extends AbstractLibrarySupportLoader

An abstract `Loader` that provides support for programs that link to external libraries with an ordinal mechanism.  Supports caching library lookup information to XML files.

**Fields:**
- `ORDINAL_LOOKUP_OPTION_NAME`: String = 'Perform Library Ordinal Lookup'

**Methods:**
- **new**()

## `AbstractProgramWrapperLoader` extends AbstractProgramLoader

An abstract `Loader` that provides a convenience wrapper around `AbstractProgramLoader`, minimizing the amount of work a subclass needs to do to load a `Program`

**Methods:**
- **new**()

## `AbstractProgramLoader` extends Loader

An abstract `Loader` that provides a framework to conveniently load `Program`s. Subclasses are responsible for the actual load.   This `Loader` provides a couple processor-related options, as all `Program`s will have a processor associated with them.

**Fields:**
- `APPLY_LABELS_OPTION_NAME`: String = 'Apply Processor Defined Labels'
- `ANCHOR_LABELS_OPTION_NAME`: String = 'Anchor Processor Defined Labels'

**Methods:**
- **new**()
- static `addExternalBlock`(Program program, long size, MessageLog log) → Address — Adds the `EXERNAL block <MemoryBlock
- static `markAsFunction`(Program program, String name, Address funcStart) → void — Mark this address as a function by creating a one byte function
- static `setProgramProperties`(Program prog, ByteProvider provider, String executableFormatName) → void — Sets a program's Executable Path, Executable Format, MD5, SHA256, and FSRL properties
