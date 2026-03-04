<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Data Types

DataType hierarchy, structures, and type management.

*Package(s): ghidra.program.model.data*

## `StructureDataType` extends CompositeDataTypeImpl, StructureInternal

Basic implementation of the structure data type. NOTES:  * Implementation is not thread safe when being modified. * For a structure to treated as having a zero-length (see `isZeroLength()`) it

**Methods:**
- **new**(String name, int length) — Construct a new structure with the given name and length
- **new**(String name, int length, DataTypeManager dtm) *(overload 2)* — Construct a new structure with the given name, length and datatype manager which conveys data organization
- **new**(CategoryPath path, String name, int length) *(overload 3)* — Construct a new structure with the given name and length within the specified categry path
- **new**(CategoryPath path, String name, int length, DataTypeManager dtm) *(overload 4)* — Construct a new structure with the given name, length and datatype manager within the specified categry path
- **new**(CategoryPath path, String name, int length, UniversalID universalID, SourceArchive sourceArchive, long lastChangeTime, long lastChangeTimeInSourceArchive, DataTypeManager dtm) *(overload 5)* — Construct a new structure with the given name and length
- `copy`(DataTypeManager dtm) → DataType — Create copy of structure for target dtm (source archive information is discarded)
- `replaceWith`(DataType dataType) → void

## `TerminatedStringDataType` extends AbstractStringDataType

A null-terminated string `DataType` with a user setable `charset <CharsetSettingsDefinition>` (default ASCII).

**Fields:**
- `dataType`: TerminatedStringDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `WordDataType` extends AbstractUnsignedIntegerDataType

Provides a basic implementation of a word datatype

**Fields:**
- `dataType`: WordDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `UnsignedShortDataType` extends AbstractUnsignedIntegerDataType

Basic implementation for a Short Integer dataType

**Fields:**
- `dataType`: UnsignedShortDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `AbstractFloatDataType` extends BuiltIn

Provides a definition of a Float within a program.

**Methods:**
- **new**(String name, int encodedLength, DataTypeManager dtm) — Abstract float datatype constructor
- static `getFloatDataType`(int rawFormatByteSize, DataTypeManager dtm) → DataType — Get a Float data-type instance with the requested raw format size in bytes
- static `getFloatDataTypes`(DataTypeManager dtm) → AbstractFloatDataType[] — Returns all built-in floating-point data types
- `getLength`() → int — Get the encoded length (number of 8-bit bytes) of this float datatype

## `FunctionDefinitionDataType` extends GenericDataType, FunctionDefinition

Definition of a function for things like function pointers.

**Methods:**
- **new**(String name)
- **new**(String name, DataTypeManager dtm) *(overload 2)*
- **new**(CategoryPath path, String name) *(overload 3)*
- **new**(CategoryPath path, String name, DataTypeManager dtm) *(overload 4)*
- **new**(FunctionSignature sig) *(overload 5)*
- **new**(FunctionSignature sig, DataTypeManager dtm) *(overload 6)*
- **new**(CategoryPath path, String name, FunctionSignature sig) *(overload 7)*
- **new**(CategoryPath path, String name, FunctionSignature sig, DataTypeManager dtm) *(overload 8)*
- **new**(CategoryPath path, String name, FunctionSignature sig, UniversalID universalID, SourceArchive sourceArchive, long lastChangeTime, long lastChangeTimeInSourceArchive, DataTypeManager dtm) *(overload 9)*
- **new**(Function function, boolean formalSignature) *(overload 10)* — Create a Function Definition based on a Function

## `ByteDataType` extends AbstractUnsignedIntegerDataType

Provides a definition of a Byte within a program.

**Fields:**
- `dataType`: ByteDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `UnionDataType` extends CompositeDataTypeImpl, UnionInternal

Basic implementation of the union data type. NOTE: Implementation is not thread safe when being modified.

**Methods:**
- **new**(CategoryPath path, String name) — Construct a new empty union with the given name within the specified categry path
- **new**(CategoryPath path, String name, DataTypeManager dtm) *(overload 2)* — Construct a new empty union with the given name and datatype manager within the specified categry path
- **new**(CategoryPath path, String name, UniversalID universalID, SourceArchive sourceArchive, long lastChangeTime, long lastChangeTimeInSourceArchive, DataTypeManager dtm) *(overload 3)* — Construct a new empty union with the given name within the specified categry path
- **new**(String name) *(overload 4)* — Construct a new UnionDataType

## `Pointer` extends DataType

Interface for pointers

**Fields:**
- `NaP`: String = 'NaP'

**Methods:**
- `getDataType`() → DataType — Returns the "pointed to" dataType
- `newPointer`(DataType dataType) → Pointer — Creates a pointer to the indicated data type
- `typedefBuilder`() → PointerTypedefBuilder — Construct a pointer-typedef builder base on this pointer

## `DataUtilities`

**Methods:**
- static `createData`(Program program, Address addr, DataType newType, int length, DataUtilities.ClearDataMode clearMode) → Data — Create data where existing data may already exist
- static `createData`(Program program, Address addr, DataType newType, int length, boolean stackPointers, DataUtilities.ClearDataMode clearMode) → Data *(overload 2)* — Create data where existing data may already exist
- static `findFirstConflictingAddress`(Program program, Address addr, int length, boolean ignoreUndefinedData) → Address — Finds the first conflicting address in the given address range
- static `getDataAtAddress`(Program program, Address address) → Data — Get the data for the given address
- static `getDataAtLocation`(ProgramLocation loc) → Data — Get the data for the given address; if the code unit at the address is an instruction, return null
- static `getMaxAddressOfUndefinedRange`(Program program, Address addr) → Address — Get the maximum address of an undefined data range starting at addr
- static `getNextNonUndefinedDataAfter`(Program program, Address addr, Address maxAddr) → Data
- static `isUndefinedData`(Program program, Address addr) → boolean
- static `isUndefinedRange`(Program program, Address startAddress, Address endAddress) → boolean — Determine if there is only undefined data from the specified startAddress to the specified endAddress
- static `isValidDataTypeName`(String name) → boolean — Determine if the specified name is a valid data-type name
- static `reconcileAppliedDataType`(DataType originalDataType, DataType newDataType, boolean stackPointers) → DataType

### `ClearDataMode` (enum) extends Enum<DataUtilities.ClearDataMode>

`ClearDataMode` specifies how conflicting data should be cleared when creating/re-creating data

**Fields:**
- `CHECK_FOR_SPACE`: DataUtilities.ClearDataMode
- `CLEAR_SINGLE_DATA`: DataUtilities.ClearDataMode
- `CLEAR_ALL_UNDEFINED_CONFLICT_DATA`: DataUtilities.ClearDataMode
- `CLEAR_ALL_DEFAULT_CONFLICT_DATA`: DataUtilities.ClearDataMode
- `CLEAR_ALL_CONFLICT_DATA`: DataUtilities.ClearDataMode

**Methods:**
- static `valueOf`(String name) → DataUtilities.ClearDataMode
- static `values`() → DataUtilities.ClearDataMode[]

## `IntegerDataType` extends AbstractSignedIntegerDataType

Basic implementation for an signed Integer dataType

**Fields:**
- `dataType`: IntegerDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `Structure` extends Composite

The structure interface.   NOTE: A zero-length Structure will report a length of 1 which will result in improper code unit sizing since we are unable to support a defined data of length 0.   NOTE: The use of zero-length bitfields within non-packed structures is discouraged since they have no real...

**Methods:**
- `clearAtOffset`(int offset) → void — Clears all defined components containing the specified offset in this structure
- `clearComponent`(int ordinal) → void — Clears the defined component at the specified component ordinal
- `deleteAll`() → void — Remove all components from this structure, effectively setting the length to zero
- `deleteAtOffset`(int offset) → void — Deletes all defined components containing the specified offset in this structure
- `getComponent`(int ordinal) → DataTypeComponent — Returns the component of this structure with the indicated ordinal
- `getComponentAt`(int offset) → DataTypeComponent — Gets the first non-zero-length component that starts at the specified offset
- `getComponentContaining`(int offset) → DataTypeComponent — Gets the first non-zero-length component that contains the byte at the specified offset
- `getComponentsContaining`(int offset) → List<DataTypeComponent> — Get an ordered list of components that contain the byte at the specified offset
- `getDataTypeAt`(int offset) → DataTypeComponent — Returns the lowest-level component that contains the specified offset
- `getDefinedComponentAtOrAfterOffset`(int offset) → DataTypeComponent — Gets the first defined component located at or after the specified offset
- `growStructure`(int amount) → void
- `insertAtOffset`(int offset, DataType dataType, int length) → DataTypeComponent — Inserts a new datatype at the specified offset into this structure
- `insertAtOffset`(int offset, DataType dataType, int length, String name, String comment) → DataTypeComponent *(overload 2)* — Inserts a new datatype at the specified offset into this structure
- `insertBitField`(int ordinal, int byteWidth, int bitOffset, DataType baseDataType, int bitSize, String componentName, String comment) → DataTypeComponent — Inserts a new bitfield at the specified ordinal position in this structure
- `insertBitFieldAt`(int byteOffset, int byteWidth, int bitOffset, DataType baseDataType, int bitSize, String componentName, String comment) → DataTypeComponent — Inserts a new bitfield at the specified location in this composite
- `replace`(int ordinal, DataType dataType, int length) → DataTypeComponent
- `replace`(int ordinal, DataType dataType, int length, String name, String comment) → DataTypeComponent *(overload 2)*
- `replaceAtOffset`(int offset, DataType dataType, int length, String name, String comment) → DataTypeComponent
- `setLength`(int length) → void — Set the size of the structure to the specified byte-length

### `BitOffsetComparator` extends Comparator<Object>

`BitOffsetComparator` provides ability to compare an normalized bit offset (see `getNormalizedBitfieldOffset(int, int, int, int, boolean)`) with a `DataTypeComponent` object. The offset will be considered equal (0) if the component contains the offset. A normalized component bit numbering is used...

**Fields:**
- `INSTANCE_LE`: Comparator<Object>
- `INSTANCE_BE`: Comparator<Object>

**Methods:**
- **new**(boolean bigEndian)
- static `getNormalizedBitfieldOffset`(int byteOffset, int storageSize, int effectiveBitSize, int bitOffset, boolean bigEndian) → int — Compute the normalized bit offset of a bitfield relative to the start of a structure

## `QWordDataType` extends AbstractUnsignedIntegerDataType

Provides a definition of a Quad Word within a program.

**Fields:**
- `dataType`: QWordDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `TypedefDataType` extends GenericDataType, TypeDef

Basic implementation for the typedef dataType.  NOTE: Settings are immutable when a DataTypeManager has not been specified (i.e., null).

**Methods:**
- **new**(String name, DataType dt) — Construct a new typedef within the root category
- **new**(CategoryPath path, String name, DataType dt) *(overload 2)* — Construct a new typedef
- **new**(CategoryPath path, String name, DataType dt, DataTypeManager dtm) *(overload 3)* — Construct a new typedef
- **new**(CategoryPath path, String name, DataType dt, UniversalID universalID, SourceArchive sourceArchive, long lastChangeTime, long lastChangeTimeInSourceArchive, DataTypeManager dtm) *(overload 4)* — Construct a new typedef
- static `copy`(TypeDef typedef, DataTypeManager dtm) → TypedefDataType
- static `copyTypeDefSettings`(TypeDef src, TypeDef dest, boolean clearBeforeCopy) → void
- static `generateTypedefName`(TypeDef modelType) → String — Generate a name for the typedef based upon its current `TypeDefSettingsDefinition` settings

## `DataType`

The interface that all datatypes must implement.

**Fields:**
- `DEFAULT`: DataType
- `VOID`: DataType
- `CONFLICT_SUFFIX`: String = '.conflict'
- `TYPEDEF_ATTRIBUTE_PREFIX`: String = '__(('
- `TYPEDEF_ATTRIBUTE_SUFFIX`: String = '))'
- `NO_SOURCE_SYNC_TIME`: int = 0
- `NO_LAST_CHANGE_TIME`: int = 0

**Methods:**
- `addParent`(DataType dt) → void — Inform this data type that it has the given parent   TODO: This method is reserved for internal DB use
- `copy`(DataTypeManager dtm) → DataType — Returns a new instance (shallow copy) of this DataType with a new identity and no source archive association
- `dataTypeAlignmentChanged`(DataType dt) → void — Notification that the given datatype's alignment has changed
- `dataTypeDeleted`(DataType dt) → void — Informs this datatype that the given datatype has been deleted
- `dataTypeNameChanged`(DataType dt, String oldName) → void — Informs this datatype that its name has changed from the indicated old name
- `dataTypeReplaced`(DataType oldDt, DataType newDt) → void
- `dataTypeSizeChanged`(DataType dt) → void — Notification that the given datatype's size has changed
- `dependsOn`(DataType dt) → boolean — Check if this datatype depends on the existence of the given datatype
- `encodeRepresentation`(String repr, MemBuffer buf, Settings settings, int length) → byte[] — Encode bytes according to the display format for this type
- `encodeValue`(Object value, MemBuffer buf, Settings settings, int length) → byte[] — Encode bytes from an Object appropriate for this DataType
- `getAlignedLength`() → int — Get the aligned-length of this datatype as a number of 8-bit bytes
- `getAlignment`() → int — Gets the alignment to be used when aligning this datatype within another datatype
- `getCategoryPath`() → CategoryPath — Gets the categoryPath associated with this datatype
- `getDataOrganization`() → DataOrganization — Returns the DataOrganization associated with this data-type
- `getDataTypeManager`() → DataTypeManager — Get the DataTypeManager containing this datatype
- `getDataTypePath`() → DataTypePath — Returns the dataTypePath for this datatype;
- `getDefaultAbbreviatedLabelPrefix`() → String — Returns the prefix to use for this datatype when an abbreviated prefix is desired
- `getDefaultLabelPrefix`() → String — Returns the appropriate string to use as the default label prefix in the absence of any data
- `getDefaultLabelPrefix`(MemBuffer buf, Settings settings, int len, DataTypeDisplayOptions options) → String *(overload 2)* — Returns the appropriate string to use as the default label prefix
- `getDefaultOffcutLabelPrefix`(MemBuffer buf, Settings settings, int len, DataTypeDisplayOptions options, int offcutOffset) → String — Returns the appropriate string to use as the default label prefix
- `getDefaultSettings`() → Settings — Gets the settings for this data type
- `getDescription`() → String — Get a String briefly describing this DataType
- `getDisplayName`() → String — Gets the name for referring to this datatype
- `getLastChangeTime`() → int — Get the timestamp corresponding to the last time this type was changed within its datatype manager
- `getLastChangeTimeInSourceArchive`() → int — Get the timestamp corresponding to the last time this type was sync'd within its source archive
- `getLength`() → int — Get the length of this DataType as a number of 8-bit bytes
- `getMnemonic`(Settings settings) → String — Get the mnemonic for this DataType
- `getName`() → String — Get the name of this datatype
- `getParents`() → Collection<DataType> — Get the parents of this datatype
- `getPathName`() → String — Get the full category path name that includes this datatype's name
- `getRepresentation`(MemBuffer buf, Settings settings, int length) → String — Get bytes from memory in a printable format for this type
- `getSettingsDefinitions`() → SettingsDefinition[] — Get the list of settings definitions available for use with this datatype
- `getSourceArchive`() → SourceArchive — Get the source archive where this type originated
- `getTypeDefSettingsDefinitions`() → TypeDefSettingsDefinition[] — Get the list of all settings definitions for this datatype that may be used for an associated `TypeDef`
- `getUniversalID`() → UniversalID — Get the universal ID for this datatype
- `getValue`(MemBuffer buf, Settings settings, int length) → Object — Returns the interpreted data value as an instance of the `class`
- `getValueClass`(Settings settings) → Class<?> — Get the Class of the value Object to be returned by this datatype (see `getValue(MemBuffer, Settings, int)`)
- `hasLanguageDependantLength`() → boolean
- `isDeleted`() → boolean — Returns true if this datatype has been deleted and is no longer valid
- `isEncodable`() → boolean
- `isEquivalent`(DataType dt) → boolean — Check if the given datatype is equivalent to this datatype
- `isNotYetDefined`() → boolean — Indicates if this datatype has not yet been fully defined
- `isZeroLength`() → boolean — Indicates this datatype is defined with a zero length
- `removeParent`(DataType dt) → void — Remove a parent datatype   TODO: This method is reserved for internal DB use
- `replaceWith`(DataType dataType) → void
- `setCategoryPath`(CategoryPath path) → void — Set the categoryPath associated with this datatype
- `setDescription`(String description) → void — Sets a String briefly describing this DataType
- `setLastChangeTime`(long lastChangeTime) → void — Sets the lastChangeTime for this datatype
- `setLastChangeTimeInSourceArchive`(long lastChangeTimeInSourceArchive) → void — Sets the lastChangeTimeInSourceArchive for this datatype
- `setName`(String name) → void — Sets the name of the datatype
- `setNameAndCategory`(CategoryPath path, String name) → void — Sets the name and category of a datatype at the same time
- `setSourceArchive`(SourceArchive archive) → void — Set the source archive where this type originated

## `DoubleDataType` extends AbstractFloatDataType

Provides a definition of a Double within a program.

**Fields:**
- `dataType`: DoubleDataType

**Methods:**
- **new**() — Creates a Double data type
- **new**(DataTypeManager dtm) *(overload 2)*

## `AbstractIntegerDataType` extends BuiltIn, ArrayStringable

Base type for integer data types such as `chars <CharDataType>`, `ints <IntegerDataType>`, and `longs <LongDataType>`.   If `getFormat(Settings)` indicates that this is a `CHAR <FormatSettingsDefinition.CHAR>` type, the `ArrayStringable` methods will treat an array of this data type as a string.

**Methods:**
- **new**(String name, DataTypeManager dtm) — Constructor
- `getAssemblyMnemonic`() → String
- `getCDeclaration`() → String
- `getCMnemonic`() → String
- `getOppositeSignednessDataType`() → AbstractIntegerDataType
- static `getSignedDataType`(int size, DataTypeManager dtm) → DataType — Get a Signed Integer data-type instance of the requested size
- static `getSignedDataTypes`(DataTypeManager dtm) → AbstractIntegerDataType[] — Returns all built-in signed integer data-types
- static `getUnsignedDataType`(int size, DataTypeManager dtm) → DataType — Get a Unsigned Integer data-type instance of the requested size
- static `getUnsignedDataTypes`(DataTypeManager dtm) → AbstractIntegerDataType[] — Returns all built-in unsigned integer data-types
- `isSigned`() → boolean — Determine if this type is signed

## `DataTypeComponent`

DataTypeComponents are holders for the dataTypes that make up composite (Structures and Unions) dataTypes.

**Fields:**
- `DEFAULT_FIELD_NAME_PREFIX`: String = 'field'

**Methods:**
- `getComment`() → String — Get the comment for this dataTypeComponent
- `getDataType`() → DataType — Returns the dataType in this component
- `getDefaultFieldName`() → String — Returns a default field name for this component
- `getDefaultSettings`() → Settings — Gets the default settings for this data type component
- `getEndOffset`() → int — Get the byte offset of where this component ends relative to the start of the parent data type
- `getFieldName`() → String — Get this component's field name within its parent
- `getLength`() → int — Get the length of this component in 8-bit bytes
- `getOffset`() → int — Get the byte offset of where this component begins relative to the start of the parent data type
- `getOrdinal`() → int — Get the ordinal position within the parent dataType
- `getParent`() → DataType — returns the dataType that contains this component
- `isBitFieldComponent`() → boolean — Determine if the specified component corresponds to a bit-field
- `isDefaultFieldName`(String s) → boolean — Returns true if the given string represents the default field name for this data type component
- `isEquivalent`(DataTypeComponent dtc) → boolean — Returns true if the given dataTypeComponent is equivalent to this dataTypeComponent
- `isUndefined`() → boolean — Returns true if this component is not defined
- `isZeroBitFieldComponent`() → boolean — Determine if the specified component corresponds to a zero-length bit-field
- `setComment`(String comment) → void — Sets the comment for the component
- `setFieldName`(String fieldName) → void — Sets the field name
- static `usesZeroLengthComponent`(DataType dataType) → boolean

## `EnumDataType` (enum) extends GenericDataType, Enum

**Methods:**
- **new**(String name, int length)
- **new**(CategoryPath path, String name, int length) *(overload 2)*
- **new**(CategoryPath path, String name, int length, DataTypeManager dtm) *(overload 3)*
- **new**(CategoryPath path, String name, int length, UniversalID universalID, SourceArchive sourceArchive, long lastChangeTime, long lastChangeTimeInSourceArchive, DataTypeManager dtm) *(overload 4)*
- `pack`() → void — Sets this enum to it smallest (power of 2) size that it can be and still represent all its current values
- `setLength`(int newLength) → void

## `CategoryPath` extends Comparable<CategoryPath>

A category path is the full path to a particular data type

**Fields:**
- `DELIMITER_CHAR`: String = '/'
- `DELIMITER_STRING`: String = '/'
- `ESCAPED_DELIMITER_STRING`: String = '\\/'
- `ROOT`: CategoryPath

**Methods:**
- **new**(CategoryPath parent)
- **new**(CategoryPath parent, List<String> subPathElements) *(overload 2)*
- **new**(String path) *(overload 3)* — Creates a category path given a forward-slash-delimited string (e
- `asArray`() → String[]
- `asList`() → List<String>
- static `escapeString`(String nonEscapedString) → String
- `extend`() → CategoryPath
- `extend`(List<String> subPathElements) → CategoryPath *(overload 2)*
- `getName`() → String — Return the terminating name of this category path
- `getParent`() → CategoryPath — Return the parent category path
- `getPath`() → String
- `getPath`(String childName) → String *(overload 2)*
- `getPathElements`() → String[] — Returns array of names in category path
- `isAncestorOrSelf`(CategoryPath candidateAncestorPath) → boolean — Tests if the specified categoryPath is the same as, or an ancestor of, this category path
- `isRoot`() → boolean — Determine if this category path corresponds to the root category
- static `unescapeString`(String escapedString) → String

## `StringDataType` extends AbstractStringDataType

A fixed-length string `DataType` with a user setable `charset <CharsetSettingsDefinition>` (default ASCII).   All string data types:  * `StringDataType` - this type, fixed length, user settable charset. * `StringUTF8DataType` - fixed length UTF-8 string. * `TerminatedStringDataType` - terminated ...

**Fields:**
- `dataType`: StringDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `FloatDataType` extends AbstractFloatDataType

Provides a definition of a Float within a program.

**Fields:**
- `dataType`: FloatDataType

**Methods:**
- **new**() — Creates a Float data type
- **new**(DataTypeManager dtm) *(overload 2)*

## `TypeDef` extends DataType

The typedef interface

**Methods:**
- `enableAutoNaming`() → void — Enable auto-naming for this typedef
- `getBaseDataType`() → DataType — Returns the non-typedef dataType that this typedef is based on, following chains of typedefs as necessary
- `getDataType`() → DataType — Returns the dataType that this typedef is based on
- `hasSameTypeDefSettings`(TypeDef dt) → boolean — Compare the settings of two datatypes which correspond to a `TypeDefSettingsDefinition`
- `isAutoNamed`() → boolean — Determine if this datatype use auto-naming (e
- `isPointer`() → boolean — Determine if this is a Pointer-TypeDef

## `UnsignedIntegerDataType` extends AbstractUnsignedIntegerDataType

Basic implementation for an unsigned Integer dataType

**Fields:**
- `dataType`: UnsignedIntegerDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `UnsignedLongDataType` extends AbstractUnsignedIntegerDataType

Basic implementation for a Signed Long Integer dataType

**Fields:**
- `dataType`: UnsignedLongDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `BooleanDataType` extends AbstractUnsignedIntegerDataType

Provides a definition of an Ascii byte in a program.

**Fields:**
- `dataType`: BooleanDataType

**Methods:**
- **new**() — Constructs a new Boolean datatype
- **new**(DataTypeManager dtm) *(overload 2)*
- `getRepresentation`(BigInteger bigInt, Settings settings, int bitLength) → String

## `SignedByteDataType` extends AbstractSignedIntegerDataType

Provides a definition of a Signed Byte within a program.

**Fields:**
- `dataType`: SignedByteDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `Union` extends Composite

The union interface.   NOTE: The use of bitfields within all unions assumes a default packing where bit allocation always starts with byte-0 of the union.  Bit allocation order is dictated by data organization endianness (byte-0 msb allocated first for big-endian, while byte-0 lsb allocated first...

**Methods:**
- `insertBitField`(int ordinal, DataType baseDataType, int bitSize, String componentName, String comment) → DataTypeComponent — Inserts a new bitfield at the specified ordinal position in this union

## `VoidDataType` extends BuiltIn

Special dataType used only for function return types.  Used to indicate that a function has no return value.

**Fields:**
- `dataType`: VoidDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*
- static `isVoidDataType`(DataType dt) → boolean — Determine if the specified `DataType` is a `VoidDataType` after stripping away any `TypeDef`

## `FunctionDefinition` extends DataType, FunctionSignature

Defines a function signature for things like function pointers.

**Methods:**
- `replaceArgument`(int ordinal, String name, DataType dt, String comment, SourceType source) → void — Replace the given argument with another data type
- `setArguments`() → void — Set the arguments to this function
- `setCallingConvention`(String conventionName) → void — Set the calling convention associated with this function definition
- `setComment`(String comment) → void — Set the function comment
- `setNoReturn`(boolean hasNoReturn) → void — Set whether or not this function has a return
- `setReturnType`(DataType type) → void — Set the return data type for this function
- `setVarArgs`(boolean hasVarArgs) → void — Set whether parameters can be passed as a VarArg (variable argument list)

## `DataTypeManager`

Interface for Managing data types.

**Fields:**
- `DEFAULT_DATATYPE_ID`: int = 0
- `NULL_DATATYPE_ID`: int = -1
- `BAD_DATATYPE_ID`: int = -2
- `BUILT_IN_DATA_TYPES_NAME`: String = 'BuiltInTypes'
- `LOCAL_ARCHIVE_KEY`: int = 0
- `BUILT_IN_ARCHIVE_KEY`: int = 1
- `LOCAL_ARCHIVE_UNIVERSAL_ID`: UniversalID
- `BUILT_IN_ARCHIVE_UNIVERSAL_ID`: UniversalID

**Methods:**
- `addDataType`(DataType dataType, DataTypeConflictHandler handler) → DataType — Returns a data type after adding it to this data manager
- `addDataTypeManagerListener`(DataTypeManagerChangeListener l) → void — Add a listener that is notified when the dataTypeManger changes
- `addDataTypes`(collections.abc.Sequence dataTypes, DataTypeConflictHandler handler, TaskMonitor monitor) → void — Sequentially adds a collection of datatypes to this data manager
- `addInvalidatedListener`(InvalidatedListener listener) → void — Adds a listener that will be notified when this manager's cache is invalidated
- `allowsDefaultBuiltInSettings`() → boolean — Determine if settings are supported for BuiltIn datatypes within this datatype manager
- `allowsDefaultComponentSettings`() → boolean — Determine if settings are supported for datatype components within this datatype manager (i
- `associateDataTypeWithArchive`(DataType datatype, SourceArchive archive) → void — Change the given data type and its dependencies so their source archive is set to given archive
- `close`() → void — Closes this dataType manager
- `contains`(DataType dataType) → boolean — Return true if the given data type exists in this data type manager
- `containsCategory`(CategoryPath path) → boolean — Returns true if the given category path exists in this data type manager
- `createCategory`(CategoryPath path) → Category — Create a category for the given path; returns the current category if it already exits
- `disassociate`(DataType datatype) → void
- `endTransaction`(int transactionID, boolean commit) → boolean — Ends the current transaction
- `findDataTypeForID`(UniversalID datatypeID) → DataType — Get's the data type with the matching universal data type id
- `findDataTypes`(String name, List<DataType> list) → void — Begin searching at the root category for all data types with the given name
- `findDataTypes`(String name, List<DataType> list, boolean caseSensitive, TaskMonitor monitor) → void *(overload 2)*
- `findEnumValueNames`(long value, Set<String> enumValueNames) → void — Adds all enum value names that match the given value, to the given set
- `flushEvents`() → void — Force all pending notification events to be flushed
- `getAddressMap`() → AddressMap — Returns the associated AddressMap used by this datatype manager
- `getAllComposites`() → Iterator<Composite> — Returns an iterator over all composite data types (structures and unions) in this manager
- `getAllDataTypes`() → Iterator<DataType> — Returns an iterator over all the dataTypes in this manager
- `getAllDataTypes`(List<DataType> list) → void *(overload 2)* — Adds all data types to the specified list
- `getAllFunctionDefinitions`() → Iterator<FunctionDefinition> — Returns an iterator over all function definition data types in this manager
- `getAllStructures`() → Iterator<Structure> — Returns an iterator over all structures in this manager
- `getCallingConvention`(String name) → PrototypeModel — Get the prototype model of the calling convention with the specified name from the associated compiler specification
- `getCategory`(long categoryID) → Category — Returns the Category with the given id
- `getCategory`(CategoryPath path) → Category *(overload 2)* — Get the category that has the given path
- `getCategoryCount`() → int — Returns the total number of data type categories
- `getDataOrganization`() → DataOrganization — Get the data organization associated with this data type manager
- `getDataType`(String dataTypePath) → DataType — Retrieve the data type with the fully qualified path
- `getDataType`(DataTypePath dataTypePath) → DataType *(overload 2)* — Find the dataType for the given dataTypePath
- `getDataType`(long dataTypeID) → DataType *(overload 3)* — Returns the dataType associated with the given dataTypeId or null if the dataTypeId is not valid
- `getDataType`(CategoryPath path, String name) → DataType *(overload 4)* — Gets the data type with the indicated name in the indicated category
- `getDataType`(SourceArchive sourceArchive, UniversalID datatypeID) → DataType *(overload 5)* — Finds the data type using the given source archive and id
- `getDataTypeCount`(boolean includePointersAndArrays) → int — Returns the total number of defined data types
- `getDataTypes`(SourceArchive sourceArchive) → List<DataType> — Returns all data types within this manager that have as their source the given archive
- `getDefaultCallingConvention`() → PrototypeModel — Get the default calling convention's prototype model in this data type manager if known
- `getDefinedCallingConventionNames`() → Collection<String> — Get the ordered list of defined calling convention names
- `getFavorites`() → List<DataType> — Returns a list of datatypes that have been designated as favorites
- `getID`(DataType dt) → int — Returns the dataTypeId for the given dataType
- `getKnownCallingConventionNames`() → Collection<String> — Get the ordered list of known calling convention names
- `getLastChangeTimeForMyManager`() → int — Returns the timestamp of the last time this manager was changed
- `getLocalSourceArchive`() → SourceArchive — Returns the source archive for this manager
- `getName`() → String — Returns this data type manager's name
- `getPointer`(DataType datatype) → Pointer — Returns a default sized pointer to the given datatype
- `getPointer`(DataType datatype, int size) → Pointer *(overload 2)* — Returns a pointer of the given size to the given datatype
- `getProgramArchitecture`() → ProgramArchitecture — Get the optional program architecture details associated with this archive
- `getProgramArchitectureSummary`() → String — Get the program architecture information which has been associated with this data type manager
- `getResolvedID`(DataType dt) → int — Returns the dataTypeId for the given dataType
- `getRootCategory`() → Category — Returns the root category Manager
- `getSourceArchive`(UniversalID sourceID) → SourceArchive — Returns the source archive for the given ID
- `getSourceArchives`() → List<SourceArchive> — Returns a list of source archives not including the builtin or the program's archive
- `getType`() → ArchiveType — Returns this manager's archive type
- `getUniqueName`(CategoryPath path, String baseName) → String — Returns a unique name not currently used by any other data type or category with the same baseName
- `getUniversalID`() → UniversalID — Returns the universal ID for this dataType manager
- `isFavorite`(DataType datatype) → boolean — Returns true if the given datatype has been designated as a favorite
- `isUpdatable`() → boolean — Returns true if this DataTypeManager can be modified
- `openTransaction`(String description) → db.Transaction — Open new transaction
- `remove`(DataType dataType) → boolean — Remove the given data type from this manager
- `remove`(List<DataType> dataTypes, TaskMonitor monitor) → void *(overload 2)* — Remove the given data types from this manager
- `removeDataTypeManagerListener`(DataTypeManagerChangeListener l) → void — Remove the DataTypeManger change listener
- `removeInvalidatedListener`(InvalidatedListener listener) → void — Removes a previously added InvalidatedListener
- `removeSourceArchive`(SourceArchive sourceArchive) → void — Removes the source archive from this manager
- `replaceDataType`(DataType existingDt, DataType replacementDt, boolean updateCategoryPath) → DataType — Replace an existing dataType with another
- `resolve`(DataType dataType, DataTypeConflictHandler handler) → DataType — Returns a data type that is "in" this Manager, creating a new one if necessary
- `resolveSourceArchive`(SourceArchive sourceArchive) → SourceArchive — Returns or creates a persisted version of the given source archive
- `setFavorite`(DataType datatype, boolean isFavorite) → void — Sets the given dataType to be either a favorite or not a favorite
- `setName`(String name) → void — Sets this data type manager's name
- `startTransaction`(String description) → int — Starts a transaction for making changes in this data type manager
- `updateSourceArchiveName`(String archiveFileID, String name) → boolean — Updates the name associated with a source archive in this data type manager
- `updateSourceArchiveName`(UniversalID sourceID, String name) → boolean *(overload 2)* — Updates the name associated with a source archive in this data type manager
- `withTransaction`(String description, ExceptionalCallback<E> callback) → void — Performs the given callback inside of a transaction
- `withTransaction`(String description, ExceptionalSupplier<T, E> supplier) → T *(overload 2)* — Calls the given supplier inside of a transaction

## `LongLongDataType` extends AbstractSignedIntegerDataType

Basic implementation for an Signed LongLong Integer dataType

**Fields:**
- `dataType`: LongLongDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `PointerDataType` extends BuiltIn, Pointer

Basic implementation for a pointer dataType

**Fields:**
- `dataType`: PointerDataType
- `MAX_POINTER_SIZE_BYTES`: int = 8
- `POINTER_NAME`: String = 'pointer'
- `POINTER_LABEL_PREFIX`: String = 'PTR'
- `POINTER_LABEL_PREFIX_U`: String = 'PTR_'
- `POINTER_LOOP_LABEL`: String = 'PTR_LOOP'
- `NOT_A_POINTER`: String = 'NaP'

**Methods:**
- **new**() — Creates a dynamically-sized default pointer data type
- **new**(DataTypeManager dtm) *(overload 2)* — Creates a dynamically-sized default pointer data type
- **new**(DataType referencedDataType) *(overload 3)*
- **new**(DataType referencedDataType, int length) *(overload 4)* — Construct a pointer of a specified length to a referencedDataType
- **new**(DataType referencedDataType, DataTypeManager dtm) *(overload 5)* — Construct a dynamically-sized pointer to the given data type
- **new**(DataType referencedDataType, int length, DataTypeManager dtm) *(overload 6)* — Construct a pointer of a specified length to a referencedDataType
- static `getAddressValue`(MemBuffer buf, int size, Settings settings) → Address — Generate an address value based upon bytes stored at the specified buf location
- static `getAddressValue`(MemBuffer buf, int size, Settings settings, Consumer<String> errorHandler) → Address *(overload 2)* — Generate an address value based upon bytes stored at the specified buf location
- static `getAddressValue`(MemBuffer buf, int size, AddressSpace targetSpace) → Address *(overload 3)* — Generate an address value based upon bytes stored at the specified buf location
- static `getLabelString`(MemBuffer buf, Settings settings, int len, DataTypeDisplayOptions options) → String
- static `getPointer`(DataType dt, DataTypeManager dtm) → Pointer — Get a pointer data-type instance with a default size
- static `getPointer`(DataType dt, int pointerSize) → Pointer *(overload 2)* — Get a pointer data-type instance of the requested size

### `PointerReferenceClassification` (enum) extends Enum<PointerDataType.PointerReferenceClassification>

**Fields:**
- `NORMAL`: PointerDataType.PointerReferenceClassification
- `LOOP`: PointerDataType.PointerReferenceClassification
- `DEEP`: PointerDataType.PointerReferenceClassification

**Methods:**
- static `valueOf`(String name) → PointerDataType.PointerReferenceClassification
- static `values`() → PointerDataType.PointerReferenceClassification[]

## `DWordDataType` extends AbstractUnsignedIntegerDataType

Provides a definition of a Double Word within a program.

**Fields:**
- `dataType`: DWordDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `UnsignedLongLongDataType` extends AbstractUnsignedIntegerDataType

Basic implementation for an Signed LongLong Integer dataType

**Fields:**
- `dataType`: UnsignedLongLongDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `CharDataType` extends AbstractIntegerDataType, DataTypeWithCharset

Provides a definition of an primitive char in a program. The size and signed-ness of this type is determined by the data organization of the associated data type manager.

**Fields:**
- `dataType`: CharDataType

**Methods:**
- **new**() — Constructs a new char datatype
- **new**(DataTypeManager dtm) *(overload 2)*
- `getCDeclaration`() → String — Returns the C style data-type declaration for this data-type

## `DataOrganization`

**Fields:**
- `NO_MAXIMUM_ALIGNMENT`: int = 0

**Methods:**
- `getAbsoluteMaxAlignment`() → int — Gets the maximum alignment value that is allowed by this data organization
- `getAlignment`(DataType dataType) → int — Determines the alignment value for the indicated data type
- `getBitFieldPacking`() → BitFieldPacking — Get the composite bitfield packing information associated with this data organization
- `getCharSize`() → int
- `getDefaultAlignment`() → int
- `getDefaultPointerAlignment`() → int — Gets the default alignment to be used for a pointer that doesn't have size
- `getDoubleSize`() → int
- `getFloatSize`() → int
- `getIntegerCTypeApproximation`(int size, boolean signed) → String — Returns the best fitting integer C-type whose size is less-than-or-equal to the specified size
- `getIntegerSize`() → int
- `getLongDoubleSize`() → int
- `getLongLongSize`() → int
- `getLongSize`() → int
- `getMachineAlignment`() → int — Gets the maximum useful alignment for the target machine
- `getPointerShift`() → int
- `getPointerSize`() → int
- `getShortSize`() → int
- `getSizeAlignment`(int size) → int — Gets the primitive data alignment that is defined for the specified size
- `getSizeAlignmentCount`() → int — Gets the number of sizes that have an alignment specified
- `getSizes`() → int[] — Gets the ordered list of sizes that have an alignment specified
- `getWideCharSize`() → int
- `isBigEndian`() → boolean
- `isEquivalent`(DataOrganization obj) → boolean — Determine if this DataOrganization is equivalent to another specific instance
- `isSignedChar`() → boolean

## `ArrayDataType` extends DataTypeImpl, Array

Basic implementation of the Array interface.  NOTE: The use of `FactoryDataType` and `Dynamic`, where `canSpecifyLength()` is false, are not supported for array use.

**Methods:**
- **new**(DataType dataType, int numElements) — Constructs a new Array dataType for fixed-length datatypes
- **new**(DataType dataType, int numElements, int elementLength) *(overload 2)* — Constructs a new Array dataType
- **new**(DataType dataType, int numElements, int elementLength, DataTypeManager dataMgr) *(overload 3)* — Constructs a new Array dataType

## `ShortDataType` extends AbstractSignedIntegerDataType

Basic implementation for a Short Integer dataType

**Fields:**
- `dataType`: ShortDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*

## `Enum` extends DataType

**Methods:**
- `add`(String name, long value) → void — Add a enum entry
- `add`(String name, long value, String comment) → void *(overload 2)* — Add a enum entry
- `contains`(String name) → boolean — Returns true if this enum has an entry with the given name
- `contains`(long value) → boolean *(overload 2)* — Returns true if this enum has an entry with the given value
- `getComment`(String name) → String — Get the comment for the given name
- `getCount`() → int — Get the number of entries in this Enum
- `getMaxPossibleValue`() → int — Returns the maximum value that this enum can represent based on its size and signedness
- `getMinPossibleValue`() → int — Returns the maximum value that this enum can represent based on its size and signedness
- `getMinimumPossibleLength`() → int — Returns the smallest length (size in bytes) this enum can be and still represent all of it's current values
- `getName`(long value) → String — Get the name for the given value
- `getNames`(long value) → String[] — Returns all names that map to the given value
- `getNames`() → String[] *(overload 2)* — Get the names of the enum entries
- `getRepresentation`(BigInteger bigInt, Settings settings, int bitLength) → String — Get enum representation of the big-endian value
- `getSignedState`() → EnumSignedState — Returns the signed state
- `getValue`(String name) → int — Get the value for the given name
- `getValues`() → long[] — Get the values of the enum entries
- `isSigned`() → boolean — Returns true if the enum contains at least one negative value
- `remove`(String name) → void — Remove the enum entry with the given name
- `setDescription`(String description) → void — Set the description for this Enum

## `LongDataType` extends AbstractSignedIntegerDataType

Basic implementation for a Signed Long Integer dataType

**Fields:**
- `dataType`: LongDataType

**Methods:**
- **new**()
- **new**(DataTypeManager dtm) *(overload 2)*
