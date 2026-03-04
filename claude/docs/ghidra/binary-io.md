<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Binary I/O

ByteProvider, BinaryReader, and binary data utilities.

*Package(s): ghidra.app.util.bin*

## `ByteProviderWrapper` extends ByteProvider

A `ByteProvider` constrained to a sub-section of an existing `ByteProvider`.

**Methods:**
- **new**(ByteProvider provider, FSRL fsrl)
- **new**(ByteProvider provider, long subOffset, long subLength) *(overload 2)* — Constructs a `ByteProviderWrapper` around the specified `ByteProvider`, constrained to a subsection of the provider
- **new**(ByteProvider provider, long subOffset, long subLength, FSRL fsrl) *(overload 3)* — Constructs a `ByteProviderWrapper` around the specified `ByteProvider`, constrained to a subsection of the provider

## `FileBytesProvider` extends ByteProvider

`FileBytesProvider` provides a `ByteProvider` implementation for `FileBytes` object.

**Methods:**
- **new**(FileBytes fileBytes) — Construct byte provider from original file bytes

### `FileBytesProviderInputStream` (internal) extends InputStream

## `ByteArrayConverter`

An interface to convert from a object to a byte array.

**Methods:**
- `toBytes`(DataConverter dc) → byte[] — Returns a byte array representing this implementor of this interface

## `InvalidDataException` extends IOException

An `IOException` that indicates that the data being transmitted was invalid or bad format.

**Methods:**
- **new**()
- **new**(String message) *(overload 2)*
- **new**(Throwable cause) *(overload 3)*
- **new**(String message, Throwable cause) *(overload 4)*

## `ByteProvider`

An interface for a generic random-access byte provider.

**Fields:**
- `EMPTY_BYTEPROVIDER`: ByteProvider

**Methods:**
- `close`() → void — Releases any resources the `ByteProvider` may have occupied
- `getAbsolutePath`() → String — Returns the absolute path (similar to, but not a, URI) to the `ByteProvider`
- `getFSRL`() → FSRL
- `getFile`() → File — Returns the underlying `File` for this `ByteProvider`, or null if this `ByteProvider` is not associated with a `File`
- `getInputStream`(long index) → InputStream — Returns an input stream to the underlying byte provider starting at the specified index
- `getName`() → String — Returns the name of the `ByteProvider`
- `isEmpty`() → boolean — Returns true if this ByteProvider does not contain any bytes
- `isValidIndex`(long index) → boolean — Returns true if the specified index is valid
- `length`() → int — Returns the length of the `ByteProvider`
- `readByte`(long index) → int — Reads a byte at the specified index
- `readBytes`(long index, long length) → byte[] — Reads a byte array at the specified index

## `InputStreamByteProvider` extends ByteProvider

A `ByteProvider` implementation that wraps an `InputStream`, allowing data to be read, as long as there are no operations that request data from a previous offset.   In other words, this `ByteProvider` can only be used to read data at ever increasing offsets.

**Methods:**
- **new**(InputStream inputStream, long length) — Constructs a `InputStreamByteProvider` from the specified `InputStream`
- `getUnderlyingInputStream`() → InputStream

## `BinaryReader`

A class for reading data from a generic byte provider in either big-endian or little-endian.

**Fields:**
- `SIZEOF_BYTE`: int = 1
- `SIZEOF_SHORT`: int = 2
- `SIZEOF_INT`: int = 4
- `SIZEOF_LONG`: int = 8

**Methods:**
- **new**(ByteProvider provider, boolean isLittleEndian) — Constructs a reader using the given ByteProvider and endian-order
- **new**(ByteProvider provider, DataConverter converter, long initialIndex) *(overload 2)* — Creates a BinaryReader instance
- `align`(int alignValue) → int — Advances the current index so that it aligns to the specified value (if not already aligned)
- `asBigEndian`() → BinaryReader — Returns a BinaryReader that is in BigEndian mode
- `asLittleEndian`() → BinaryReader — Returns a BinaryReader that is in LittleEndian mode
- `getByteProvider`() → ByteProvider — Returns the underlying byte provider
- `getInputStream`() → InputStream — Returns an InputStream that is a live view of the BinaryReader's position
- `getPointerIndex`() → int — Returns the current index value
- `hasNext`() → boolean — Returns true if this stream has data that could be read at the current position
- `hasNext`(int count) → boolean *(overload 2)* — Returns true if this stream has data that could be read at the current position
- `isBigEndian`() → boolean — Returns true if this reader will extract values in big endian
- `isLittleEndian`() → boolean — Returns true if this reader will extract values in little endian, otherwise in big endian
- `isValidIndex`(int index) → boolean — Returns true if the specified unsigned int32 index into the underlying byte provider is valid
- `isValidIndex`(long index) → boolean *(overload 2)* — Returns true if the specified index into the underlying byte provider is valid
- `isValidRange`(long startIndex, int count) → boolean — Returns true if the specified range is valid and does not wrap around the end of the index space
- `length`() → int — Returns the length of the underlying file
- `peekNextByte`() → int — Peeks at the next byte without incrementing the current index
- `peekNextInt`() → int — Peeks at the next integer without incrementing the current index
- `peekNextLong`() → int — Peeks at the next long without incrementing the current index
- `peekNextShort`() → int — Peeks at the next short without incrementing the current index
- `readAsciiString`(long index) → String — Reads a null terminated US-ASCII string, starting at specified index, stopping at the first null character
- `readAsciiString`(long index, int length) → String *(overload 2)* — Reads an fixed length US-ASCII string starting at `index`
- `readByte`(long index) → int — Returns the signed BYTE at `index`
- `readByteArray`(long index, int nElements) → byte[] — Returns the BYTE array of `nElements` starting at `index`
- `readInt`(long index) → int — Returns the signed INTEGER at `index`
- `readInt`(DataConverter dc, long index) → int *(overload 2)* — Returns the signed INTEGER at `index`
- `readIntArray`(long index, int nElements) → int[] — Returns the INTEGER array of `nElements` starting at `index`
- `readLong`(long index) → int — Returns the signed LONG at `index`
- `readLong`(DataConverter dc, long index) → int *(overload 2)* — Returns the signed LONG at `index`
- `readLongArray`(long index, int nElements) → long[] — Returns the LONG array of `nElements` starting at `index`
- `readNext`(BinaryReader.ReaderFunction<T> func) → T — Reads an object from the current position, using the supplied reader function
- `readNext`(BinaryReader.InputStreamReaderFunction<T> func) → T *(overload 2)* — Reads an object from the current position, using the supplied reader function
- `readNextAsciiString`() → String
- `readNextAsciiString`(int length) → String *(overload 2)*
- `readNextByte`() → int — Reads the byte at the current index and then increments the current index by `SIZEOF_BYTE`
- `readNextByteArray`(int nElements) → byte[]
- `readNextInt`() → int — Reads the integer at the current index and then increments the current index by `SIZEOF_INT`
- `readNextInt`(DataConverter dc) → int *(overload 2)* — Reads the integer at the current index and then increments the current index by `SIZEOF_INT`
- `readNextIntArray`(int nElements) → int[]
- `readNextLong`() → int — Reads the long at the current index and then increments the current index by `SIZEOF_LONG`
- `readNextLong`(DataConverter dc) → int *(overload 2)* — Reads the long at the current index and then increments the current index by `SIZEOF_LONG`
- `readNextLongArray`(int nElements) → long[]
- `readNextShort`() → int — Reads the short at the current index and then increments the current index by `SIZEOF_SHORT`
- `readNextShort`(DataConverter dc) → int *(overload 2)* — Reads the short at the current index and then increments the current index by `SIZEOF_SHORT`
- `readNextShortArray`(int nElements) → short[]
- `readNextString`(Charset charset, int charLen) → String
- `readNextString`(int charCount, Charset charset, int charLen) → String *(overload 2)*
- `readNextUnicodeString`() → String
- `readNextUnicodeString`(int charCount) → String *(overload 2)*
- `readNextUnsignedByte`() → int — Reads the unsigned byte at the current index and then increments the current index by `SIZEOF_BYTE`
- `readNextUnsignedInt`() → int — Reads the unsigned integer at the current index and then increments the current index by `SIZEOF_INT`
- `readNextUnsignedInt`(DataConverter dc) → int *(overload 2)* — Reads the unsigned integer at the current index and then increments the current index by `SIZEOF_INT`
- `readNextUnsignedIntExact`() → int — Reads an unsigned int32 value, and returns it as a java int (instead of a java long)
- `readNextUnsignedIntExact`(DataConverter dc) → int *(overload 2)* — Reads an unsigned int32 value, and returns it as a java int (instead of a java long)
- `readNextUnsignedShort`() → int — Reads the unsigned short at the current index and then increments the current index by `SIZEOF_SHORT`
- `readNextUnsignedShort`(DataConverter dc) → int *(overload 2)* — Reads the unsigned short at the current index and then increments the current index by `SIZEOF_SHORT`
- `readNextUnsignedValue`(int len) → int — Returns the unsigned value of the integer (of the specified length) at the current index
- `readNextUnsignedValue`(DataConverter dc, int len) → int *(overload 2)* — Returns the unsigned value of the integer (of the specified length) at the current index
- `readNextUnsignedVarIntExact`(BinaryReader.ReaderFunction<Long> func) → int
- `readNextUnsignedVarIntExact`(BinaryReader.InputStreamReaderFunction<Long> func) → int *(overload 2)*
- `readNextUtf8String`() → String
- `readNextUtf8String`(int length) → String *(overload 2)*
- `readNextValue`(int len) → int — Returns the signed value of the integer (of the specified length) at the current index
- `readNextValue`(DataConverter dc, int len) → int *(overload 2)* — Returns the signed value of the integer (of the specified length) at the current index
- `readNextVarInt`(BinaryReader.ReaderFunction<Long> func) → int
- `readNextVarInt`(BinaryReader.InputStreamReaderFunction<Long> func) → int *(overload 2)*
- `readShort`(long index) → int — Returns the signed SHORT at `index`
- `readShort`(DataConverter dc, long index) → int *(overload 2)* — Returns the signed SHORT at `index`
- `readShortArray`(long index, int nElements) → short[] — Returns the SHORT array of `nElements` starting at `index`
- `readString`(long index, int charCount, Charset charset, int charLen) → String — Reads a fixed length string of `charCount` characters starting at `index`, using a specific `Charset`
- `readString`(long index, Charset charset, int charLen) → String *(overload 2)* — Reads a null-terminated string starting at `index`, using a specific `Charset`
- `readUnicodeString`(long index) → String — Reads a null-terminated UTF-16 Unicode string starting at `index` and using the pre-specified `endianness`
- `readUnicodeString`(long index, int charCount) → String *(overload 2)*
- `readUnsignedByte`(long index) → int — Returns the unsigned BYTE at `index`
- `readUnsignedInt`(long index) → int — Returns the unsigned INTEGER at `index`
- `readUnsignedInt`(DataConverter dc, long index) → int *(overload 2)* — Returns the unsigned INTEGER at `index`
- `readUnsignedShort`(long index) → int — Returns the unsigned SHORT at `index`
- `readUnsignedShort`(DataConverter dc, long index) → int *(overload 2)* — Returns the unsigned SHORT at `index`
- `readUnsignedValue`(long index, int len) → int — Returns the unsigned value of the integer (of the specified length) at the specified offset
- `readUnsignedValue`(DataConverter dc, long index, int len) → int *(overload 2)* — Returns the unsigned value of the integer (of the specified length) at the specified offset
- `readUtf8String`(long index) → String — Reads a null-terminated UTF-8 string starting at `index`
- `readUtf8String`(long index, int length) → String *(overload 2)* — Reads a fixed length UTF-8 string of `length` bytes starting at `index`
- `readValue`(long index, int len) → int — Returns the signed value of the integer (of the specified length) at the specified offset
- `readValue`(DataConverter dc, long index, int len) → int *(overload 2)* — Returns the signed value of the integer (of the specified length) at the specified offset
- `setLittleEndian`(boolean isLittleEndian) → void — Sets the endian of this binary reader
- `setPointerIndex`(int index) → int — A convenience method for setting the index using a 32 bit integer
- `setPointerIndex`(long index) → int *(overload 2)* — Sets the current index to the specified value

### `ReaderFunction`

Reads and returns an object from the current position in the specified BinaryReader.   When reading from the BinaryReader, use "readNext" methods to consume the location where the object was located.   See `get(BinaryReader)`

**Methods:**
- `get`(BinaryReader reader) → T — Reads from the specified `BinaryReader` and returns a new object instance

### `InputStreamReaderFunction`

Reads and returns an object from the current position in the specified input stream.

**Methods:**
- `get`(InputStream is_) → T — Reads from the specified input stream and returns a new object instance

### `BinaryReaderInputStream` (internal) extends InputStream

Adapter between this BinaryReader and a InputStream.

## `StructConverter`

Allows a class to create a structure datatype equivalent to its class members.

**Fields:**
- `BYTE`: DataType
- `WORD`: DataType
- `DWORD`: DataType
- `QWORD`: DataType
- `ASCII`: DataType
- `STRING`: DataType
- `UTF8`: DataType
- `UTF16`: DataType
- `POINTER`: DataType
- `VOID`: DataType
- `IBO32`: DataType
- `IBO64`: DataType
- `ULEB128`: UnsignedLeb128DataType
- `SLEB128`: SignedLeb128DataType

**Methods:**
- static `setEndian`(Data data, boolean bigEndian) → void — Recursively sets the given `Data` and its components to big/little endian
- `toDataType`() → DataType — Returns a structure datatype representing the contents of the implementor of this interface

## `ObfuscatedInputStream` extends InputStream

An `InputStream` wrapper that de-obfuscates the bytes being read from the underlying stream.

**Methods:**
- **new**(InputStream delegate) — Creates instance
- static `main`(String[] args) → void — Entry point to enable command line users to retrieve the contents of an obfuscated file

## `ObfuscatedOutputStream` extends OutputStream

An `OutputStream` wrapper that obfuscates the bytes being written to the underlying stream.

**Methods:**
- **new**(OutputStream delegate) — Creates instance
