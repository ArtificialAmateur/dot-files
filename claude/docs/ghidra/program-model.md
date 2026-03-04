<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Program Model

Address, Memory, Listing, Symbol — core program data model.

*Package(s): ghidra.program.model.address, ghidra.program.model.mem, ghidra.program.model.listing, ghidra.program.model.symbol*

## `AddressFactory`

**Methods:**
- `getAddress`(String addrString) → Address — Create an address from String
- `getAddress`(int spaceID, long offset) → Address *(overload 2)* — Get an address using the addressSpace with the given id and having the given offset
- `getAddressSet`(Address min, Address max) → AddressSet — Computes an address set from a start and end address that may span address spaces
- `getAddressSet`() → AddressSet *(overload 2)*
- `getAddressSpace`(String name) → AddressSpace
- `getAddressSpace`(int spaceID) → AddressSpace *(overload 2)*
- `getAddressSpaces`() → AddressSpace[]
- `getAllAddressSpaces`() → AddressSpace[] — Returns an array of all address spaces, including analysis spaces
- `getAllAddresses`(String addrString) → Address[] — Generates all reasonable memory addresses that can be interpreted from the given string
- `getAllAddresses`(String addrString, boolean caseSensitive) → Address[] *(overload 2)* — Generates all reasonable memory addresses that can be interpreted from the given string
- `getConstantAddress`(long offset) → Address — Returns an address in "constant" space with the given offset
- `getConstantSpace`() → AddressSpace
- `getDefaultAddressSpace`() → AddressSpace
- `getIndex`(Address addr) → int
- `getNumAddressSpaces`() → int
- `getPhysicalSpace`(AddressSpace space) → AddressSpace — Gets the physical address space associated with the given address space
- `getPhysicalSpaces`() → AddressSpace[] — Returns an array of all the physical address spaces
- `getRegisterSpace`() → AddressSpace
- `getStackSpace`() → AddressSpace
- `getUniqueSpace`() → AddressSpace
- `hasMultipleMemorySpaces`() → boolean
- `hasStaleOverlayCondition`() → boolean — Determine if this address factory contains a stale overlay address space whose name was recently changed
- `isValidAddress`(Address addr) → boolean — Tests if the given address is valid for at least one of the Address Spaces in this factory
- `oldGetAddressFromLong`(long value) → Address

## `Address` extends Comparable<Address>

An address represents a location in a program.  Conceptually, addresses consist of an "address space" and an offset within that space.  Many processors have only one "real" address space, but some have several spaces. Also, there are "artificial" address spaces used for analysis and representing ...

**Fields:**
- `NO_ADDRESS`: Address
- `EXT_FROM_ADDRESS`: Address
- `SEPARATOR_CHAR`: String = ':'
- `SEPARATOR`: String = ':'

**Methods:**
- `add`(long displacement) → Address — Creates a new address (possibly in a new space) by adding the displacement to this address
- `addNoWrap`(long displacement) → Address — Creates a new Address with a displacement relative to this Address
- `addNoWrap`(BigInteger displacement) → Address *(overload 2)*
- `addWrap`(long displacement) → Address — Creates a new address by adding the displacement to the current address
- `addWrapSpace`(long displacement) → Address — Creates a new address by adding the displacement to the current address
- `getAddress`(String addrString) → Address — Creates a new Address by parsing a String representation of an address
- `getAddressSpace`() → AddressSpace — Returns the address space associated with this address
- `getAddressableWordOffset`() → int — Get the addressable memory word offset which corresponds to this address
- `getNewAddress`(long byteOffset) → Address — Creates a new Address in this address's space with the given byte offset
- `getNewAddress`(long offset, boolean isAddressableWordOffset) → Address *(overload 2)* — Returns a new address in this address's space with the given offset
- `getNewTruncatedAddress`(long offset, boolean isAddressableWordOffset) → Address — Returns a new address in this address's space with the given offset
- `getOffset`() → int — Get the offset of this Address
- `getOffsetAsBigInteger`() → BigInteger — Get the offset of this Address as a BigInteger
- `getPhysicalAddress`() → Address — Returns the physical Address that corresponds to this Address
- `getPointerSize`() → int — Returns the number of bytes needed to form a pointer to this address
- `getSize`() → int — Returns the number of bits that are used to form the address
- `getUnsignedOffset`() → int — Get the address offset as an unsigned number
- `hasSameAddressSpace`(Address addr) → boolean — Return true if this address' address space is equal to the address space for addr
- `isConstantAddress`() → boolean — Returns true if this address represents a location in constant space
- `isExternalAddress`() → boolean — Returns true if this address represents an external location in the external address space
- `isHashAddress`() → boolean — Returns true if this address represents a location in the HASH space
- `isLoadedMemoryAddress`() → boolean — Returns true if this address represents an address in a loaded memory block
- `isMemoryAddress`() → boolean — Returns true if this address represents a location in memory
- `isNonLoadedMemoryAddress`() → boolean — Returns true if this address represents an address not loaded in real memory (i
- `isRegisterAddress`() → boolean — Returns true if this address represents a location in the register space
- `isStackAddress`() → boolean — Returns true if this address represents a location in stack space
- `isSuccessor`(Address addr) → boolean — Tests whether the given address immediately follows this address
- `isUniqueAddress`() → boolean — Returns true if this address represents a location in unique space
- `isVariableAddress`() → boolean — Returns true if this address represents a location in variable space
- static `max`(Address a, Address b) → Address — Return the maximum of two addresses using Address
- static `min`(Address a, Address b) → Address — Return the minimum of two addresses using Address
- `next`() → Address — Returns the address's successor
- `previous`() → Address — Returns the address's predecessor
- `subtract`(Address addr) → int — Calculates the displacement between two addresses (`this - addr`)
- `subtract`(long displacement) → Address *(overload 2)* — Creates a new address (possibly in a new space) by subtracting the displacement to this address
- `subtractNoWrap`(long displacement) → Address — Creates a new Address by subtracting displacement from the Address
- `subtractWrap`(long displacement) → Address — Creates a new address by subtracting the displacement from the current address
- `subtractWrapSpace`(long displacement) → Address — Creates a new address by subtracting the displacement from the current address

## `AddressSetView` extends Iterable<AddressRange>

Defines a read-only interface for an address set.

**Methods:**
- `contains`(Address addr) → boolean — Test if the address is contained within this set
- `contains`(Address start, Address end) → boolean *(overload 2)* — Test if the given address range is contained in this set
- `contains`(AddressSetView rangeSet) → boolean *(overload 3)* — Test if the given address set is a subset of this set
- `findFirstAddressInCommon`(AddressSetView set) → Address — Finds the first address in this collection that is also in the given addressSet
- `getAddressCountBefore`(Address address) → int — Returns the number of address in this address set before the given address
- `getAddressRanges`() → AddressRangeIterator
- `getAddressRanges`(boolean forward) → AddressRangeIterator *(overload 2)* — Returns an iterator over the ranges in the specified order
- `getAddressRanges`(Address start, boolean forward) → AddressRangeIterator *(overload 3)* — Returns an iterator of address ranges starting with the range that contains the given address
- `getAddresses`(boolean forward) → AddressIterator — Returns an iterator over all addresses in this set
- `getAddresses`(Address start, boolean forward) → AddressIterator *(overload 2)* — Returns an iterator over the addresses in this address set starting at the start address
- `getFirstRange`() → AddressRange — Returns the first range in this set or null if the set is empty
- `getLastRange`() → AddressRange — Returns the last range in this set or null if the set is empty
- `getMaxAddress`() → Address — Get the maximum address for this address set
- `getMinAddress`() → Address — Get the minimum address for this address set
- `getNumAddressRanges`() → int
- `getNumAddresses`() → int
- `getRangeContaining`(Address address) → AddressRange — Returns the range that contains the given address
- `hasSameAddresses`(AddressSetView view) → boolean — Returns true if the given address set contains the same set of addresses as this set
- `intersect`(AddressSetView view) → AddressSet — Computes the intersection of this address set with the given address set
- `intersectRange`(Address start, Address end) → AddressSet — Computes the intersection of this address set with the given address range
- `intersects`(AddressSetView addrSet) → boolean — Determine if this address set intersects with the specified address set
- `intersects`(Address start, Address end) → boolean *(overload 2)* — Determine if the start and end range intersects with the specified address set
- `isEmpty`() → boolean
- `iterator`() → Iterator<AddressRange> — Returns an iterator over the address ranges in this address set
- `iterator`(boolean forward) → Iterator<AddressRange> *(overload 2)* — Returns an iterator over the ranges in the specified order
- `iterator`(Address start, boolean forward) → Iterator<AddressRange> *(overload 3)* — Returns an iterator of address ranges starting with the range that contains the given address
- `spliterator`(boolean forward) → Spliterator<AddressRange> — Create a spliterator over the ranges, as in `iterator(boolean)`
- `spliterator`(Address start, boolean forward) → Spliterator<AddressRange> *(overload 2)* — Create a spliterator over the ranges, as in `iterator(boolean)`
- `stream`() → Stream<AddressRange> — Stream the ranges in this set
- `stream`(boolean forward) → Stream<AddressRange> *(overload 2)* — Stream the ranges in the set forward or backward
- `stream`(Address start, boolean forward) → Stream<AddressRange> *(overload 3)* — Stream the ranges in the set as in `iterator(Address, boolean)`
- `subtract`(AddressSetView addrSet) → AddressSet — Computes the difference of this address set with the given address set (this - set)
- static `trimEnd`(AddressSetView set, Address addr) → AddressSetView — Trim address set removing all addresses greater-than-or-equal to specified address based upon `Address` comparison
- static `trimStart`(AddressSetView set, Address addr) → AddressSetView — Trim address set removing all addresses less-than-or-equal to specified address based upon `Address` comparison
- `union`(AddressSetView addrSet) → AddressSet — Computes the union of this address set with the given address set
- `xor`(AddressSetView addrSet) → AddressSet — Computes the exclusive-or of this address set with the given set

## `SegmentedAddress` extends GenericAddress

Address class for dealing with (intel) segmented addresses.  The class itself is agnostic about the mapping from segmented encoding to flat address offset, it uses the SegmentedAddressSpace to perform this mapping. So the same class can be used to represent either a real-mode address or a protect...

**Methods:**
- `getNewAddress`(long byteOffset) → Address — Return a new segmented address
- `getSegment`() → int — Returns the segment value
- `getSegmentOffset`() → int — Returns the offset within the segment
- `normalize`(int seg) → SegmentedAddress — Returns a new address that is equivalent to this address using the given segment number

## `GenericAddress` extends Address

Generic implementation of the Address interface.  Consists of an Address Space, an offset, and a namespace id.

**Fields:**
- `STACK_ADDRESS_PREFIX`: String = 'Stack['
- `STACK_ADDRESS_SUFFIX`: String = ']'

## `AddressRange` extends Comparable<AddressRange>, Iterable<Address>

The AddressRange interface is used by any object that represents a contiguous inclusive range of addresses from a minimum address to a maximum address.  The entire range must fall within a single address space.   .. versionadded:: 2000-02-16

**Methods:**
- static `checkValidRange`(Address start, Address end) → void — Change the specified start and end addresses to see if they form a valid range within the same `AddressSpace`
- `contains`(Address addr) → boolean
- `getAddressSpace`() → AddressSpace
- `getBigLength`() → BigInteger
- `getLength`() → int
- `getMaxAddress`() → Address
- `getMinAddress`() → Address
- `intersect`(AddressRange range) → AddressRange — Computes the intersection of this range with another
- `intersectRange`(Address start, Address end) → AddressRange — Computes the intersection of this range with another
- `intersects`(AddressRange range) → boolean
- `intersects`(Address start, Address end) → boolean *(overload 2)*

## `AddressSpace` extends Comparable<AddressSpace>

The AddressSpace class is used to represent a unique context for addresses.  Programs can have multiple address spaces and address 0 in one space is not the same as address 0 in another space.

**Fields:**
- `TYPE_CONSTANT`: int = 0
- `TYPE_RAM`: int = 1
- `TYPE_CODE`: int = 2
- `TYPE_UNIQUE`: int = 3
- `TYPE_REGISTER`: int = 4
- `TYPE_STACK`: int = 5
- `TYPE_JOIN`: int = 6
- `TYPE_OTHER`: int = 7
- `TYPE_SYMBOL`: int = 9
- `TYPE_EXTERNAL`: int = 10
- `TYPE_VARIABLE`: int = 11
- `TYPE_DELETED`: int = 13
- `TYPE_UNKNOWN`: int = 14
- `TYPE_NONE`: int = 15
- `TYPE_IPTR_CONSTANT`: int = 0
- `TYPE_IPTR_INTERNAL`: int = 3
- `TYPE_IPTR_SPACEBASE`: int = 5
- `ID_SIZE_MASK`: int = 112
- `ID_SIZE_SHIFT`: int = 4
- `ID_TYPE_MASK`: int = 15
- `ID_UNIQUE_SHIFT`: int = 7
- `OTHER_SPACE`: AddressSpace
- `EXTERNAL_SPACE`: AddressSpace
- `VARIABLE_SPACE`: AddressSpace
- `HASH_SPACE`: AddressSpace
- `DEFAULT_REGISTER_SPACE`: AddressSpace

**Methods:**
- `add`(Address addr, long displacement) → Address — Creates a new address (possibly in a new space) by adding the given displacement from the given address
- `addNoWrap`(Address addr, long displacement) → Address — Creates a new address by adding displacement to the given address
- `addNoWrap`(GenericAddress addr, BigInteger displacement) → Address *(overload 2)* — Creates a new address by adding displacement to the given address
- `addWrap`(Address addr, long displacement) → Address — Creates a new address by adding displacement to the given address
- `addWrapSpace`(Address addr, long displacement) → Address — Creates a new address by adding the displacement to the given address
- `getAddress`(String addrString) → Address — Parses the String into an address within this address space
- `getAddress`(String addrString, boolean caseSensitive) → Address *(overload 2)* — Parses the String into an address within this address space
- `getAddress`(long byteOffset) → Address *(overload 3)* — Returns a new address in this space with the given byte offset
- `getAddress`(long offset, boolean isAddressableWordOffset) → Address *(overload 4)* — Returns a new address in this space with the given offset
- `getAddressInThisSpaceOnly`(long byteOffset) → Address — Get a byte address from this address space
- `getAddressableUnitSize`() → int
- `getAddressableWordOffset`(long byteOffset) → int — Get the addressable memory word offset which corresponds to the specified memory byte offset
- `getMaxAddress`() → Address — Get the maximum address allowed for this AddressSpace
- `getMinAddress`() → Address — Get the minimum address allowed for this AddressSpace
- `getName`() → String
- `getOverlayAddress`(Address addr) → Address — Get an address that is relative to this address space
- `getPhysicalSpace`() → AddressSpace — Returns the physical space associated with an address space
- `getPointerSize`() → int
- `getSize`() → int
- `getSpaceID`() → int — Get the ID for this space
- `getTruncatedAddress`(long offset, boolean isAddressableWordOffset) → Address — Returns a new address in this space with the given offset
- `getType`() → int
- `getUnique`() → int
- `hasMappedRegisters`() → boolean — Returns true if this space has registers that are mapped into it
- `hasSignedOffset`() → boolean
- `isConstantSpace`() → boolean
- `isExternalSpace`() → boolean
- `isHashSpace`() → boolean
- `isLoadedMemorySpace`() → boolean
- `isMemorySpace`() → boolean — NOTE: It is important to make the distinction between Loaded and Non-Loaded memory addresses
- `isNonLoadedMemorySpace`() → boolean
- `isOverlaySpace`() → boolean
- `isRegisterSpace`() → boolean
- `isStackSpace`() → boolean
- `isSuccessor`(Address addr1, Address addr2) → boolean
- `isUniqueSpace`() → boolean
- static `isValidName`(String name) → boolean — Determine if the specific name is a valid address space name (e
- `isValidRange`(long byteOffset, long length) → boolean — Check the specified address range for validity within this space
- `isVariableSpace`() → boolean
- `makeValidOffset`(long offset) → int — Tests if the offset if valid
- `showSpaceName`() → boolean
- `subtract`(Address addr1, Address addr2) → int — Calculates the displacement between addr1 and addr2 (addr1 - addr2)
- `subtract`(Address addr, long displacement) → Address *(overload 2)* — Creates a new address (possibly in a new space) by subtracting the given displacement from the given address
- `subtractNoWrap`(Address addr, long displacement) → Address — Creates a new address by subtracting displacement from addr's offset
- `subtractWrap`(Address addr, long displacement) → Address — Creates a new address by subtracting displacement from addr's offset
- `subtractWrapSpace`(Address addr, long displacement) → Address — Creates a new address by subtracting the displacement from the given address
- `truncateAddressableWordOffset`(long wordOffset) → int — Truncate the specified addressable unit/word offset within this space to produce a valid offset
- `truncateOffset`(long byteOffset) → int — Truncate the specified byte offset within this space to produce a valid offset

## `AddressSet` extends AddressSetView

Class for storing sets of addresses.  This implementation uses a red-black tree where each entry node in the tree stores an address range.  The key for an entry node is the minimum address of the range and the value is the maximum address of the range.

**Methods:**
- **new**() — Create a new empty Address Set
- **new**(AddressRange range) *(overload 2)* — Create a new Address Set from an address range
- **new**(Address start, Address end) *(overload 3)*
- **new**(Program program, Address start, Address end) *(overload 4)* — Creates a new Address set containing a single range
- **new**(AddressSetView set) *(overload 5)* — Create a new Address Set from an existing Address Set
- **new**(Address addr) *(overload 6)* — Create a new Address containing a single address
- `add`(Address address) → void — Adds the given address to this set
- `add`(AddressRange range) → void *(overload 2)* — Add an address range to this set
- `add`(Address start, Address end) → void *(overload 3)* — Adds the range to this set
- `add`(AddressSetView addressSet) → void *(overload 4)* — Add all addresses of the given AddressSet to this set
- `addRange`(Address start, Address end) → void — Adds the range to this set
- `addRange`(Program program, Address start, Address end) → void *(overload 2)* — Adds a range of addresses to this set
- `clear`() → void — Removes all addresses from the set
- `delete`(AddressRange range) → void — Deletes an address range from this set
- `delete`(Address start, Address end) → void *(overload 2)* — Deletes a range of addresses from this set
- `delete`(AddressSetView addressSet) → void *(overload 3)* — Delete all addresses in the given AddressSet from this set
- `deleteFromMin`(Address toAddr) → void — Delete all addresses from the minimum address in the set up to and including toAddr
- `deleteRange`(Address start, Address end) → void — Deletes a range of addresses from this set
- `deleteToMax`(Address fromAddr) → void — Delete all addresses starting at the fromAddr to the maximum address in the set
- `printRanges`() → String — Returns a string displaying the ranges in this set
- `toList`() → List<AddressRange> — Returns a list of the AddressRanges in this set

### `RangeCompare` (enum) extends Enum<AddressSet.RangeCompare>

**Fields:**
- `RANGE1_COMPLETELY_BEFORE_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_BEFORE_RANGE2_ENDS_INSIDE_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_BEFORE_RANGE2_ENDS_AT_RANGE2_END`: AddressSet.RangeCompare
- `RANGE1_STARTS_BEFORE_RANGE2_ENDS_AFTER_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_AT_RANGE2_ENDS_BEFORE_RANGE2`: AddressSet.RangeCompare
- `RANGE1_EQUALS_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_AT_RANGE2_ENDS_AFTER_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_INSIDE_RANGE2_ENDS_AT_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_INSIDE_RANGE2_ENDS_INSIDE_RANGE2`: AddressSet.RangeCompare
- `RANGE1_STARTS_INSIDE_RANGE2_ENDS_AFTER_RANGE2`: AddressSet.RangeCompare
- `RANGE1_COMPLETELY_AFTER_RANGE2`: AddressSet.RangeCompare

**Methods:**
- static `valueOf`(String name) → AddressSet.RangeCompare
- static `values`() → AddressSet.RangeCompare[]

### `AddressRangeIteratorAdapter` (internal) extends AddressRangeIterator

**Methods:**
- **new**(Iterator<RedBlackEntry<Address, Address>> iterator)

### `MyAddressIterator` (internal) extends AddressIterator

## `AddressRangeIterator` extends Iterator<AddressRange>, Iterable<AddressRange>

AddressRangeIterator is used to iterate over some set of addresses.

## `MemoryAccessException` extends UsrException

An MemoryAccessException indicates that the attempted memory access is not permitted.  (i.e. Readable/Writeable)

**Methods:**
- **new**() — Constructs an MemoryAccessException with no detail message
- **new**(String message) *(overload 2)* — Constructs an MemoryAccessException with the specified detail message
- **new**(String msg, Throwable cause) *(overload 3)* — Creates a `MemoryAccessException` with a message and cause

## `Memory` extends AddressSetView

`Memory` provides the ability to inspect and manage the memory model for a `Program`. In addition to conventional `MemoryBlock`s defined within physical memory `AddressSpace`s other special purpose memory block types may be defined (e.g., byte-mapped, bit-mapped, overlays, etc.).   All memory blo...

**Fields:**
- `GBYTE_SHIFT_FACTOR`: int = 30
- `GBYTE`: int = 1073741824
- `MAX_BINARY_SIZE_GB`: int = 16
- `MAX_BINARY_SIZE`: int = 17179869184
- `MAX_BLOCK_SIZE_GB`: int = 16
- `MAX_BLOCK_SIZE`: int = 17179869184

**Methods:**
- `convertToInitialized`(MemoryBlock uninitializedBlock, byte initialValue) → MemoryBlock — Convert an existing uninitialized block with an initialized block
- `convertToUninitialized`(MemoryBlock itializedBlock) → MemoryBlock
- `createBitMappedBlock`(String name, Address start, Address mappedAddress, long length, boolean overlay) → MemoryBlock — Create a bit-mapped overlay memory block and add it to this Memory
- `createBlock`(MemoryBlock block, String name, Address start, long length) → MemoryBlock — Creates a MemoryBlock at the given address with the same properties as block, and adds it to this Memory
- `createByteMappedBlock`(String name, Address start, Address mappedAddress, long length, ByteMappingScheme byteMappingScheme, boolean overlay) → MemoryBlock — Create a byte-mapped memory block and add it to this memory
- `createByteMappedBlock`(String name, Address start, Address mappedAddress, long length, boolean overlay) → MemoryBlock *(overload 2)* — Create a byte-mapped memory block and add it to this memory
- `createFileBytes`(String filename, long offset, long size, InputStream is_, TaskMonitor monitor) → FileBytes — Stores a sequence of bytes into the program
- `createInitializedBlock`(String name, Address start, InputStream is_, long length, TaskMonitor monitor, boolean overlay) → MemoryBlock — Create an initialized memory block based upon a data `InputStream` and add it to this Memory
- `createInitializedBlock`(String name, Address start, long size, byte initialValue, TaskMonitor monitor, boolean overlay) → MemoryBlock *(overload 2)* — Create an initialized memory block initialized and add it to this Memory
- `createInitializedBlock`(String name, Address start, FileBytes fileBytes, long offset, long size, boolean overlay) → MemoryBlock *(overload 3)* — Create an initialized memory block using bytes from a `FileBytes` object
- `createUninitializedBlock`(String name, Address start, long size, boolean overlay) → MemoryBlock — Create an uninitialized memory block and add it to this Memory
- `deleteFileBytes`(FileBytes fileBytes) → boolean — Deletes a stored sequence of file bytes
- `findBytes`(Address addr, byte[] bytes, byte[] masks, boolean forward, TaskMonitor monitor) → Address
- `findBytes`(Address startAddr, Address endAddr, byte[] bytes, byte[] masks, boolean forward, TaskMonitor monitor) → Address *(overload 2)*
- `getAddressSourceInfo`(Address address) → AddressSourceInfo — Returns information (`AddressSourceInfo`) about the byte source at the given address
- `getAllFileBytes`() → List<FileBytes> — Returns a list of all the stored original file bytes objects
- `getAllInitializedAddressSet`() → AddressSetView
- `getBlock`(Address addr) → MemoryBlock — Returns the Block which contains addr
- `getBlock`(String blockName) → MemoryBlock *(overload 2)* — Returns the Block with the specified blockName
- `getBlocks`() → MemoryBlock[]
- `getByte`(Address addr) → int — Get byte at addr
- `getBytes`(Address addr, byte[] dest) → int — Get dest
- `getBytes`(Address addr, byte[] dest, int destIndex, int size) → int *(overload 2)* — Get size number of bytes starting at the given address and populates dest starting at dIndex
- `getExecuteSet`() → AddressSetView
- `getInt`(Address addr) → int — Get the int at addr
- `getInt`(Address addr, boolean bigEndian) → int *(overload 2)* — Get the int at addr using the specified endian order
- `getInts`(Address addr, int[] dest) → int — Get dest
- `getInts`(Address addr, int[] dest, int dIndex, int nElem) → int *(overload 2)* — Get dest
- `getInts`(Address addr, int[] dest, int dIndex, int nElem, boolean isBigEndian) → int *(overload 3)* — Get dest
- `getLoadedAndInitializedAddressSet`() → AddressSetView
- `getLong`(Address addr) → int — Get the long at addr
- `getLong`(Address addr, boolean bigEndian) → int *(overload 2)* — Get the long at addr in the specified endian order
- `getLongs`(Address addr, long[] dest) → int — Get dest
- `getLongs`(Address addr, long[] dest, int dIndex, int nElem) → int *(overload 2)* — Get dest
- `getLongs`(Address addr, long[] dest, int dIndex, int nElem, boolean isBigEndian) → int *(overload 3)* — Get dest
- `getProgram`() → Program
- `getShort`(Address addr) → int — Get the short at addr
- `getShort`(Address addr, boolean bigEndian) → int *(overload 2)* — Get the short at addr using the specified endian order
- `getShorts`(Address addr, short[] dest) → int — Get dest
- `getShorts`(Address addr, short[] dest, int dIndex, int nElem) → int *(overload 2)* — Get dest
- `getShorts`(Address addr, short[] dest, int dIndex, int nElem, boolean isBigEndian) → int *(overload 3)* — Get dest
- `getSize`() → int
- `isBigEndian`() → boolean
- `isExternalBlockAddress`(Address addr) → boolean — Determine if the specified address is contained within the reserved EXTERNAL block (see `MemoryBlock
- static `isValidMemoryBlockName`(String name) → boolean — Validate the given block name: cannot be null, cannot be an empty string, cannot contain control characters (ASCII 0
- `join`(MemoryBlock blockOne, MemoryBlock blockTwo) → MemoryBlock — Join the two blocks to create a single memory block
- `locateAddressesForFileBytesOffset`(FileBytes fileBytes, long offset) → List<Address> — Gets a list of addresses where the byte at the given offset from the given FileBytes was loaded into memory
- `locateAddressesForFileOffset`(long fileOffset) → List<Address> — Gets a `List` of `addresses <Address>` that correspond to the given file offset
- `moveBlock`(MemoryBlock block, Address newStartAddr, TaskMonitor monitor) → void — Move the memory block containing source address to the destination address
- `removeBlock`(MemoryBlock block, TaskMonitor monitor) → void — Remove the memory block
- `setByte`(Address addr, byte value) → void — Write byte at addr
- `setBytes`(Address addr, byte[] source) → void — Write size bytes from values at addr
- `setBytes`(Address addr, byte[] source, int sIndex, int size) → void *(overload 2)* — Write an array of bytes
- `setInt`(Address addr, int value) → void — Write int at addr in the default endian order
- `setInt`(Address addr, int value, boolean bigEndian) → void *(overload 2)* — Write int at addr in the specified endian order
- `setLong`(Address addr, long value) → void — Write long at addr in the default endian order
- `setLong`(Address addr, long value, boolean bigEndian) → void *(overload 2)* — Write long at addr in the specified endian order
- `setShort`(Address addr, short value) → void — Write short at addr in default endian order
- `setShort`(Address addr, short value, boolean bigEndian) → void *(overload 2)* — Write short at addr in the specified endian order
- `split`(MemoryBlock block, Address addr) → void — Split a block at the given addr and create a new block starting at addr

## `MemoryBlock` extends Comparable<MemoryBlock>

Interface that defines a block in memory.

**Fields:**
- `EXTERNAL_BLOCK_NAME`: String = 'EXTERNAL'
- `ARTIFICIAL`: int = 16
- `VOLATILE`: int = 8
- `READ`: int = 4
- `WRITE`: int = 2
- `EXECUTE`: int = 1

**Methods:**
- `contains`(Address addr) → boolean — Return whether addr is contained in this block
- `getAddressRange`() → AddressRange — Get the address range that corresponds to this block
- `getByte`(Address addr) → int — Returns the byte at the given address in this block
- `getBytes`(Address addr, byte[] b) → int — Tries to get b
- `getBytes`(Address addr, byte[] b, int off, int len) → int *(overload 2)*
- `getComment`() → String — Get the comment associated with this block
- `getData`() → InputStream — Get memory data in the form of an InputStream
- `getEnd`() → Address — Return the end address of this block
- `getFlags`() → int — Returns block flags (i
- `getName`() → String — Get the name of this block
- `getSize`() → int — Get the number of bytes in this block
- `getSizeAsBigInteger`() → BigInteger — Get the number of bytes in this block
- `getSourceInfos`() → List<MemoryBlockSourceInfo> — Returns a list of `MemoryBlockSourceInfo` objects for this block
- `getSourceName`() → String — Get the name of the source of this memory block
- `getStart`() → Address — Return the starting address for this block
- `getType`() → MemoryBlockType — Get the type for this block: DEFAULT, BIT_MAPPED, or BYTE_MAPPED (see `MemoryBlockType`)
- `isArtificial`() → boolean — Returns the artificial attribute state of this block
- `isExecute`() → boolean — Returns the value of the execute property associated with this block
- `isExternalBlock`() → boolean — Returns true if this is a reserved EXTERNAL memory block based upon its name (see `MemoryBlock
- `isInitialized`() → boolean — Return whether this block has been initialized
- `isLoaded`() → boolean — Returns true if this memory block is a real loaded block (i
- `isMapped`() → boolean — Returns true if this is either a bit-mapped or byte-mapped block
- `isOverlay`() → boolean — Returns true if this is an overlay block (i
- `isRead`() → boolean — Returns the value of the read property associated with this block
- `isVolatile`() → boolean — Returns the volatile attribute state of this block
- `isWrite`() → boolean — Returns the value of the write property associated with this block
- `putByte`(Address addr, byte b) → void — Puts the given byte at the given address in this block
- `putBytes`(Address addr, byte[] b) → int — Tries to put b
- `putBytes`(Address addr, byte[] b, int off, int len) → int *(overload 2)* — Tries to put len bytes from the specified byte array to this block
- `setArtificial`(boolean a) → void — Sets the artificial attribute state associated with this block
- `setComment`(String comment) → void — Set the comment associated with this block
- `setExecute`(boolean e) → void — Sets the execute property associated with this block
- `setName`(String name) → void — Set the name for this block (See `isValidName(String)` for naming rules)
- `setPermissions`(boolean read, boolean write, boolean execute) → void — Sets the read, write, execute permissions on this block
- `setRead`(boolean r) → void — Sets the read property associated with this block
- `setSourceName`(String sourceName) → void — Sets the name of the source file that provided the data
- `setVolatile`(boolean v) → void — Sets the volatile attribute state associated of this block
- `setWrite`(boolean w) → void — Sets the write property associated with this block

## `Data` extends CodeUnit, Settings

Interface for interacting with data at an address in a program.

**Methods:**
- `addValueReference`(Address refAddr, RefType type) → void — Add a memory reference to the value
- `getBaseDataType`() → DataType — If the dataType is a typeDef, then the typeDef's base type is returned, otherwise, the datatType is returned
- `getComponent`(int index) → Data — Returns the immediate n'th component or null if none exists
- `getComponent`(int[] componentPath) → Data *(overload 2)* — Get a data item given  the index path
- `getComponentContaining`(int offset) → Data — Return the first immediate child component that contains the byte at the given offset
- `getComponentIndex`() → int — Get the index of this component in its parent
- `getComponentLevel`() → int — Get this data's component level in its hierarchy of components
- `getComponentPath`() → int[] — Get the component path if this is a component
- `getComponentPathName`() → String — Returns the component path name (dot notation) for this field
- `getComponentsContaining`(int offset) → List<Data> — Returns a list of all the immediate child components that contain the byte at the given offset
- `getDataType`() → DataType — Get the Data type for the data
- `getDefaultLabelPrefix`(DataTypeDisplayOptions options) → String — Returns the appropriate string to use as the default label prefix or null if it has no preferred default label prefix;
- `getDefaultValueRepresentation`() → String — Returns a string that represents the data value without markup
- `getFieldName`() → String — Get the field name of this data item if it is "inside" another data item, otherwise return null
- `getNumComponents`() → int — Return the number of components that make up this data item
- `getParent`() → Data — Get the immediate parent data item of this data item or null if this data item is not contained in another data item
- `getParentOffset`() → int — Get the offset of this Data item from the start of its immediate parent
- `getPathName`() → String — Returns the full path name (dot notation) for this field
- `getPrimitiveAt`(int offset) → Data — Returns the primitive component containing this offset (i
- `getRoot`() → Data — Get the highest level Data item in a hierarchy of structures containing this component
- `getRootOffset`() → int — Get the offset of this Data item from the start of the root data item of some hierarchy of structures
- `getValue`() → Object — Returns the value of this data as determined by the corresponding `DataType`
- `getValueClass`() → Class<?> — Get the class used to express the value of this data
- `getValueReferences`() → Reference[] — Get the references for the value
- `hasStringValue`() → boolean — Returns true if this data corresponds to string data
- `isArray`() → boolean — Returns true if this data item is an Array of DataTypes
- `isConstant`() → boolean — Determine if this data has explicitly been marked as constant
- `isDefined`() → boolean — Returns true if the data type is defined
- `isDynamic`() → boolean — Returns true if this data item is a dynamic DataType
- `isPointer`() → boolean — Returns true if this is a pointer, which implies getValue() will return an Object that is an Address
- `isStructure`() → boolean — Returns true if this data item is a Structure
- `isUnion`() → boolean — Returns true if this data item is a Union
- `isVolatile`() → boolean — Determine if this data has explicitly been marked as volatile
- `isWritable`() → boolean — Determine if this data has explicitly been marked as writable
- `removeValueReference`(Address refAddr) → void — Remove a reference to the value

## `Instruction` extends CodeUnit, ProcessorContext

Interface to define an instruction for a processor.

**Fields:**
- `INVALID_DEPTH_CHANGE`: int = 16777216
- `MAX_LENGTH_OVERRIDE`: int = 7

**Methods:**
- `clearFallThroughOverride`() → void — Restores this instruction's fallthrough address back to the default fallthrough for this instruction
- `getDefaultFallThrough`() → Address — Get the default fallthrough for this instruction
- `getDefaultFallThroughOffset`() → int — Get default fall-through offset in bytes from start of instruction to the fallthrough instruction
- `getDefaultFlows`() → Address[] — Get an array of Address objects for all default flows established by the underlying instruction prototype
- `getDefaultOperandRepresentation`(int opIndex) → String — Get the operand representation for the given operand index without markup
- `getDefaultOperandRepresentationList`(int opIndex) → List<Object> — Get the operand representation for the given operand index
- `getDelaySlotDepth`() → int — Get the number of delay slot instructions for this argument
- `getFallFrom`() → Address
- `getFallThrough`() → Address — Get the fallthrough for this instruction, factoring in any fallthrough override and delay slotted instructions
- `getFlowOverride`() → FlowOverride
- `getFlowType`() → FlowType
- `getFlows`() → Address[] — Get an array of Address objects for all flows other than a fall-through
- `getInputObjects`() → Object[] — Get the Input objects used by this instruction
- `getInstructionContext`() → InstructionContext
- `getNext`() → Instruction
- `getOpObjects`(int opIndex) → Object[] — Get objects used by this operand (Address, Scalar, Register
- `getOperandRefType`(int index) → RefType — Get the operand reference type for the given operand index
- `getOperandType`(int opIndex) → int — Get the type of a specific operand
- `getParsedBytes`() → byte[] — Get the actual bytes parsed when forming this instruction
- `getParsedLength`() → int — Get the actual number of bytes parsed when forming this instruction
- `getPcode`() → PcodeOp[] — Get an array of PCode operations (micro code) that this instruction performs
- `getPcode`(boolean includeOverrides) → PcodeOp[] *(overload 2)* — Get an array of PCode operations (micro code) that this instruction performs
- `getPcode`(int opIndex) → PcodeOp[] *(overload 3)* — Get an array of PCode operations (micro code) that a particular operand performs to compute its value
- `getPrevious`() → Instruction
- `getPrototype`() → InstructionPrototype
- `getRegister`(int opIndex) → Register — If operand is a pure Register, return the register
- `getResultObjects`() → Object[] — Get the Result objects produced/affected by this instruction These would probably only be Register or Address
- `getSeparator`(int opIndex) → String — Get the separator strings between an operand
- `hasFallthrough`() → boolean
- `isFallThroughOverridden`() → boolean
- `isFallthrough`() → boolean
- `isInDelaySlot`() → boolean
- `isLengthOverridden`() → boolean — Determine if an instruction length override has been set
- `setFallThrough`(Address addr) → void — Overrides the instruction's default fallthrough address to the given address
- `setFlowOverride`(FlowOverride flowOverride) → void — Set the flow override for this instruction
- `setLengthOverride`(int length) → void — Set instruction length override

## `Bookmark` extends Comparable<Bookmark>

Interface for bookmarks.  Bookmarks are locations that are marked within the program so that they can be easily found.

**Methods:**
- `getAddress`() → Address — Returns address at which this bookmark is applied
- `getCategory`() → String — Returns bookmark category
- `getComment`() → String — Returns bookmark comment
- `getId`() → int — Returns the id of the bookmark
- `getType`() → BookmarkType — Returns bookmark type object
- `getTypeString`() → String — Returns bookmark type as a string
- `set`(String category, String comment) → void — Set the category and comment associated with a bookmark

## `Program` extends DataTypeManagerDomainObject, ProgramArchitecture

This interface represents the main entry point into an object which stores all information relating to a single program.  This program model divides a program into four major parts: the memory, the symbol table, the equate table, and the listing.  Each of these parts has an extensive interface an...

**Fields:**
- `ANALYSIS_PROPERTIES`: String = 'Analyzers'
- `DISASSEMBLER_PROPERTIES`: String = 'Disassembler'
- `PROGRAM_INFO`: String = 'Program Information'
- `ANALYZED_OPTION_NAME`: String = 'Analyzed'
- `ASK_TO_ANALYZE_OPTION_NAME`: String = 'Should Ask To Analyze'
- `DATE_CREATED`: String = 'Date Created'
- `CREATED_WITH_GHIDRA_VERSION`: String = 'Created With Ghidra Version'
- `PREFERRED_ROOT_NAMESPACE_CATEGORY_PROPERTY`: String = 'Preferred Root Namespace Category'
- `ANALYSIS_START_DATE`: String = '2007-Jan-01'
- `ANALYSIS_START_DATE_FORMAT`: String = 'yyyy-MMM-dd'
- `JANUARY_1_1970`: Date
- `MAX_OPERANDS`: int = 16

**Methods:**
- `createAddressSetPropertyMap`(String name) → AddressSetPropertyMap — Create a new AddressSetPropertyMap with the specified name
- `createIntRangeMap`(String name) → IntRangeMap — Create a new IntRangeMap with the specified name
- `createOverlaySpace`(String overlaySpaceName, AddressSpace baseSpace) → ProgramOverlayAddressSpace — Create a new overlay space based upon the given base AddressSpace
- `deleteAddressSetPropertyMap`(String name) → void — Remove the property map from the program
- `deleteIntRangeMap`(String name) → void — Remove the property map from the program
- `getAddressFactory`() → AddressFactory — Returns the AddressFactory for this program
- `getAddressSetPropertyMap`(String name) → AddressSetPropertyMap — Get the property map with the given name
- `getBookmarkManager`() → BookmarkManager — Get the bookmark manager
- `getChanges`() → ProgramChangeSet — Get the program changes since the last save as a set of addresses
- `getCompiler`() → String — Gets the name of the compiler believed to have been used to create this program
- `getCompilerSpec`() → CompilerSpec — Returns the CompilerSpec currently used by this program
- `getCreationDate`() → Date — Returns the creation date of this program
- `getDataTypeManager`() → ProgramBasedDataTypeManager — Returns the program's datatype manager
- `getDefaultPointerSize`() → int — Gets the default pointer size in bytes as it may be stored within the program listing
- `getEquateTable`() → EquateTable — Get the equate table object
- `getExecutableFormat`() → String — Returns a value corresponding to the original file format
- `getExecutableMD5`() → String — Returns a value corresponding to the original binary file MD5 hash
- `getExecutablePath`() → String — Gets the path to the program's executable file
- `getExecutableSHA256`() → String — Returns a value corresponding to the original binary file SHA256 hash
- `getExternalManager`() → ExternalManager — Returns the external manager
- `getFunctionManager`() → FunctionManager — Returns the programs function manager
- `getGlobalNamespace`() → Namespace — Returns the global namespace for this program
- `getImageBase`() → Address — Returns the current program image base address
- `getIntRangeMap`(String name) → IntRangeMap — Get the property map with the given name
- `getLanguage`() → Language — Returns the language used by this program
- `getLanguageID`() → LanguageID — Return the name of the language used by this program
- `getListing`() → Listing — Get the listing object
- `getMaxAddress`() → Address — Get the programs maximum address
- `getMemory`() → Memory — Get the memory object
- `getMinAddress`() → Address — Get the program's minimum address
- `getPreferredRootNamespaceCategoryPath`() → CategoryPath
- `getProgramContext`() → ProgramContext — Returns the program context
- `getProgramUserData`() → ProgramUserData — Returns the user-specific data manager for this program
- `getReferenceManager`() → ReferenceManager — Get the reference manager
- `getRegister`(String name) → Register — Returns the register with the given name;
- `getRegister`(Address addr) → Register *(overload 2)* — Returns the largest register located at the specified address
- `getRegister`(Address addr, int size) → Register *(overload 3)* — Returns a specific register based upon its address and size
- `getRegister`(Varnode varnode) → Register *(overload 4)* — Returns the register which corresponds to the specified varnode
- `getRegisters`(Address addr) → Register[] — Returns all registers located at the specified address
- `getRelocationTable`() → RelocationTable — Gets the relocation table
- `getSourceFileManager`() → SourceFileManager — Returns the program's `SourceFileManager`
- `getSymbolTable`() → SymbolTable — Get the symbol table object
- `getUniqueProgramID`() → int — Returns an ID that is unique for this program
- `getUsrPropertyManager`() → PropertyMapManager — Get the user propertyMangager stored with this program
- `parseAddress`(String addrStr) → Address[] — Return an array of memory Addresses that could correspond to the given string
- `parseAddress`(String addrStr, boolean caseSensitive) → Address[] *(overload 2)* — Return an array of memory Addresses that could correspond to the given string
- `removeOverlaySpace`(String overlaySpaceName) → boolean — Remove the specified overlay address space from this program
- `renameOverlaySpace`(String overlaySpaceName, String newName) → void — Rename an existing overlay address space
- `restoreImageBase`() → void — Restores the last committed image base
- `setCompiler`(String compiler) → void — Sets the name of the compiler which created this program
- `setExecutableFormat`(String format) → void — Sets the value corresponding to the original file format
- `setExecutableMD5`(String md5) → void — Sets the value corresponding to the original binary file MD5 hash
- `setExecutablePath`(String path) → void — Sets the path to the program's executable file
- `setExecutableSHA256`(String sha256) → void — Sets the value corresponding to the original binary file SHA256 hash
- `setImageBase`(Address base, boolean commit) → void — Sets the program's image base address
- `setLanguage`(Language language, CompilerSpecID compilerSpecID, boolean forceRedisassembly, TaskMonitor monitor) → void — Sets the language for the program
- `setPreferredRootNamespaceCategoryPath`(String categoryPath) → void — Sets the preferred data type category path which corresponds to the root of a namespace hierarchy storage area

## `CodeUnit` extends MemBuffer, PropertySet

Interface common to both instructions and data.

**Fields:**
- `MNEMONIC`: int = -1
- `EOL_COMMENT`: int = 0
- `PRE_COMMENT`: int = 1
- `POST_COMMENT`: int = 2
- `PLATE_COMMENT`: int = 3
- `REPEATABLE_COMMENT`: int = 4
- `COMMENT_PROPERTY`: String = 'COMMENT__GHIDRA_'
- `SPACE_PROPERTY`: String = 'Space'
- `INSTRUCTION_PROPERTY`: String = 'INSTRUCTION__GHIDRA_'
- `DEFINED_DATA_PROPERTY`: String = 'DEFINED_DATA__GHIDRA_'

**Methods:**
- `addMnemonicReference`(Address refAddr, RefType refType, SourceType sourceType) → void — Add a reference to the mnemonic for this code unit
- `addOperandReference`(int index, Address refAddr, RefType type, SourceType sourceType) → void — Add a memory reference to the operand at the given index
- `contains`(Address testAddr) → boolean
- `getAddress`(int opIndex) → Address — Get the Address for the given operand index if one exists
- `getAddressString`(boolean showBlockName, boolean pad) → String — Get the string representation of the starting address for this code unit
- `getBytes`() → byte[] — Get the bytes that make up this code unit
- `getBytesInCodeUnit`(byte[] buffer, int bufferOffset) → void — Copies max(buffer
- `getComment`(CommentType type) → String — Get the comment for the given type
- `getCommentAsArray`(CommentType type) → String[] — Get the comment for the given type and parse it into an array of strings such that each line is its own string
- `getExternalReference`(int opIndex) → ExternalReference — Gets the external reference (if any) at the opIndex
- `getLabel`() → String
- `getLength`() → int — Get length of this code unit
- `getMaxAddress`() → Address
- `getMinAddress`() → Address
- `getMnemonicReferences`() → Reference[] — Get references for the mnemonic for this code unit
- `getMnemonicString`() → String
- `getNumOperands`() → int
- `getOperandReferences`(int index) → Reference[]
- `getPrimaryReference`(int index) → Reference
- `getPrimarySymbol`() → Symbol
- `getProgram`() → Program
- `getReferenceIteratorTo`() → ReferenceIterator
- `getReferencesFrom`() → Reference[] — Get ALL memory references FROM this code unit
- `getScalar`(int opIndex) → Scalar — Returns the scalar at the given operand index
- `getSymbols`() → Symbol[]
- `removeExternalReference`(int opIndex) → void — Remove external reference (if any) at the given opIndex
- `removeMnemonicReference`(Address refAddr) → void — Remove a reference to the mnemonic for this code unit
- `removeOperandReference`(int index, Address refAddr) → void — Remove a reference to the operand
- `setComment`(CommentType type, String comment) → void — Set the comment for the given comment type
- `setCommentAsArray`(CommentType type, String[] comment) → void — Set the comment (with each line in its own string) for the given comment type
- `setPrimaryMemoryReference`(Reference ref) → void — Sets a memory reference to be the primary reference at its address/opIndex location
- `setRegisterReference`(int opIndex, Register reg, SourceType sourceType, RefType refType) → void
- `setStackReference`(int opIndex, int offset, SourceType sourceType, RefType refType) → void

## `Function` extends Namespace

Interface to define methods available on a function. Functions have a single entry point.

**Fields:**
- `DEFAULT_PARAM_PREFIX`: String = 'param_'
- `THIS_PARAM_NAME`: String = 'this'
- `RETURN_PTR_PARAM_NAME`: String = '__return_storage_ptr__'
- `DEFAULT_PARAM_PREFIX_LEN`: int
- `DEFAULT_LOCAL_PREFIX`: String = 'local_'
- `DEFAULT_LOCAL_RESERVED_PREFIX`: String = 'local_res'
- `DEFAULT_LOCAL_TEMP_PREFIX`: String = 'temp_'
- `DEFAULT_LOCAL_PREFIX_LEN`: int
- `UNKNOWN_CALLING_CONVENTION_STRING`: String = 'unknown'
- `DEFAULT_CALLING_CONVENTION_STRING`: String = 'default'
- `INLINE`: String = 'inline'
- `NORETURN`: String = 'noreturn'
- `THUNK`: String = 'thunk'
- `UNKNOWN_STACK_DEPTH_CHANGE`: int = 2147483647
- `INVALID_STACK_DEPTH_CHANGE`: int = 2147483646

**Methods:**
- `addLocalVariable`(Variable var, SourceType source) → Variable — Adds a local variable to the function
- `addTag`(String name) → boolean — Adds the tag with the given name to this function; if one does not exist, one is created
- `getAllVariables`() → Variable[] — Returns an array of all local and parameter variables
- `getAutoParameterCount`() → int — Gets the number of auto-parameters for this function also included in the total count provided by `getParameterCount()`
- `getCallFixup`() → String — Returns the current call-fixup name set on this instruction or null if one has not been set
- `getCalledFunctions`(TaskMonitor monitor) → Set<Function> — Returns a set of functions that this function calls
- `getCallingConvention`() → PrototypeModel — Gets the calling convention prototype model for this function
- `getCallingConventionName`() → String — Gets the calling convention's name for this function
- `getCallingFunctions`(TaskMonitor monitor) → Set<Function> — Returns a set of functions that call this function
- `getComment`() → String — Get the comment for this function
- `getCommentAsArray`() → String[]
- `getEntryPoint`() → Address — Get the entry point for this function
- `getExternalLocation`() → ExternalLocation
- `getFunctionThunkAddresses`(boolean recursive) → Address[] — If this function is "Thunked", an array of Thunk Function entry points is returned
- `getLocalVariables`() → Variable[] — Get all local function variables
- `getLocalVariables`(VariableFilter filter) → Variable[] *(overload 2)* — Get all local function variables which satisfy the specified filter
- `getName`() → String — Get the name of this function
- `getParameter`(int ordinal) → Parameter — Returns the specified parameter including an auto-param at the specified ordinal
- `getParameterCount`() → int — Gets the total number of parameters for this function
- `getParameters`() → Parameter[] — Get all function parameters
- `getParameters`(VariableFilter filter) → Parameter[] *(overload 2)* — Get all function parameters which satisfy the specified filter
- `getProgram`() → Program — Get the program containing this function
- `getPrototypeString`(boolean formalSignature, boolean includeCallingConvention) → String — Return a string representation of the function signature
- `getRepeatableComment`() → String — Returns the repeatable comment for this function
- `getRepeatableCommentAsArray`() → String[] — Returns the repeatable comment as an array of strings
- `getReturn`() → Parameter — Get the Function's return type/storage represented by a Parameter object
- `getReturnType`() → DataType — Get the Function's return type
- `getSignature`() → FunctionSignature — Get the function's effective signature
- `getSignature`(boolean formalSignature) → FunctionSignature *(overload 2)* — Get the function's signature
- `getSignatureSource`() → SourceType
- `getStackFrame`() → StackFrame — Get the stack frame for this function
- `getStackPurgeSize`() → int — Get the change in the stack pointer resulting from calling this function
- `getTags`() → Set<FunctionTag> — Return all `FunctionTag` objects associated with this function
- `getThunkedFunction`(boolean recursive) → Function — If this function is a Thunk, this method returns the referenced function
- `getVariables`(VariableFilter filter) → Variable[] — Get all function variables which satisfy the specified filter
- `hasCustomVariableStorage`() → boolean
- `hasNoReturn`() → boolean
- `hasUnknownCallingConventionName`() → boolean — Determine if this signature has an unknown or unrecognized calling convention name
- `hasVarArgs`() → boolean — Returns true if this function has a variable argument list (VarArgs)
- `isDeleted`() → boolean — Determine if this function object has been deleted
- `isInline`() → boolean
- `isStackPurgeSizeValid`() → boolean — check if stack purge size is valid
- `isThunk`() → boolean
- `promoteLocalUserLabelsToGlobal`() → void — Changes all local user-defined labels for this function to global symbols
- `removeTag`(String name) → void — Removes the given tag from this function
- `removeVariable`(Variable var) → void — Removes the given variable from the function
- `replaceParameters`(List<Variable> params, Function.FunctionUpdateType updateType, boolean force, SourceType source) → void — Replace all current parameters with the given list of parameters
- `replaceParameters`(Function.FunctionUpdateType updateType, boolean force, SourceType source) → void *(overload 2)* — Replace all current parameters with the given list of parameters
- `setBody`(AddressSetView newBody) → void — Set the new body for this function
- `setCallFixup`(String name) → void — Set the named call-fixup for this function
- `setCallingConvention`(String name) → void — Sets the calling convention for this function to the named calling convention
- `setComment`(String comment) → void — Set the comment for this function
- `setCustomVariableStorage`(boolean hasCustomVariableStorage) → void — Set whether or not this function uses custom variable storage
- `setInline`(boolean isInline) → void — Sets whether or not this function is inline
- `setName`(String name, SourceType source) → void — Set the name of this function
- `setNoReturn`(boolean hasNoReturn) → void — Set whether or not this function has a return
- `setRepeatableComment`(String comment) → void — Set the repeatable comment for this function
- `setReturn`(DataType type, VariableStorage storage, SourceType source) → void — Set the return data-type and storage
- `setReturnType`(DataType type, SourceType source) → void — Set the function's return type
- `setSignatureSource`(SourceType signatureSource) → void
- `setStackPurgeSize`(int purgeSize) → void — Set the change in the stack pointer resulting from calling this function
- `setThunkedFunction`(Function thunkedFunction) → void — Set the currently Thunked Function or null to convert to a normal function
- `setVarArgs`(boolean hasVarArgs) → void — Set whether parameters can be passed as a VarArg (variable argument list)
- `updateFunction`(String callingConvention, Variable returnValue, Function.FunctionUpdateType updateType, boolean force, SourceType source) → void
- `updateFunction`(String callingConvention, Variable returnVar, List<Variable> newParams, Function.FunctionUpdateType updateType, boolean force, SourceType source) → void *(overload 2)*

### `FunctionUpdateType` (enum) extends Enum<Function.FunctionUpdateType>

**Fields:**
- `CUSTOM_STORAGE`: Function.FunctionUpdateType
- `DYNAMIC_STORAGE_FORMAL_PARAMS`: Function.FunctionUpdateType
- `DYNAMIC_STORAGE_ALL_PARAMS`: Function.FunctionUpdateType

**Methods:**
- static `valueOf`(String name) → Function.FunctionUpdateType
- static `values`() → Function.FunctionUpdateType[]

## `FunctionManager` extends ManagerDB

The manager for functions

**Methods:**
- `createFunction`(String name, Address entryPoint, AddressSetView body, SourceType source) → Function — Create a function with the given body at entry point within the global namespace
- `createFunction`(String name, Namespace nameSpace, Address entryPoint, AddressSetView body, SourceType source) → Function *(overload 2)* — Create a function with the given body at entry point
- `createThunkFunction`(String name, Namespace nameSpace, Address entryPoint, AddressSetView body, Function thunkedFunction, SourceType source) → Function — Create a thunk function with the given body at entry point
- `getCallingConvention`(String name) → PrototypeModel — Gets the prototype model of the calling convention with the specified name in this program
- `getCallingConventionNames`() → Collection<String> — Get the ordered list of defined calling convention names
- `getDefaultCallingConvention`() → PrototypeModel — Gets the default calling convention's prototype model in this program
- `getExternalFunctions`() → FunctionIterator — Get an iterator over all external functions
- `getFunction`(long key) → Function — Get a Function object by its key
- `getFunctionAt`(Address entryPoint) → Function — Get the function at entryPoint
- `getFunctionContaining`(Address addr) → Function — Get a function containing an address
- `getFunctionCount`() → int — Returns the total number of functions in the program including external functions
- `getFunctionTagManager`() → FunctionTagManager — Returns the function tag manager
- `getFunctions`(boolean forward) → FunctionIterator — Returns an iterator over all non-external functions in address (entry point) order
- `getFunctions`(Address start, boolean forward) → FunctionIterator *(overload 2)* — Get an iterator over non-external functions starting at an address and ordered by entry address
- `getFunctions`(AddressSetView asv, boolean forward) → FunctionIterator *(overload 3)* — Get an iterator over functions with entry points in the specified address set
- `getFunctionsNoStubs`(boolean forward) → FunctionIterator
- `getFunctionsNoStubs`(Address start, boolean forward) → FunctionIterator *(overload 2)*
- `getFunctionsNoStubs`(AddressSetView asv, boolean forward) → FunctionIterator *(overload 3)*
- `getFunctionsOverlapping`(AddressSetView set) → Iterator<Function> — Return an iterator over functions that overlap the given address set
- `getProgram`() → Program — Returns this manager's program
- `getReferencedFunction`(Address address) → Function — Get the function which resides at the specified address or is referenced from the specified address
- `getReferencedVariable`(Address instrAddr, Address storageAddr, int size, boolean isRead) → Variable — Attempts to determine which if any of the local functions variables are referenced by the specified reference
- `invalidateCache`(boolean all) → void — Clears all data caches
- `isInFunction`(Address addr) → boolean — Check if this address contains a function
- `moveAddressRange`(Address fromAddr, Address toAddr, long length, TaskMonitor monitor) → void — Move all objects within an address range to a new location
- `removeFunction`(Address entryPoint) → boolean — Remove a function defined at entryPoint

## `Listing`

This interface provides all the methods needed to create,delete, retrieve, modify code level constructs (CodeUnits, Macros, Fragments, and Modules).

**Fields:**
- `DEFAULT_TREE_NAME`: String = 'Program Tree'

**Methods:**
- `addInstructions`(InstructionSet instructionSet, boolean overwrite) → AddressSetView — Creates a complete set of instructions
- `clearAll`(boolean clearContext, TaskMonitor monitor) → void — Removes all CodeUnits, comments, properties, and references from the listing
- `clearCodeUnits`(Address startAddr, Address endAddr, boolean clearContext) → void
- `clearCodeUnits`(Address startAddr, Address endAddr, boolean clearContext, TaskMonitor monitor) → void *(overload 2)*
- `clearComments`(Address startAddr, Address endAddr) → void — Clears the comments in the given range
- `clearProperties`(Address startAddr, Address endAddr, TaskMonitor monitor) → void — Clears the properties in the given range
- `createData`(Address addr, DataType dataType, int length) → Data — Creates a new defined Data object of a given length at the given address
- `createData`(Address addr, DataType dataType) → Data *(overload 2)* — Creates a new defined Data object at the given address
- `createFunction`(String name, Address entryPoint, AddressSetView body, SourceType source) → Function — Create a function with an entry point and a body of addresses
- `createFunction`(String name, Namespace nameSpace, Address entryPoint, AddressSetView body, SourceType source) → Function *(overload 2)* — Create a function in the specified namespace with an entry point and a body of addresses
- `createInstruction`(Address addr, InstructionPrototype prototype, MemBuffer memBuf, ProcessorContextView context, int length) → Instruction — Creates a new Instruction object at the given address
- `createRootModule`(String treeName) → ProgramModule — Create a new tree that will be identified by the given name
- `getAllComments`(Address address) → CodeUnitComments — Get all the comments at the given address
- `getCodeUnitAfter`(Address addr) → CodeUnit — get the next code unit that starts at an address that is greater than the given address
- `getCodeUnitAt`(Address addr) → CodeUnit — get the code unit that starts at the given address
- `getCodeUnitBefore`(Address addr) → CodeUnit — get the next code unit that starts at an address that is less than the given address
- `getCodeUnitContaining`(Address addr) → CodeUnit — get the code unit that contains the given address
- `getCodeUnitIterator`(String property, boolean forward) → CodeUnitIterator — Get an iterator that contains all code units in the program which have the specified property type defined
- `getCodeUnitIterator`(String property, Address addr, boolean forward) → CodeUnitIterator *(overload 2)* — Get an iterator that contains the code units which have the specified property type defined
- `getCodeUnitIterator`(String property, AddressSetView addrSet, boolean forward) → CodeUnitIterator *(overload 3)* — Get an iterator that contains the code units which have the specified property type defined
- `getCodeUnits`(boolean forward) → CodeUnitIterator — get a CodeUnit iterator that will iterate over the entire address space
- `getCodeUnits`(Address addr, boolean forward) → CodeUnitIterator *(overload 2)* — Returns an iterator of the code units in this listing (in proper sequence), starting at the specified address
- `getCodeUnits`(AddressSetView addrSet, boolean forward) → CodeUnitIterator *(overload 3)* — Get an iterator over the address range(s)
- `getComment`(CommentType type, Address address) → String — Get the comment for the given type at the specified address
- `getCommentAddressCount`() → int — Returns the number of addresses where at least one comment type has been applied
- `getCommentAddressIterator`(CommentType type, AddressSetView addrSet, boolean forward) → AddressIterator — Get a forward iterator over addresses that have the specified comment type
- `getCommentAddressIterator`(AddressSetView addrSet, boolean forward) → AddressIterator *(overload 2)* — Get a forward iterator over addresses that have any type of comment
- `getCommentCodeUnitIterator`(CommentType type, AddressSetView addrSet) → CodeUnitIterator — Get a forward code unit iterator over code units that have the specified comment type
- `getCommentHistory`(Address addr, CommentType type) → CommentHistory[] — Get the comment history for comments at the given address
- `getData`(boolean forward) → DataIterator — get a Data iterator that will iterate over the entire address space; returning both defined and undefined Data objects
- `getData`(Address addr, boolean forward) → DataIterator *(overload 2)* — Returns an iterator of the data in this listing (in proper sequence), starting at the specified address
- `getData`(AddressSetView addrSet, boolean forward) → DataIterator *(overload 3)* — Get an iterator over the address range(s)
- `getDataAfter`(Address addr) → Data — get the closest Data object that starts at an address that is greater than the given address
- `getDataAt`(Address addr) → Data — get the Data (Defined or Undefined) that starts at the given address
- `getDataBefore`(Address addr) → Data — get the closest Data object that starts at an address that is less than the given address
- `getDataContaining`(Address addr) → Data
- `getDataTypeManager`() → DataTypeManager — Get the data type manager for the program
- `getDefaultRootModule`() → ProgramModule — Returns the root module for the default program tree
- `getDefinedCodeUnitAfter`(Address addr) → CodeUnit — Returns the next instruction or defined data after the given address;
- `getDefinedCodeUnitBefore`(Address addr) → CodeUnit — Returns the closest instruction or defined data that starts before the given address
- `getDefinedData`(boolean forward) → DataIterator — get a Data iterator that will iterate over the entire address space; returning only defined Data objects
- `getDefinedData`(Address addr, boolean forward) → DataIterator *(overload 2)* — Returns an iterator of the defined data in this listing (in proper sequence), starting at the specified address
- `getDefinedData`(AddressSetView addrSet, boolean forward) → DataIterator *(overload 3)* — Get an iterator over the address range(s)
- `getDefinedDataAfter`(Address addr) → Data — get the defined Data object that starts at an address that is greater than the given address
- `getDefinedDataAt`(Address addr) → Data — get the Data (defined) object that starts at the given address
- `getDefinedDataBefore`(Address addr) → Data — get the closest defined Data object that starts at an address that is less than the given address
- `getDefinedDataContaining`(Address addr) → Data — get the Data object that starts at the given address
- `getExternalFunctions`() → FunctionIterator — Get an iterator over all external functions
- `getFirstUndefinedData`(AddressSetView set, TaskMonitor monitor) → Data — Get the undefined Data object that falls within the set
- `getFragment`(String treeName, Address addr) → ProgramFragment — Returns the fragment containing the given address
- `getFragment`(String treeName, String name) → ProgramFragment *(overload 2)* — Returns the fragment with the given name
- `getFunctionAt`(Address entryPoint) → Function — Get a function with a given entry point
- `getFunctionContaining`(Address addr) → Function — Get a function containing an address
- `getFunctions`(String namespace, String name) → List<Function> — Returns a list of all functions with the given name in the given namespace
- `getFunctions`(boolean forward) → FunctionIterator *(overload 2)* — Get an iterator over all functions
- `getFunctions`(Address start, boolean forward) → FunctionIterator *(overload 3)* — Get an iterator over all functions starting at address
- `getFunctions`(AddressSetView asv, boolean forward) → FunctionIterator *(overload 4)* — Get an iterator over all functions with entry points in the address set
- `getGlobalFunctions`(String name) → List<Function> — Returns a list of all global functions with the given name
- `getInstructionAfter`(Address addr) → Instruction — get the closest Instruction that starts at an address that is greater than the given address
- `getInstructionAt`(Address addr) → Instruction — get the Instruction that starts at the given address
- `getInstructionBefore`(Address addr) → Instruction — get the closest Instruction that starts at an address that is less than the given address
- `getInstructionContaining`(Address addr) → Instruction — get the Instruction that contains the given address
- `getInstructions`(boolean forward) → InstructionIterator — get an Instruction iterator that will iterate over the entire address space
- `getInstructions`(Address addr, boolean forward) → InstructionIterator *(overload 2)* — Returns an iterator of the instructions in this listing (in proper sequence), starting at the specified address
- `getInstructions`(AddressSetView addrSet, boolean forward) → InstructionIterator *(overload 3)* — Get an Instruction iterator over the address range(s)
- `getModule`(String treeName, String name) → ProgramModule — Returns the module with the given name
- `getNumCodeUnits`() → int — gets the total number of CodeUnits (Instructions, defined Data, and undefined Data)
- `getNumDefinedData`() → int — gets the total number of defined Data objects in the listing
- `getNumInstructions`() → int — gets the total number of Instructions in the listing
- `getPropertyMap`(String propertyName) → PropertyMap<?> — Returns the PropertyMap associated with the given name
- `getRootModule`(String treeName) → ProgramModule — Gets the root module for a tree in this listing
- `getRootModule`(long treeID) → ProgramModule *(overload 2)* — Returns the root module of the program tree with the given name;
- `getTreeNames`() → String[] — Get the names of all the trees defined in this listing
- `getUndefinedDataAfter`(Address addr, TaskMonitor monitor) → Data — Get the undefined Data object that starts at an address that is greater than the given address
- `getUndefinedDataAt`(Address addr) → Data — get the Data (undefined) object that starts at the given address
- `getUndefinedDataBefore`(Address addr, TaskMonitor monitor) → Data — get the closest undefined Data object that starts at an address that is less than the given address
- `getUndefinedRanges`(AddressSetView set, boolean initializedMemoryOnly, TaskMonitor monitor) → AddressSetView — Get the address set which corresponds to all undefined code units within the specified set of address
- `getUserDefinedProperties`() → Iterator<String> — Returns an iterator over all user defined property names
- `isInFunction`(Address addr) → boolean — Check if an address is contained in a function
- `isUndefined`(Address start, Address end) → boolean — Checks if the given ranges consists entirely of undefined data
- `removeFunction`(Address entryPoint) → void — Remove a function a given entry point
- `removeTree`(String treeName) → boolean — Remove the tree rooted at the given name
- `removeUserDefinedProperty`(String propertyName) → void — Removes the entire property from the program
- `renameTree`(String oldName, String newName) → void — Rename the tree
- `setComment`(Address address, CommentType type, String comment) → void — Set the comment for the given comment type at the specified address

## `Reference` extends Comparable<Reference>

Base class to hold information about a referring address. Derived classes add what the address is referring to. A basic reference consists of a "from" address, the reference type, the operand index for where the reference is, and whether the reference is user defined.

**Fields:**
- `MNEMONIC`: int = -1
- `OTHER`: int = -2

**Methods:**
- `getFromAddress`() → Address
- `getOperandIndex`() → int — Get the operand index of where this reference was placed
- `getReferenceType`() → RefType
- `getSource`() → SourceType — Gets the source of this reference
- `getSymbolID`() → int — Get the symbol ID associated with this reference
- `getToAddress`() → Address
- `isEntryPointReference`() → boolean
- `isExternalReference`() → boolean
- `isMemoryReference`() → boolean
- `isMnemonicReference`() → boolean
- `isOffsetReference`() → boolean
- `isOperandReference`() → boolean
- `isPrimary`() → boolean
- `isRegisterReference`() → boolean
- `isShiftedReference`() → boolean
- `isStackReference`() → boolean

## `SourceType` (enum) extends Enum<SourceType>

`SourceType` provides a prioritized indication as to the general source of a specific markup made to a `Program`.  The priority of each defined source type may be used to restrict impact or protect the related markup.  Source types include: `.USER_DEFINED`, which is higher priority than `.IMPORTE...

**Fields:**
- `DEFAULT`: SourceType
- `ANALYSIS`: SourceType
- `AI`: SourceType
- `IMPORTED`: SourceType
- `USER_DEFINED`: SourceType

**Methods:**
- `getDisplayString`() → String
- `getPriority`() → int
- static `getSourceType`(int storageId) → SourceType — Get the SourceType which corresponds to the specified storage ID
- `getStorageId`() → int
- `isHigherOrEqualPriorityThan`(SourceType source) → boolean — Determine if this source type has the same or higher priority than the one being passed to this method as a parameter
- `isHigherPriorityThan`(SourceType source) → boolean — Determine if this source type has a higher priority than the one being passed to this method as a parameter
- `isLowerOrEqualPriorityThan`(SourceType source) → boolean — Determine if this source type has the same or lower priority than the one being passed to this method as a parameter
- `isLowerPriorityThan`(SourceType source) → boolean — Determine if this source type has a lower priority than the one being passed to this method as a parameter
- static `valueOf`(String name) → SourceType
- static `values`() → SourceType[]

## `RefType`

`RefType` defines reference types used to specify the nature of a directional relationship between a source-location and a destination-location where a "location" may correspond to a `Address`, `CodeUnit`, `CodeBlock` or other code related objects.  Reference types are generally identified as eit...

**Fields:**
- `INVALID`: FlowType
- `FLOW`: FlowType
- `FALL_THROUGH`: FlowType
- `UNCONDITIONAL_JUMP`: FlowType
- `CONDITIONAL_JUMP`: FlowType
- `UNCONDITIONAL_CALL`: FlowType
- `CONDITIONAL_CALL`: FlowType
- `TERMINATOR`: FlowType
- `COMPUTED_JUMP`: FlowType
- `CONDITIONAL_TERMINATOR`: FlowType
- `COMPUTED_CALL`: FlowType
- `CALL_TERMINATOR`: FlowType
- `COMPUTED_CALL_TERMINATOR`: FlowType
- `CONDITIONAL_CALL_TERMINATOR`: FlowType
- `CONDITIONAL_COMPUTED_CALL`: FlowType
- `CONDITIONAL_COMPUTED_JUMP`: FlowType
- `JUMP_TERMINATOR`: FlowType
- `INDIRECTION`: FlowType
- `CALL_OVERRIDE_UNCONDITIONAL`: FlowType
- `JUMP_OVERRIDE_UNCONDITIONAL`: FlowType
- `CALLOTHER_OVERRIDE_CALL`: FlowType
- `CALLOTHER_OVERRIDE_JUMP`: FlowType
- `THUNK`: RefType
- `DATA`: RefType
- `PARAM`: RefType
- `DATA_IND`: RefType
- `READ`: RefType
- `WRITE`: RefType
- `READ_WRITE`: RefType
- `READ_IND`: RefType
- `WRITE_IND`: RefType
- `READ_WRITE_IND`: RefType
- `EXTERNAL_REF`: RefType

**Methods:**
- `getDisplayString`() → String — Returns an easy to read display string for this ref type
- `getName`() → String — Returns name of ref-type
- `getValue`() → int — Get the int value for this RefType object
- `hasFallthrough`() → boolean — Returns true if this flow type can fall through
- `isCall`() → boolean — Returns true if the flow is call
- `isComputed`() → boolean — Returns true if the flow is a computed call or compute jump
- `isConditional`() → boolean — Returns true if the flow is a conditional call or jump
- `isData`() → boolean — Returns true if the reference is to data
- `isFallthrough`() → boolean — Return true if this flow type is one that does not cause a break in control flow
- `isFlow`() → boolean — Returns true if the reference is an instruction flow reference
- `isIndirect`() → boolean — Returns true if the reference is indirect
- `isJump`() → boolean — Returns true if the flow is jump
- `isOverride`() → boolean — True if this is an override reference
- `isRead`() → boolean — Returns true if the reference is a read
- `isTerminal`() → boolean — Returns true if this instruction terminates
- `isUnConditional`() → boolean — Returns true if the flow is an unconditional call or jump
- `isWrite`() → boolean — Returns true if the reference is a write

## `ReferenceManager`

Interface for managing references.

**Fields:**
- `MNEMONIC`: int = -1

**Methods:**
- `addExternalReference`(Address fromAddr, String libraryName, String extLabel, Address extAddr, SourceType source, int opIndex, RefType type) → Reference — Adds an external reference to an external symbol
- `addExternalReference`(Address fromAddr, Namespace extNamespace, String extLabel, Address extAddr, SourceType source, int opIndex, RefType type) → Reference *(overload 2)* — Adds an external reference
- `addExternalReference`(Address fromAddr, int opIndex, ExternalLocation location, SourceType source, RefType type) → Reference *(overload 3)* — Adds an external reference
- `addMemoryReference`(Address fromAddr, Address toAddr, RefType type, SourceType source, int opIndex) → Reference — Adds a memory reference
- `addOffsetMemReference`(Address fromAddr, Address toAddr, boolean toAddrIsBase, long offset, RefType type, SourceType source, int opIndex) → Reference — Add an offset memory reference
- `addReference`(Reference reference) → Reference — Add a memory, stack, register or external reference
- `addRegisterReference`(Address fromAddr, int opIndex, Register register, RefType type, SourceType source) → Reference — Add a reference to a register
- `addShiftedMemReference`(Address fromAddr, Address toAddr, int shiftValue, RefType type, SourceType source, int opIndex) → Reference
- `addStackReference`(Address fromAddr, int opIndex, int stackOffset, RefType type, SourceType source) → Reference — Add a reference to a stack location
- `delete`(Reference ref) → void — Deletes the given reference object
- `getExternalReferences`() → ReferenceIterator — Returns an iterator over all external space references
- `getFlowReferencesFrom`(Address addr) → Reference[] — Get all flow references from the given address
- `getPrimaryReferenceFrom`(Address addr, int opIndex) → Reference — Get the primary reference from the given address
- `getReference`(Address fromAddr, Address toAddr, int opIndex) → Reference — Get the reference that has the given from and to address, and operand index
- `getReferenceCountFrom`(Address fromAddr) → int — Returns the number of references from the specified `fromAddr`
- `getReferenceCountTo`(Address toAddr) → int — Returns the number of references to the specified `toAddr`
- `getReferenceDestinationCount`() → int — Return the number of references for "to" addresses
- `getReferenceDestinationIterator`(Address startAddr, boolean forward) → AddressIterator — Returns an iterator over all addresses that are the "To" address in a reference
- `getReferenceDestinationIterator`(AddressSetView addrSet, boolean forward) → AddressIterator *(overload 2)*
- `getReferenceIterator`(Address startAddr) → ReferenceIterator — Get an iterator over references starting with the specified fromAddr
- `getReferenceLevel`(Address toAddr) → int — Returns the reference level for the references to the given address
- `getReferenceSourceCount`() → int — Return the number of references for "from" addresses
- `getReferenceSourceIterator`(Address startAddr, boolean forward) → AddressIterator — Returns an iterator over addresses that are the "From" address in a reference
- `getReferenceSourceIterator`(AddressSetView addrSet, boolean forward) → AddressIterator *(overload 2)* — Returns an iterator over all addresses that are the "From" address in a reference, restricted by the given address set
- `getReferencedVariable`(Reference reference) → Variable — Returns the referenced function variable
- `getReferencesFrom`(Address addr) → Reference[] — Get all references "from" the specified addr
- `getReferencesFrom`(Address fromAddr, int opIndex) → Reference[] *(overload 2)* — Returns all references "from" the given fromAddr and operand (specified by opIndex)
- `getReferencesTo`(Variable var) → Reference[] — Returns all references to the given variable
- `getReferencesTo`(Address addr) → ReferenceIterator *(overload 2)* — Get an iterator over all references that have the given address as their "To" address
- `hasFlowReferencesFrom`(Address addr) → boolean — Return whether the given address has flow references from it
- `hasReferencesFrom`(Address fromAddr, int opIndex) → boolean — Returns true if there are any memory references at the given address/opIndex
- `hasReferencesFrom`(Address fromAddr) → boolean *(overload 2)* — Returns true if there are any memory references at the given address
- `hasReferencesTo`(Address toAddr) → boolean — Return true if a memory reference exists with the given "to" address
- `removeAllReferencesFrom`(Address beginAddr, Address endAddr) → void — Removes all references where "From address" is in the given range
- `removeAllReferencesFrom`(Address fromAddr) → void *(overload 2)* — Remove all stack, external, and memory references for the given from address
- `removeAllReferencesTo`(Address toAddr) → void — Remove all stack, external, and memory references for the given to address
- `removeAssociation`(Reference ref) → void — Removes any symbol associations with the given reference
- `setAssociation`(Symbol s, Reference ref) → void — Associates the given reference with the given symbol
- `setPrimary`(Reference ref, boolean isPrimary) → void — Set the given reference's primary attribute
- `updateRefType`(Reference ref, RefType refType) → Reference — Update the reference type on a memory reference

## `ExternalManager`

External manager interface. Defines methods for dealing with external programs and locations within those programs.

**Methods:**
- `addExtFunction`(String libraryName, String extLabel, Address extAddr, SourceType sourceType) → ExternalLocation
- `addExtFunction`(Namespace extNamespace, String extLabel, Address extAddr, SourceType sourceType) → ExternalLocation *(overload 2)*
- `addExtFunction`(Namespace extNamespace, String extLabel, Address extAddr, SourceType sourceType, boolean reuseExisting) → ExternalLocation *(overload 3)*
- `addExtLocation`(String libraryName, String extLabel, Address extAddr, SourceType sourceType) → ExternalLocation
- `addExtLocation`(Namespace extNamespace, String extLabel, Address extAddr, SourceType sourceType) → ExternalLocation *(overload 2)*
- `addExtLocation`(Namespace extNamespace, String extLabel, Address extAddr, SourceType sourceType, boolean reuseExisting) → ExternalLocation *(overload 3)*
- `addExternalLibraryName`(String libraryName, SourceType source) → Library — Adds a new external library name
- `contains`(String libraryName) → boolean — Determines if the indicated external library name is being managed (exists)
- `getExternalLibrary`(String libraryName) → Library — Get the Library which corresponds to the specified name
- `getExternalLibraryNames`() → String[] — Returns an array of all external names for which locations have been defined
- `getExternalLibraryPath`(String libraryName) → String — Returns the file pathname associated with an external name
- `getExternalLocation`(Symbol symbol) → ExternalLocation — Returns the external location associated with the given external symbol
- `getExternalLocations`(String libraryName) → ExternalLocationIterator — Get an iterator over all external locations associated with the specified Library
- `getExternalLocations`(Address memoryAddress) → ExternalLocationIterator *(overload 2)* — Get an iterator over all external locations which have been associated to the specified memory address
- `getExternalLocations`(String libraryName, String label) → Set<ExternalLocation> *(overload 3)* — Returns a set of External Locations matching the given label name in the specified Library
- `getExternalLocations`(Namespace namespace, String label) → Set<ExternalLocation> *(overload 4)* — Returns a set of External Locations matching the given label name in the given Namespace
- `getUniqueExternalLocation`(String libraryName, String label) → ExternalLocation — Returns the unique external location associated with the given library name and label
- `getUniqueExternalLocation`(Namespace namespace, String label) → ExternalLocation *(overload 2)* — Returns the unique external location associated with the given namespace and label
- `removeExternalLibrary`(String libraryName) → boolean — Removes external name if no associated ExternalLocation's exist
- `setExternalPath`(String libraryName, String pathname, boolean userDefined) → void — Sets the file pathname associated with an existing external name
- `updateExternalLibraryName`(String oldName, String newName, SourceType source) → void — Change the name of an existing external name

## `Namespace`

The Namespace interface

**Fields:**
- `GLOBAL_NAMESPACE_ID`: int = 0
- `DELIMITER`: String = '::'
- `NAMESPACE_DELIMITER`: String = '::'

**Methods:**
- `getBody`() → AddressSetView — Get the address set for this namespace
- `getID`() → int — Return the namespace id
- `getName`() → String — Get the name of the symbol for this scope
- `getName`(boolean includeNamespacePath) → String *(overload 2)* — Returns the fully qualified name
- `getParentNamespace`() → Namespace — Get the parent scope
- `getPathList`(boolean omitLibrary) → List<String> — Get the namespace path as a list of namespace names
- `getSymbol`() → Symbol — Get the symbol for this namespace
- `getType`() → Namespace.Type
- `isExternal`() → boolean — Returns true if this namespace is external (i
- `isGlobal`() → boolean — Return true if this is the global namespace
- `isLibrary`() → boolean — Return true if this is a library
- `setParentNamespace`(Namespace parentNamespace) → void — Set the parent namespace for this namespace

### `Type` (enum) extends Enum<Namespace.Type>

Type of `Namespace`.

**Fields:**
- `NAMESPACE`: Namespace.Type
- `LIBRARY`: Namespace.Type
- `CLASS`: Namespace.Type
- `FUNCTION`: Namespace.Type

**Methods:**
- `friendlyName`() → String
- static `valueOf`(String name) → Namespace.Type
- static `values`() → Namespace.Type[]

## `ExternalLocation`

`ExternalLocation` defines a location within an external program (i.e., library).  The external program is uniquely identified by a program name, and the location within the program is identified by label, address or both.

**Methods:**
- `createFunction`() → Function — Create an external function associated with this location or return the existing function if one already exists
- `getAddress`() → Address — Returns the external address if known, or null
- `getDataType`() → DataType — Returns the DataType which has been associated with this location
- `getExternalSpaceAddress`() → Address — Returns the address in "External" (fake) space where this location is stored
- `getFunction`() → Function — Returns the external function associated with this location or null if this is a data location
- `getLabel`() → String — Returns the external label associated with this location
- `getLibraryName`() → String — Returns the name of the external program containing this location
- `getOriginalImportedName`() → String — Returns the original name for this location
- `getParentName`() → String — Returns the name of the parent namespace containing this location
- `getParentNameSpace`() → Namespace — Returns the parent namespace containing this location
- `getSource`() → SourceType — Returns the source of this location
- `getSymbol`() → Symbol — Returns the symbol associated with this external location or null
- `isEquivalent`(ExternalLocation other) → boolean — Returns true if the given external location has the same name, namespace, original import name, and external address
- `isFunction`() → boolean
- `restoreOriginalName`() → void
- `setAddress`(Address address) → void — Sets the address in the external program associated with this location
- `setDataType`(DataType dt) → void — Associate the specified data type with this location
- `setLocation`(String label, Address addr, SourceType source) → void — Set the external label which defines this location
- `setName`(Namespace namespace, String name, SourceType sourceType) → void — Set a new name for this external location

## `SymbolTable`

A SymbolTable manages the Symbols defined in a program.   A Symbol is an association between an Address, a String name. In addition, symbols may have one or more References.   A Reference is a 4-tuple of a source address, destination address, type, and either a mnemonic or operand index.   Any ad...

**Methods:**
- `addExternalEntryPoint`(Address addr) → void — Add a memory address to the external entry points
- `convertNamespaceToClass`(Namespace namespace) → GhidraClass — Convert the given namespace to a class namespace
- `createClass`(Namespace parent, String name, SourceType source) → GhidraClass — Create a class namespace in the given parent namespace
- `createExternalLibrary`(String name, SourceType source) → Library — Create a library namespace with the given name
- `createLabel`(Address addr, String name, SourceType source) → Symbol — Create a label symbol with the given name in the global namespace and associated to the given memory address
- `createLabel`(Address addr, String name, Namespace namespace, SourceType source) → Symbol *(overload 2)* — Create a label symbol with the given name and namespace associated to the given memory address
- `createNameSpace`(Namespace parent, String name, SourceType source) → Namespace — Create a new namespace
- `getAllSymbols`(boolean includeDynamicSymbols) → SymbolIterator — Get all of the symbols, optionally including dynamic symbols
- `getChildren`(Symbol parentSymbol) → SymbolIterator — Get all symbols that have the given parent symbol   **NOTE:** The resulting iterator will not return default thunks (i
- `getClassNamespaces`() → Iterator<GhidraClass> — Get all class namespaces defined within the program, in no particular order
- `getClassSymbol`(String name, Namespace namespace) → Symbol — Get the class symbol with the given name in the given namespace
- `getDefinedSymbols`() → SymbolIterator — Get all defined symbols in no particular order
- `getDynamicSymbolID`(Address addr) → int
- `getExternalEntryPointIterator`() → AddressIterator — Get the external entry points (addresses)
- `getExternalSymbol`(String name) → Symbol — Get the external symbol with the given name
- `getExternalSymbols`(String name) → SymbolIterator — Get all the external symbols with the given name
- `getExternalSymbols`() → SymbolIterator *(overload 2)* — Get all defined external symbols in no particular order
- `getGlobalSymbol`(String name, Address addr) → Symbol — Get the global symbol with the given name and address
- `getGlobalSymbols`(String name) → List<Symbol> — Get a list of all global symbols with the given name
- `getLabelHistory`(Address addr) → LabelHistory[] — Get the label history for the given address   Each entry records a change made to the labels at the given address
- `getLabelHistory`() → Iterator<LabelHistory> *(overload 2)* — Get the complete label history of the program
- `getLabelOrFunctionSymbols`(String name, Namespace namespace) → List<Symbol> — Get all the label or function symbols that have the given name in the given parent namespace
- `getLibrarySymbol`(String name) → Symbol — Get the library symbol with the given name
- `getLocalVariableSymbol`(String name, Namespace namespace) → Symbol — Get the local variable symbol with the given name in the given namespace
- `getNamespace`(String name, Namespace namespace) → Namespace — Get the namespace with the given name in the given parent namespace
- `getNamespace`(Address addr) → Namespace *(overload 2)* — Get the deepest namespace containing the given address
- `getNamespaceSymbol`(String name, Namespace namespace) → Symbol — Get a generic namespace symbol with the given name in the given parent namespace
- `getNumSymbols`() → int — Get the total number of symbols in the table
- `getOrCreateNameSpace`(Namespace parent, String name, SourceType source) → Namespace
- `getParameterSymbol`(String name, Namespace namespace) → Symbol — Get the parameter symbol with the given name in the given namespace
- `getPrimarySymbol`(Address addr) → Symbol
- `getPrimarySymbolIterator`(boolean forward) → SymbolIterator — Get all primary label and function symbols defined within program memory address
- `getPrimarySymbolIterator`(Address startAddr, boolean forward) → SymbolIterator *(overload 2)*
- `getPrimarySymbolIterator`(AddressSetView addressSet, boolean forward) → SymbolIterator *(overload 3)* — Get primary label and function symbols within the given address set
- `getSymbol`(long symbolID) → Symbol — Get the symbol for the given symbol ID
- `getSymbol`(String name, Address addr, Namespace namespace) → Symbol *(overload 2)* — Get the symbol with the given name, address, and namespace
- `getSymbol`(Reference ref) → Symbol *(overload 3)* — Get the symbol that a given reference associates
- `getSymbolIterator`(String searchStr, boolean caseSensitive) → SymbolIterator
- `getSymbolIterator`() → SymbolIterator *(overload 2)* — Get all label symbols   Labels are defined on memory locations
- `getSymbolIterator`(boolean forward) → SymbolIterator *(overload 3)* — Get all the symbols defined with program memory
- `getSymbolIterator`(Address startAddr, boolean forward) → SymbolIterator *(overload 4)* — Get all the symbols starting at the specified memory address
- `getSymbols`(String name, Namespace namespace) → List<Symbol> — Get a list of all symbols with the given name in the given parent namespace
- `getSymbols`(String name) → SymbolIterator *(overload 2)* — Get all the symbols with the given name   **NOTE:** The resulting iterator will not return default thunks (i
- `getSymbols`(Address addr) → Symbol[] *(overload 3)* — Get all the symbols at the given address
- `getSymbols`(Namespace namespace) → SymbolIterator *(overload 4)*
- `getSymbols`(long namespaceID) → SymbolIterator *(overload 5)*
- `getSymbols`(AddressSetView addressSet, SymbolType type, boolean forward) → SymbolIterator *(overload 6)* — Get all the symbols of the given type within the given address set
- `getSymbolsAsIterator`(Address addr) → SymbolIterator — Get an iterator over the symbols at the given address
- `getUserSymbols`(Address addr) → Symbol[] — Get an array of defined symbols at the given address (i
- `getVariableSymbol`(String name, Function function) → Symbol — Get a symbol that is either a parameter or local variable
- `hasLabelHistory`(Address addr) → boolean — Check if there is a history of label changes at the given address
- `hasSymbol`(Address addr) → boolean — Check if there exists any symbol at the given address
- `isExternalEntryPoint`(Address addr) → boolean — Check if the given address is an external entry point
- `removeExternalEntryPoint`(Address addr) → void — Remove an address from the external entry points
- `removeSymbolSpecial`(Symbol sym) → boolean — Removes the specified symbol from the symbol table
- `scanSymbolsByName`(String startName) → SymbolIterator

## `FlowType` extends RefType

Class to define flow types for instruction (how it flows from one instruction to the next)

### `Builder` (internal)

## `Symbol`

Interface for a symbol, which associates a string value with an address.

**Methods:**
- `delete`() → boolean — Delete the symbol and its associated resources
- `getAddress`() → Address
- `getID`() → int
- `getName`() → String
- `getName`(boolean includeNamespace) → String *(overload 2)* — Returns the symbol name, optionally prepended with the namespace path
- `getObject`() → Object
- `getParentNamespace`() → Namespace — Return the parent namespace for this symbol
- `getParentSymbol`() → Symbol — Returns namespace symbol of the namespace containing this symbol
- `getPath`() → String[] — Gets the full path name for this symbol as an ordered array of strings ending with the symbol name
- `getProgram`() → Program — Get the program associated with this symbol
- `getProgramLocation`() → ProgramLocation — Returns a program location for this symbol; may be null
- `getReferenceCount`() → int — Get the number of References to this symbol or its address
- `getReferences`(TaskMonitor monitor) → Reference[] — Returns all memory references to the address of this symbol
- `getReferences`() → Reference[] *(overload 2)* — Returns all memory references to the address of this symbol
- `getSource`() → SourceType — Gets the source of this symbol
- `getSymbolType`() → SymbolType — Returns this symbol's type
- `hasReferences`() → boolean
- `isDeleted`() → boolean — Determine if this symbol object has been deleted
- `isDescendant`(Namespace namespace) → boolean — Returns true if the given namespace symbol is a descendant of this symbol
- `isDynamic`() → boolean
- `isExternal`() → boolean — Returns true if this an external symbol
- `isExternalEntryPoint`() → boolean
- `isGlobal`() → boolean
- `isPinned`() → boolean — Returns true if the symbol is pinned to its current address
- `isPrimary`() → boolean
- `isValidParent`(Namespace parent) → boolean — Determines if the given parent is valid for this Symbol
- `setName`(String newName, SourceType source) → void — Sets the name this symbol
- `setNameAndNamespace`(String newName, Namespace newNamespace, SourceType source) → void — Sets the symbols name and namespace
- `setNamespace`(Namespace newNamespace) → void — Sets the symbols namespace
- `setPinned`(boolean pinned) → void — Sets whether or not this symbol is pinned to its associated address
- `setPrimary`() → boolean — Sets this symbol to be primary
- `setSource`(SourceType source) → void — Sets the source of this symbol
