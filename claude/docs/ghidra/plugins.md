<!-- Extracted from Ghidra 12.1 DEV, 2026-02-27 -->
# Plugins & Framework

Plugin framework, domain objects, and project model.

*Package(s): ghidra.framework.plugintool, ghidra.framework.model*

## `PluginTool` extends AbstractDockingTool

Base class that is a container to manage plugins and their actions, and to coordinate the firing of plugin events and tool events. A PluginTool may have visible components supplied by ComponentProviders . These components may be docked within the tool, or moved out into their own windows.   Plugi...

**Fields:**
- `TOOL_NAME_PROPERTY`: String = 'ToolName'
- `ICON_PROPERTY_NAME`: String = 'Icon'
- `DESCRIPTION_PROPERTY_NAME`: String = 'Description'
- `PLUGIN_COUNT_PROPERTY_NAME`: String = 'PluginCount'

**Methods:**
- **new**(Project project, ToolTemplate template) — Construct a new PluginTool
- **new**(Project project, String name, boolean isDockable, boolean hasStatus, boolean isModal) *(overload 2)* — Construct a new PluginTool
- **new**(Project project, ProjectManager projectManager, ToolServices toolServices, String name, boolean isDockable, boolean hasStatus, boolean isModal) *(overload 3)*
- `accept`(URL url) → boolean — Request tool to accept specified URL
- `acceptDomainFiles`(DomainFile[] data) → boolean
- `addEventListener`(Class<PluginEvent> eventClass, PluginEventListener listener) → void
- `addListenerForAllPluginEvents`(PluginEventListener listener) → void
- `addPlugin`(String className) → void — Add a plugin to the tool
- `addPlugin`(Plugin p) → void *(overload 2)*
- `addPlugins`(collections.abc.Sequence classNames) → void — Add plugins to the tool
- `addPropertyChangeListener`(PropertyChangeListener l) → void
- `addStatusComponent`(JComponent c, boolean addBorder, boolean rightSide) → void — Add a status component to the tool
- `addToolListener`(ToolListener listener) → void
- `beep`() → void — A convenience method to make an attention-grabbing noise to the user
- `canCloseDomainFile`(DomainFile domainFile) → boolean
- `canCloseDomainObject`(DomainObject domainObject) → boolean
- `cancelCurrentTask`() → void — Cancel the current task in the tool
- `clearLastEvents`() → void — Clear the list of events that were last generated
- `close`() → void — Closes this tool, possibly with input from the user
- `execute`(String commandName, T domainObject, Function<T, Boolean> f) → boolean — Execute the given command in the foreground
- `execute`(String commandName, T domainObject, Runnable r) → void *(overload 2)* — Execute the given command in the foreground
- `execute`(Command<T> command, T obj) → boolean *(overload 3)*
- `execute`(Task task, int delay) → void *(overload 4)* — Launch the task in a new thread
- `execute`(Task task) → void *(overload 5)* — Launch the task in a new thread
- `executeBackgroundCommand`(BackgroundCommand<T> cmd, T obj) → void — Start a new thread that will call the given command's applyTo() method to make some change in the domain object
- `firePluginEvent`(PluginEvent event) → void
- `getActiveWindow`() → Window
- `getConsumedToolEventNames`() → String[]
- `getDomainFiles`() → DomainFile[]
- `getIconURL`() → ToolIconURL
- `getInstanceName`() → String
- `getLocation`() → Point — Return the location of this tool's frame on the screen
- `getManagePluginsDialog`() → ManagePluginsDialog — Returns the manage plugins dialog that is currently being used
- `getManagedPlugins`() → List<Plugin> — Return a list of plugins in the tool
- `getOptions`() → ToolOptions[] — Get all options
- `getPluginsConfiguration`() → PluginsConfiguration
- `getProject`() → Project — Get the project associated with this tool
- `getProjectManager`() → ProjectManager — Returns the project manager associated with this tool
- `getServices`(Class<T> c) → T[] — Get the objects that implement the given service
- `getSize`() → Dimension — Return the dimension of this tool's frame
- `getSupportedDataTypes`() → Class<?>[]
- `getToolEventNames`() → String[]
- `getToolName`() → String
- `getToolServices`() → ToolServices — Returns an object that provides fundamental services that plugins can use
- `getToolTemplate`(boolean includeConfigState) → ToolTemplate
- `getTransientState`() → TransientToolState
- `getUndoRedoToolState`(DomainObject domainObject) → UndoRedoToolState
- `hasOptions`(String category) → boolean — Return true if there is an options category with the given name
- `hasToolListeners`() → boolean — Returns true if there is at least one tool listening to this tool's plugin events
- `hasUnsavedData`() → boolean
- `isConfigurable`() → boolean
- `isExecutingCommand`() → boolean — Return whether there is a command being executed
- `isRestoringDataState`() → boolean
- `isService`(Class<?> serviceInterface) → boolean — Returns true if the specified `serviceInterface` is a valid service that exists in this tool
- `isWindowsOnTop`() → boolean — Return the value of the Tool option (GhidraOptions
- `prepareToSave`(DomainObject dobj) → void
- `processToolEvent`(PluginEvent toolEvent) → void
- `putInstanceName`(String newInstanceName) → void
- `registerDefaultContextProvider`(Class<ActionContext> type, ActionContextProvider provider) → void — Registers an action context provider as the default provider for a specific action context type
- `registerOptionsNameChange`(String oldName, String newName) → void — Updates saved options from an old name to a new name
- `removeEventListener`(Class<PluginEvent> eventClass, PluginEventListener listener) → void
- `removeListenerForAllPluginEvents`(PluginEventListener listener) → void
- `removePlugins`(List<Plugin> plugins) → void — Remove the array of plugins from the tool
- `removePropertyChangeListener`(PropertyChangeListener l) → void
- `removeStatusComponent`(JComponent c) → void — Remove the status component
- `removeToolListener`(ToolListener listener) → void
- `restoreDataStateFromXml`(Element root) → void
- `restoreWindowingDataFromXml`(Element element) → void
- `saveDataStateToXml`(boolean savingProject) → Element
- `saveToXml`(boolean includeConfigState) → Element
- `saveTool`() → void — Save this tool's configuration
- `saveToolAs`() → boolean — Triggers a 'Save As' dialog that allows the user to save off the tool under a different name
- `saveToolToToolTemplate`() → ToolTemplate
- `saveWindowingDataToXml`() → Element
- `scheduleFollowOnCommand`(BackgroundCommand<T> cmd, T obj) → void — Add the given background command to a queue that is processed after the main background command completes
- `setDefaultComponent`(ComponentProvider provider) → void — Sets the provider that should get the default focus when no component has focus
- `setIconURL`(ToolIconURL newIconURL) → void
- `setLocation`(int x, int y) → void — Set the location of this tool's frame on the screen
- `setSize`(int width, int height) → void — Sets the size of the tool's main window
- `setSubTitle`(String subTitle) → void — Sets the subtitle on the tool; the subtitle is extra text in the title
- `setToolName`(String name) → void
- `setUnconfigurable`() → void
- `setWindowsOnTop`(boolean b) → void — Set the Tool option (GhidraOptions
- `shouldSave`() → boolean — Returns true if this tool needs saving
- `showComponentHeader`(ComponentProvider provider, boolean b) → void
- `showConfig`(boolean addSaveActions, boolean isNewTool) → void — Displays the manage plugins dialog
- `showDialog`(DialogComponentProvider dialogComponent, ComponentProvider centeredOnProvider) → void — Shows the dialog using the window containing the given componentProvider as its parent window
- `showDialog`(DialogComponentProvider dialogComponent, Component centeredOnComponent) → void *(overload 2)* — Shows the dialog using the tool's parent frame, but centers the dialog on the given component
- `showExtensions`() → void — Displays the extensions installation dialog
- `threadIsBackgroundTaskThread`() → boolean
- `unregisterDefaultContextProvider`(Class<ActionContext> type, ActionContextProvider provider) → void — Removes the default provider for the given ActionContext type

### `ToolOptionsListener` (internal) extends OptionsChangeListener

### `CheckedRunnable` (internal)

**Methods:**
- `run`() → void

### `TaskBusyListener` (internal) extends TaskListener

## `Plugin` extends ExtensionPoint, PluginEventListener, ServiceListener

Plugins are a basic building block in Ghidra, used to bundle features or capabilities into a unit that can be enabled or disabled by the user in their Tool.   Plugins expose their features or capabilities to users via menu items and buttons that the user can click on, and via "service" APIs that ...

**Methods:**
- `accept`(URL url) → boolean — Request plugin to process URL if supported
- `acceptData`(DomainFile[] data) → boolean — Method called if the plugin supports this domain file
- `dataStateRestoreCompleted`() → void — Notification that all plugins have had their data states restored
- `dependsUpon`(Plugin plugin) → boolean — Check if this plugin depends on the given plugin
- `firePluginEvent`(PluginEvent event) → void — Fire the given plugin event; the tool notifies all other plugins who are interested in receiving the given event type
- `getData`() → DomainFile[] — Get the domain files that this plugin has open
- `getMissingRequiredServices`() → List<Class<?>>
- `getName`() → String — Returns this plugin's name
- `getPluginDescription`() → PluginDescription
- `getSupportedDataTypes`() → Class<?>[] — Return classes of data types that this plugin can support
- `getTool`() → PluginTool — Get the `PluginTool` that hosts/contains this plugin
- `getTransientState`() → Object — Returns an object containing the plugins state
- `getUndoRedoState`(DomainObject domainObject) → Object — Returns an object containing the plugin's state as needed to restore itself after an undo or redo operation
- `hasMissingRequiredService`() → boolean — Checks if this plugin is missing a required service
- `isDisposed`() → boolean
- `processEvent`(PluginEvent event) → void — Method called to process a plugin event
- `readConfigState`(SaveState saveState) → void — Tells the Plugin to read its data-independent (preferences) properties from the input stream
- `readDataState`(SaveState saveState) → void — Tells the Plugin to read its data-dependent state from the given SaveState object
- `restoreTransientState`(Object state) → void — Provides the transient state object that was returned in the corresponding getTransientState() call
- `restoreUndoRedoState`(DomainObject domainObject, Object state) → void — Updates the plugin's state based on the data stored in the state object
- `serviceAdded`(Class<?> interfaceClass, Object service) → void — Notifies this plugin that a service has been added to the plugin tool
- `serviceRemoved`(Class<?> interfaceClass, Object service) → void — Notifies this plugin that service has been removed from the plugin tool
- `writeConfigState`(SaveState saveState) → void — Tells a Plugin to write any data-independent (preferences) properties to the output stream
- `writeDataState`(SaveState saveState) → void — Tells the Plugin to write any data-dependent state to the output stream

## `DomainObject`

`DomainObject` is the interface that must be supported by data objects that are persistent. `DomainObject`s maintain an association with a `DomainFile`. A `DomainObject` that has never been saved will have a null `DomainFile`.   Supports transactions and the ability to undo/redo changes made with...

**Fields:**
- `DO_OBJECT_SAVED`: EventType
- `DO_DOMAIN_FILE_CHANGED`: EventType
- `DO_OBJECT_RENAMED`: EventType
- `DO_OBJECT_RESTORED`: EventType
- `DO_PROPERTY_CHANGED`: EventType
- `DO_OBJECT_CLOSED`: EventType
- `DO_OBJECT_ERROR`: EventType
- `undoLock`: Object

**Methods:**
- `addCloseListener`(DomainObjectClosedListener listener) → void — Adds a listener that will be notified when this DomainObject is closed
- `addConsumer`(Object consumer) → boolean — Adds the given object as a consumer
- `addDomainFileListener`(DomainObjectFileListener listener) → void
- `addListener`(DomainObjectListener dol) → void — Adds a listener for this object
- `addSynchronizedDomainObject`(DomainObject domainObj) → void — Synchronize the specified domain object with this domain object using a shared transaction manager
- `addTransactionListener`(TransactionListener listener) → void — Adds the given transaction listener to this domain object
- `canLock`() → boolean — Returns true if a modification lock can be obtained on this domain object
- `canRedo`() → boolean
- `canSave`() → boolean — Returns true if this object can be saved; a read-only file cannot be saved
- `canUndo`() → boolean
- `clearUndo`() → void — Clear all undoable/redoable transactions
- `createPrivateEventQueue`(DomainObjectListener listener, int maxDelay) → EventQueueID — Creates a private event queue that can be flushed independently from the main event queue
- `endTransaction`(int transactionID, boolean commit) → boolean — Terminate the specified transaction for this domain object
- `flushEvents`() → void — Makes sure all pending domainEvents have been sent
- `flushPrivateEventQueue`(EventQueueID id) → void — Flush events from the specified event queue
- `forceLock`(boolean rollback, String reason) → void — Force transaction lock and terminate current transaction
- `getAllRedoNames`() → List<String> — Returns a list of the names of all current redo transactions
- `getAllUndoNames`() → List<String> — Returns a list of the names of all current undo transactions
- `getConsumerList`() → List<Object> — Returns the list of consumers on this domainObject
- `getCurrentTransactionInfo`() → TransactionInfo — Returns the current transaction info
- `getDescription`() → String — Returns a word or short phrase that best describes or categorizes the object in terms that a user will understand
- `getDomainFile`() → DomainFile — Get the domain file for this domain object
- `getMetadata`() → Map<String, String> — Returns a map containing all the stored metadata associated with this domain object
- `getModificationNumber`() → int — Returns a long value that gets incremented every time a change, undo, or redo takes place
- `getName`() → String — Get the name of this domain object
- `getOptions`(String propertyListName) → Options — Get the property list for the given name
- `getOptionsNames`() → List<String> — Returns all properties lists contained by this domain object
- `getRedoName`() → String — Returns a description of the change that would be "redone"
- `getSynchronizedDomainObjects`() → DomainObject[] — Return array of all domain objects synchronized with a shared transaction manager
- `getUndoName`() → String — Returns a description of the change that would be "undone"
- `hasExclusiveAccess`() → boolean — Returns true if the user has exclusive access to the domain object
- `hasTerminatedTransaction`() → boolean — Returns true if the last transaction was terminated from the action that started it
- `isChangeable`() → boolean — Returns true if changes are permitted
- `isChanged`() → boolean — Returns whether the object has changed
- `isClosed`() → boolean — Returns true if this domain object has been closed as a result of the last release
- `isLocked`() → boolean — Returns true if the domain object currently has a modification lock enabled
- `isSendingEvents`() → boolean — Returns true if this object is sending out events as it is changed
- `isTemporary`() → boolean — Returns true if this object has been marked as Temporary
- `isUsedBy`(Object consumer) → boolean — Returns true if the given consumer is using (has open) this domain object
- `lock`(String reason) → boolean — Attempt to obtain a modification lock on the domain object
- `openTransaction`(String description) → db.Transaction — Open new transaction
- `redo`() → void — Returns to a latter state that exists because of an undo
- `release`(Object consumer) → void — Notify the domain object that the specified consumer is no longer using it
- `releaseSynchronizedDomainObject`() → void — Remove this domain object from a shared transaction manager
- `removeCloseListener`(DomainObjectClosedListener listener) → void — Removes the given close listener
- `removeDomainFileListener`(DomainObjectFileListener listener) → void — Removes the given DomainObjectFileListener listener
- `removeListener`(DomainObjectListener dol) → void — Remove the listener for this object
- `removePrivateEventQueue`(EventQueueID id) → boolean — Removes the specified private event queue
- `removeTransactionListener`(TransactionListener listener) → void — Removes the given transaction listener from this domain object
- `save`(String comment, TaskMonitor monitor) → void — Saves changes to the DomainFile
- `saveToPackedFile`(File outputFile, TaskMonitor monitor) → void — Saves (i
- `setEventsEnabled`(boolean enabled) → void — If true, domain object change events are sent
- `setName`(String name) → void — Set the name for this domain object
- `setTemporary`(boolean state) → void — Set the temporary state of this object
- `startTransaction`(String description) → int — Start a new transaction in order to make changes to this domain object
- `startTransaction`(String description, AbortedTransactionListener listener) → int *(overload 2)* — Start a new transaction in order to make changes to this domain object
- `undo`() → void — Returns to the previous state
- `unlock`() → void — Release a modification lock previously granted with the lock method
- `withTransaction`(String description, ExceptionalCallback<E> callback) → void — Performs the given callback inside of a transaction
- `withTransaction`(String description, ExceptionalSupplier<T, E> supplier) → T *(overload 2)* — Calls the given supplier inside of a transaction

## `DomainFile` extends Comparable<DomainFile>

`DomainFile` provides a storage interface for a project file.  A domain file provides an immutable reference to a stored file contained within a project.  The state of a file object does not track name/parent changes made to the referenced project file. An up-to-date object may be obtained from `...

**Fields:**
- `UNSUPPORTED_FILE_ICON`: Icon
- `DEFAULT_VERSION`: int = -1
- `READ_ONLY_PROPERTY`: String = 'READ_ONLY'

**Methods:**
- `addToVersionControl`(String comment, boolean keepCheckedOut, TaskMonitor monitor) → void — Adds this private file to version control
- `canAddToRepository`() → boolean — Returns true if this private file may be added to the associated repository
- `canCheckin`() → boolean — Returns true if this file may be checked-in to the associated repository
- `canCheckout`() → boolean — Returns true if this file may be checked-out from the associated repository
- `canMerge`() → boolean — Returns true if this file can be merged with the current versioned file
- `canRecover`() → boolean
- `canSave`() → boolean — Return whether this domain object can be saved (i
- `checkin`(CheckinHandler checkinHandler, TaskMonitor monitor) → void — Performs check in to associated repository
- `checkout`(boolean exclusive, TaskMonitor monitor) → boolean — Checkout this file for update
- `copyTo`(DomainFolder newParent, TaskMonitor monitor) → DomainFile — Copy this file into the newParent folder as a private file
- `copyToAsLink`(DomainFolder newParent, boolean relative) → DomainFile — Copy this file into the newParent folder as a file-link
- `copyVersionTo`(int version, DomainFolder destFolder, TaskMonitor monitor) → DomainFile — Copy a specific version of this file to the specified destFolder
- `delete`() → void — Delete the entire database for this file, including any version files
- `delete`(int version) → void *(overload 2)* — Deletes a specific version of a file from the versioned filesystem
- `exists`() → boolean — Check for existence of domain file
- `getChangesByOthersSinceCheckout`() → ChangeSet — Returns changes made to versioned file by others since checkout was performed
- `getCheckoutStatus`() → ItemCheckoutStatus — Get checkout status associated with a versioned file
- `getCheckouts`() → ItemCheckoutStatus[] — Get a list of checkouts by all users for the associated versioned file
- `getConsumers`() → List<?> — Get the list of consumers (Objects) for this domain file
- `getContentType`() → String — Returns content-type string for this file
- `getDomainObject`(Object consumer, boolean okToUpgrade, boolean okToRecover, TaskMonitor monitor) → DomainObject — Opens and returns the current domain object
- `getDomainObjectClass`() → Class<DomainObject> — Returns the underlying Class for the domain object in this domain file
- `getFileID`() → String — Returns a unique file-ID if one has been established or null
- `getIcon`(boolean disabled) → Icon — Get the state based Icon image for the domain file based upon its content class
- `getImmutableDomainObject`(Object consumer, int version, TaskMonitor monitor) → DomainObject — Returns a new DomainObject that cannot be changed or saved to its original file
- `getLastModifiedTime`() → int — Get a long value representing the time when the data was last modified
- `getLatestVersion`() → int — Return the latest version
- `getLinkInfo`() → LinkFileInfo — If this file is a `file` the link information will be returned
- `getLocalProjectURL`(String ref) → URL — Get a local Ghidra URL for this domain file if available within the associated non-transient local project
- `getMetadata`() → Map<String, String> — Returns an ordered map containing the metadata that has been associated with the corresponding domain object
- `getName`() → String — Get the name of this project file
- `getOpenedDomainObject`(Object consumer) → DomainObject — Returns the domainObject for this DomainFile only if it is already open
- `getParent`() → DomainFolder — Get the parent domain folder for this domain file
- `getPathname`() → String — Returns the full path name to this file
- `getProjectLocator`() → ProjectLocator — Returns the local storage location for the project that this DomainFile belongs to
- `getReadOnlyDomainObject`(Object consumer, int version, TaskMonitor monitor) → DomainObject — Returns a "read-only" version of the domain object
- `getSharedProjectURL`(String ref) → URL — Get a remote Ghidra URL for this domain file if available within an associated shared project repository
- `getVersion`() → int
- `getVersionHistory`() → Version[] — Returns list of all available versions
- `isBusy`() → boolean — Returns true if the domain object in this domain file exists and has an open transaction
- `isChanged`() → boolean — Return whether the domain object in this domain file has changed
- `isCheckedOut`() → boolean — Returns true if this is a checked-out file
- `isCheckedOutExclusive`() → boolean — Returns true if this a checked-out file with exclusive access
- `isHijacked`() → boolean — Returns true if the file is versioned but a private copy also exists
- `isInWritableProject`() → boolean — Returns true if this file is in a writable project
- `isLatestVersion`() → boolean — Returns true if this file represents the latest version of the associated domain object
- `isLink`() → boolean — Determine if this file is a link-file which corresponds to either a file or folder link
- `isLinkingSupported`() → boolean — Determine if this file's content type supports linking
- `isOpen`() → boolean — Returns true if there is an open domainObject for this file
- `isReadOnly`() → boolean — Returns whether this file is explicitly marked as read-only
- `isVersioned`() → boolean — Return true if this is a versioned database, else false
- `length`() → int — Returns the length of this domain file
- `merge`(boolean okToUpgrade, TaskMonitor monitor) → void — Performs merge from current version of versioned file into local checked-out file
- `modifiedSinceCheckout`() → boolean — Returns true if this is a checked-out file which has been modified since it was checked-out
- `moveTo`(DomainFolder newParent) → DomainFile — Move this file into the newParent folder
- `packFile`(File file, TaskMonitor monitor) → void — Pack domain file into specified file
- `save`(TaskMonitor monitor) → void — Save the `DomainObject` associated with this file
- `setName`(String newName) → DomainFile — Set the name on this domain file
- `setReadOnly`(boolean state) → void — Sets the object to read-only
- `takeRecoverySnapshot`() → boolean — If the file has an updatable domain object with unsaved changes, generate a recovery snapshot
- `terminateCheckout`(long checkoutId) → void — Forcefully terminate a checkout for the associated versioned file
- `undoCheckout`(boolean keep) → void — Undo "checked-out" file
- `undoCheckout`(boolean keep, boolean force) → void *(overload 2)* — Undo "checked-out" file

## `ProjectManager`

Interface for methods to create, open, and delete projects; maintains a list of known project views that the user opened. It has a handle to the currently opened project. A project can be opened by one user at a time.

**Fields:**
- `APPLICATION_TOOL_EXTENSION`: String = '.tcd'
- `APPLICATION_TOOLS_DIR_NAME`: String = 'tools'

**Methods:**
- `createProject`(ProjectLocator projectLocator, RepositoryAdapter repAdapter, boolean remember) → Project — Create a project on the local filesystem
- `deleteProject`(ProjectLocator projectLocator) → boolean — Delete the project in the given location
- `forgetViewedProject`(URL url) → void — Remove the project url from the list of known viewed projects
- `getActiveProject`() → Project — Get the project that is currently open
- `getLastOpenedProject`() → ProjectLocator — Get the last opened (active) project
- `getMostRecentServerInfo`() → ServerInfo — Get the information that was last used to access a repository managed by a Ghidra server
- `getRecentProjects`() → ProjectLocator[] — Get list of projects that user most recently opened
- `getRecentViewedProjects`() → URL[] — Get list of projects that user most recently viewed
- `getRepositoryServerAdapter`(String host, int portNumber, boolean forceConnect) → RepositoryServerAdapter — Establish a connection to the given host and port number
- `getUserToolChest`() → ToolChest — Return the user's ToolChest
- `openProject`(ProjectLocator projectLocator, boolean doRestore, boolean resetOwner) → Project — Open a project from the file system
- `projectExists`(ProjectLocator projectLocator) → boolean — Returns true if a project with the given projectLocator exists
- `rememberProject`(ProjectLocator projectLocator) → void — Keep the projectLocator on the list of known projects
- `rememberViewedProject`(URL url) → void — Keep the url on the list of known projects
- `setLastOpenedProject`(ProjectLocator projectLocator) → void

## `Project` extends Iterable<DomainFile>

Interface to define methods to manage data and tools for users working on a particular effort. Project represents the container object for users, data, and tools to work together.

**Methods:**
- `addProjectView`(URL projectURL, boolean visible) → ProjectData — Add the given project URL to this project's list project views
- `addProjectViewListener`(ProjectViewListener listener) → void — Add a listener to be notified when a visible project view is added or removed
- `close`() → void — Close the project
- `getLocalToolChest`() → ToolChest
- `getName`() → String
- `getOpenData`() → List<DomainFile> — Get list of domain files that are open
- `getProjectData`() → ProjectData
- `getProjectData`(ProjectLocator projectLocator) → ProjectData *(overload 2)* — Returns the Project Data for the given Project locator
- `getProjectData`(URL projectURL) → ProjectData *(overload 3)* — Returns the Project Data for the given Project URL
- `getProjectLocator`() → ProjectLocator
- `getProjectManager`() → ProjectManager
- `getProjectViews`() → ProjectLocator[]
- `getRepository`() → RepositoryAdapter — Get the repository that this project is associated with
- `getSaveableData`(String key) → SaveState — See `setSaveableData(String, SaveState)`
- `getToolManager`() → ToolManager
- `getToolServices`() → ToolServices
- `getToolTemplate`(String tag) → ToolTemplate — Get the tool template with the given tag
- `getViewedProjectData`() → ProjectData[] — Get the project data for visible viewed projects that are managed by this project
- `hasChanged`() → boolean
- `isClosed`() → boolean
- `iterator`() → Iterator<DomainFile> — Return a `DomainFile` iterator over all non-link files within this project's data store
- `releaseFiles`(Object consumer) → void — Releases all DomainObjects used by the given consumer
- `removeProjectView`(URL projectURL) → void — Remove the project view from this project
- `removeProjectViewListener`(ProjectViewListener listener) → void — Remove a project view listener previously added
- `restore`() → void — Restore this project's state
- `save`() → void — Save the project and the list of project views
- `saveSessionTools`() → boolean — Saves any tools that are associated with the opened project when the project is closed
- `saveToolTemplate`(String tag, ToolTemplate template) → void — Save the given tool template as part of the project
- `setSaveableData`(String key, SaveState saveState) → void — Allows the user to store data related to the project

## `ProjectData` extends Iterable<DomainFile>

The ProjectData interface provides access to all the data files and folders in a project.   NOTE: Iterating over this project data instance will ignore all link-files.  If links should be handled please instantiate `descendantFiles(DomainFolder, DomainFileFilter)` with a suitable `DomainFileFilter`.

**Methods:**
- `addDomainFolderChangeListener`(DomainFolderChangeListener listener) → void — Adds a listener that will be notified when any folder or file changes in the project
- `close`() → void — Initiate disposal of this project data object
- `convertProjectToShared`(RepositoryAdapter repository, TaskMonitor monitor) → void — Convert a local project to a shared project
- `findCheckedOutFiles`(TaskMonitor monitor) → List<DomainFile> — Find all project files which are currently checked-out to this project
- `findOpenFiles`(List<DomainFile> list) → void — Finds all open domain files and appends them to the specified list
- `getFile`(String path) → DomainFile — Get domain file specified by an absolute data path
- `getFile`(String path, DomainFileFilter filter) → DomainFile *(overload 2)* — Get domain file specified by an absolute data path which satisfies the specified filter
- `getFileByID`(String fileID) → DomainFile — Get domain file specified by its unique fileID
- `getFileCount`() → int — Get the approximate number of files contained within the project
- `getFolder`(String path) → DomainFolder — Get domain folder specified by an absolute data path
- `getFolder`(String path, DomainFolderFilter filter) → DomainFolder *(overload 2)* — Get domain folder specified by an absolute data path
- `getLocalProjectURL`() → URL — Generate a local URL which corresponds to this project data if applicable
- `getLocalStorageClass`() → Class<LocalFileSystem>
- `getMaxNameLength`() → int
- `getProjectLocator`() → ProjectLocator — Returns the projectLocator for the this ProjectData
- `getRepository`() → RepositoryAdapter — Return the repository for this project data
- `getRootFolder`() → DomainFolder — Returns the root folder of the project
- `getSharedProjectURL`() → URL — Generate a repository URL which corresponds to this project data if applicable
- `getUser`() → User — Returns User object associated with remote repository or null if a remote repository is not used
- `hasInvalidCheckouts`(List<DomainFile> checkoutList, RepositoryAdapter newRepository, TaskMonitor monitor) → boolean
- `iterator`() → Iterator<DomainFile> — Return a `DomainFile` iterator over all non-link files within this project data store
- `makeValidName`(String name) → String — Transform the specified name into an acceptable folder or file item name
- `refresh`(boolean force) → void — Sync the Domain folder/file structure with the underlying file structure
- `removeDomainFolderChangeListener`(DomainFolderChangeListener listener) → void — Removes the listener to be notified of folder and file changes
- `testValidName`(String name, boolean isPath) → void — Validate a folder/item name or path
- `updateRepositoryInfo`(RepositoryAdapter newRepository, boolean force, TaskMonitor monitor) → void — Update the repository for this project; the server may have changed or a different repository is being used

## `DomainFolder` extends Comparable<DomainFolder>

`DomainFolder` provides a storage interface for a project folder.  A domain folder is an immutable reference to a folder contained within a project.  Provided the corresponding path exists within the project it may continue to be used to create and access its files and sub-folders.  The state of ...

**Fields:**
- `OPEN_FOLDER_ICON`: Icon
- `CLOSED_FOLDER_ICON`: Icon
- `SEPARATOR`: String = '/'
- `COPY_SUFFIX`: String = '.copy'

**Methods:**
- `copyTo`(DomainFolder newParent, TaskMonitor monitor) → DomainFolder — Copy this folder into the newParent folder
- `copyToAsLink`(DomainFolder newParent, boolean relative) → DomainFile — Copy this folder into the newParent folder as a folder-link
- `createFile`(String name, DomainObject obj, TaskMonitor monitor) → DomainFile — Add a domain object to this folder
- `createFile`(String name, File packFile, TaskMonitor monitor) → DomainFile *(overload 2)* — Add a new domain file to this folder
- `createFolder`(String folderName) → DomainFolder — Create a subfolder within this folder
- `createLinkFile`(ProjectData sourceProjectData, String pathname, boolean makeRelative, String linkFilename, LinkHandler<?> lh) → DomainFile
- `createLinkFile`(String ghidraUrl, String linkFilename, LinkHandler<?> lh) → DomainFile *(overload 2)*
- `delete`() → void — Deletes this folder, if empty, from the local filesystem
- `getFile`(String name) → DomainFile — Get the domain file in this folder with the given name
- `getFiles`() → DomainFile[] — Get all domain files in this folder
- `getFolder`(String name) → DomainFolder — Return the folder for the given name
- `getFolders`() → DomainFolder[] — Get DomainFolders in this folder
- `getLocalProjectURL`() → URL — Get a local Ghidra URL for this domain file if available within the associated non-transient local project
- `getName`() → String — Return this folder's name
- `getParent`() → DomainFolder — Return parent folder or null if this DomainFolder is the root folder
- `getPathname`() → String — Returns the full path name to this folder
- `getProjectData`() → ProjectData — Returns the project data
- `getProjectLocator`() → ProjectLocator — Returns the local storage location for the project that this DomainFolder belongs to
- `getSharedProjectURL`() → URL — Get a remote Ghidra URL for this domain folder if available within an associated shared project repository
- `isEmpty`() → boolean — Determine if this folder contains any sub-folders or domain files
- `isInWritableProject`() → boolean — Returns true if this file is in a writable project
- `isLinked`() → boolean — Determine if this folder corresponds to a linked-folder which directly corresponds to a folder-link file
- `isSame`(DomainFolder folder) → boolean — Returns true if the given folder is the same as this folder based on path and underlying project/repository
- `isSameOrAncestor`(DomainFolder folder) → boolean
- `moveTo`(DomainFolder newParent) → DomainFolder — Move this folder into the newParent folder
- `setActive`() → void — Allows the framework to react to a request to make this folder the "active" one
- `setName`(String newName) → DomainFolder — Set the name on this domain folder
