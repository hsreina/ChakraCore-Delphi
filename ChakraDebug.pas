unit ChakraDebug;

interface

uses ChakraCommon;

type
  JsDiagDebugEvent = (
    JsDiagDebugEventSourceCompile = 0,
    JsDiagDebugEventCompileError = 1,
    JsDiagDebugEventBreakpoint = 2,
    JsDiagDebugEventStepComplete = 3,
    JsDiagDebugEventDebuggerStatement = 4,
    JsDiagDebugEventAsyncBreak = 5,
    JsDiagDebugEventRuntimeException = 6
  );

  JsDiagBreakOnExceptionAttributes = (
    JsDiagBreakOnExceptionAttributeNone = $0,
    JsDiagBreakOnExceptionAttributeUncaught = $1,
    JsDiagBreakOnExceptionAttributeFirstChance = $2
  );

  JsDiagStepType = (
    JsDiagStepTypeStepIn = 0,
    JsDiagStepTypeStepOut = 1,
    JsDiagStepTypeStepOver = 2,
    JsDiagStepTypeStepBack = 3
  );

  {
    typedef void (CHAKRA_CALLBACK * JsDiagDebugEventCallback)(
      _In_ JsDiagDebugEvent debugEvent,
      _In_ JsValueRef eventData,
      _In_opt_ void* callbackState
    );
  }
  JsDiagDebugEventCallback = procedure(
    debugEvent: JsDiagDebugEvent;
    eventData: JsValueRef;
    callbackState: Pointer
  ); stdcall;

  {
    CHAKRA_API
        JsDiagStartDebugging(
            _In_ JsRuntimeHandle runtimeHandle,
            _In_ JsDiagDebugEventCallback debugEventCallback,
            _In_opt_ void* callbackState);
  }
  function JsDiagStartDebugging(
    runtimeHandle: JsRuntimeHandle;
    debugEventCallback: JsDiagDebugEventCallback;
    callbackState: Pointer
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagStopDebugging(
            _In_ JsRuntimeHandle runtimeHandle,
            _Out_ void** callbackState);
  }
  function JsDiagStopDebugging(
    runtimeHandle: JsRuntimeHandle;
    var callbackState: Pointer
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagRequestAsyncBreak(
            _In_ JsRuntimeHandle runtimeHandle);
  }
  function JsDiagRequestAsyncBreak(
    runtimeHandle: JsRuntimeHandle
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetBreakpoints(
            _Out_ JsValueRef *breakpoints);
  }
  function JsDiagGetBreakpoints(
    var breakpoints: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagSetBreakpoint(
            _In_ unsigned int scriptId,
            _In_ unsigned int lineNumber,
            _In_ unsigned int columnNumber,
            _Out_ JsValueRef *breakpoint);
  }
  function JsDiagSetBreakpoint(
    scriptId: uint;
    lineNumber: uint;
    columnNumber: uint;
    var breakpoint: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagRemoveBreakpoint(
            _In_ unsigned int breakpointId);
  }
  function JsDiagRemoveBreakpoint(
    breakpointId: uint
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagSetBreakOnException(
            _In_ JsRuntimeHandle runtimeHandle,
            _In_ JsDiagBreakOnExceptionAttributes exceptionAttributes);
  }
  function JsDiagSetBreakOnException(
    runtimeHandle: JsRuntimeHandle;
    exceptionAttributes: JsDiagBreakOnExceptionAttributes
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetBreakOnException(
            _In_ JsRuntimeHandle runtimeHandle,
            _Out_ JsDiagBreakOnExceptionAttributes* exceptionAttributes);
  }
  function JsDiagGetBreakOnException(
    runtimeHandle: JsRuntimeHandle;
    var exceptionAttributes: JsDiagBreakOnExceptionAttributes
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagSetStepType(
            _In_ JsDiagStepType stepType);
  }
  function JsDiagSetStepType(
    stepType: JsDiagStepType
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetScripts(
            _Out_ JsValueRef *scriptsArray);
  }
  function JsDiagGetScripts(
    var scriptsArray: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetSource(
            _In_ unsigned int scriptId,
            _Out_ JsValueRef *source);
  }
  function JsDiagGetSource(
    scriptId: uint;
    var source: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetFunctionPosition(
            _In_ JsValueRef function,
            _Out_ JsValueRef *functionPosition);
  }
  function JsDiagGetFunctionPosition(
    _function: JsValueRef;
    functionPosition: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetStackTrace(
            _Out_ JsValueRef *stackTrace);
  }
  function JsDiagGetStackTrace(
    var stackTrace: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetStackProperties(
            _In_ unsigned int stackFrameIndex,
            _Out_ JsValueRef *properties);
  }
  function JsDiagGetStackProperties(
    stackFrameIndex: uint;
    var properties: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetProperties(
            _In_ unsigned int objectHandle,
            _In_ unsigned int fromCount,
            _In_ unsigned int totalCount,
            _Out_ JsValueRef *propertiesObject);
  }
  function JsDiagGetProperties(
    objectHandle: uint;
    fromCount: uint;
    totalCount: uint;
    var propertiesObject: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsDiagGetObjectFromHandle(
            _In_ unsigned int objectHandle,
            _Out_ JsValueRef *handleObject);
  }
  function JsDiagGetObjectFromHandle(
    objectHandle: uint;
    var handleObject: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

{$ifdef WIN32}
  {
    CHAKRA_API
        JsDiagEvaluate(
            _In_z_ const wchar_t *expression,
            _In_ unsigned int stackFrameIndex,
            _Out_ JsValueRef *evalResult);
  }
  function JsDiagEvaluate(
    const expression: pwchar_t;
    stackFrameIndex: uint;
    var evalResult: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;
{$endif}

  {
    CHAKRA_API JsDiagEvaluateUtf8(
        _In_z_ const char *expression,
        _In_ unsigned int stackFrameIndex,
        _Out_ JsValueRef *evalResult);
  }
  function JsDiagEvaluateUtf8(
    const expression: PChar;
    stackFrameIndex: uint;
    var evalResult: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

type
  JsTTDMoveMode{ : int64_t} = (
    JsTTDMoveNone = $0,
    JsTTDMoveFirstEvent = $1,
    JsTTDMoveLastEvent = $2,
    JsTTDMoveKthEvent = $4,
    JsTTDMoveScanIntervalBeforeDebugExecute = $10,
    JsTTDMoveScanIntervalForContinue = $20,
    JsTTDMoveBreakOnEntry = $100
  );

  JsTTDStreamHandle = Pointer;

  {
    typedef void (CHAKRA_CALLBACK *JsTTDInitializeForWriteLogStreamCallback)(
      _In_ size_t uriByteLength,
      _In_reads_(uriByteLength) const byte* uriBytes
    );
  }
  JsTTDInitializeForWriteLogStreamCallback = procedure(
    uriByteLength: size_t;
    const uriBytes: PByte
  ); stdcall;

  {
    typedef JsTTDStreamHandle (CHAKRA_CALLBACK *TTDOpenResourceStreamCallback)(
      _In_ size_t uriByteLength,
      _In_reads_(uriByteLength) const byte* uriBytes,
      _In_z_ const char* asciiResourceName,
      _In_ bool read,
      _In_ bool write
    );
  }
  TTDOpenResourceStreamCallback = function(
    uriByteLength: size_t;
    const uriBytes: PByte;
    const asciiResourceName: PChar;
    read: bool;
    write: bool
  ): JsTTDStreamHandle; stdcall;

  {
    typedef bool (CHAKRA_CALLBACK *JsTTDReadBytesFromStreamCallback)(
      _In_ JsTTDStreamHandle handle,
      _Out_writes_(size) byte* buff,
      _In_ size_t size,
      _Out_ size_t* readCount
    );
  }
  JsTTDReadBytesFromStreamCallback = function(
    handle: JsTTDStreamHandle;
    buff: PByte;
    size: size_t;
    var readCount: size_t
  ): bool; stdcall;

  {
    typedef bool (CHAKRA_CALLBACK *JsTTDWriteBytesToStreamCallback)(
      _In_ JsTTDStreamHandle handle,
      _In_reads_(size) const byte* buff,
      _In_ size_t size,
      _Out_ size_t* writtenCount
    );
  }
  JsTTDWriteBytesToStreamCallback = function(
    handle: JsTTDStreamHandle;
    buff: PByte;
    size: size_t;
    var writtenCount: size_t
  ): bool; stdcall;

  {
    typedef void (CHAKRA_CALLBACK *JsTTDFlushAndCloseStreamCallback)(
      _In_ JsTTDStreamHandle handle,
      _In_ bool read,
      _In_ bool write
    );
  }
  JsTTDFlushAndCloseStreamCallback = procedure(
    handle: JsTTDStreamHandle;
    read: bool;
    write: bool
  ); stdcall;

  {
    CHAKRA_API
        JsTTDCreateRecordRuntime(
            _In_ JsRuntimeAttributes attributes,
            _In_reads_(infoUriCount) const byte* infoUri,
            _In_ size_t infoUriCount,
            _In_ size_t snapInterval,
            _In_ size_t snapHistoryLength,
            _In_opt_ JsThreadServiceCallback threadService,
            _Out_ JsRuntimeHandle *runtime);
  }
  function JsTTDCreateRecordRuntime(
    attributes: JsRuntimeAttributes;
    const infoUri: PByte;
    infoUriCount: size_t;
    snapInterval: size_t;
    snapHistoryLength: size_t;
    threadService: JsThreadServiceCallback;
    var runtime: JsRuntimeHandle
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDCreateDebugRuntime(
            _In_ JsRuntimeAttributes attributes,
            _In_reads_(infoUriCount) const byte* infoUri,
            _In_ size_t infoUriCount,
            _In_opt_ JsThreadServiceCallback threadService,
            _Out_ JsRuntimeHandle *runtime);
  }
  function JsTTDCreateDebugRuntime(
    attributes: JsRuntimeAttributes;
    const infoUri: PByte;
    infoUriCount: size_t;
    threadService: JsThreadServiceCallback;
    var runtime: JsRuntimeHandle
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDCreateContext(
            _In_ JsRuntimeHandle runtime,
            _Out_ JsContextRef *newContext);
  }
  function JsTTDCreateContext(
    runtime: JsRuntimeHandle;
    var newContext: JsContextRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDSetIOCallbacks(
            _In_ JsRuntimeHandle runtime,
            _In_ JsTTDInitializeForWriteLogStreamCallback writeInitializeFunction,
            _In_ TTDOpenResourceStreamCallback openResourceStream,
            _In_ JsTTDReadBytesFromStreamCallback readBytesFromStream,
            _In_ JsTTDWriteBytesToStreamCallback writeBytesToStream,
            _In_ JsTTDFlushAndCloseStreamCallback flushAndCloseStream);
  }
  function JsTTDSetIOCallbacks(
    runtime: JsRuntimeHandle;
    writeInitializeFunction: JsTTDInitializeForWriteLogStreamCallback;
    openResourceStream: TTDOpenResourceStreamCallback;
    readBytesFromStream: JsTTDReadBytesFromStreamCallback;
    writeBytesToStream: JsTTDWriteBytesToStreamCallback;
    flushAndCloseStream: JsTTDFlushAndCloseStreamCallback
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDStartTimeTravelRecording();
  }
  function JsTTDStartTimeTravelRecording(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDStopTimeTravelRecording();
  }
  function JsTTDStopTimeTravelRecording(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDEmitTimeTravelRecording();
  }
  function JsTTDEmitTimeTravelRecording(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDStartTimeTravelDebugging();
  }
  function JsTTDStartTimeTravelDebugging(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDPauseTimeTravelBeforeRuntimeOperation();
  }
  function JsTTDPauseTimeTravelBeforeRuntimeOperation(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDReStartTimeTravelAfterRuntimeOperation();
  }
  function JsTTDReStartTimeTravelAfterRuntimeOperation(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDNotifyYield();
  }
  function JsTTDNotifyYield(
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDHostExit(_In_ int statusCode);
  }
  function JsTTDHostExit(
    statusCode: int
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDRawBufferCopySyncIndirect(
            _In_ JsValueRef dst,
            _In_ size_t dstIndex,
            _In_ JsValueRef src,
            _In_ size_t srcIndex,
            _In_ size_t count);
  }
  function JsTTDRawBufferCopySyncIndirect(
    dst: JsValueRef;
    dstIndex: size_t;
    src: JsValueRef;
    srcIndex: size_t;
    count: size_t
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDRawBufferModifySyncIndirect(
            _In_ JsValueRef buffer,
            _In_ size_t index,
            _In_ size_t count);
  }
  function JsTTDRawBufferModifySyncIndirect(
    buffer: JsValueRef;
    index: size_t;
    count: size_t
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDRawBufferAsyncModificationRegister(
            _In_ JsValueRef instance,
            _In_ byte* initialModPos);
  }
  function JsTTDRawBufferAsyncModificationRegister(
    instance: JsValueRef;
    initialModPos: PByte
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDRawBufferAsyncModifyComplete(
            _In_ byte* finalModPos);
  }
  function JsTTDRawBufferAsyncModifyComplete(
    finalModPos: PByte
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API JsTTDGetSnapTimeTopLevelEventMove(
        _In_ JsRuntimeHandle runtimeHandle,
        _In_ JsTTDMoveMode moveMode,
        _Inout_ int64_t* targetEventTime,
        _Out_ bool* createFreshCxts,
        _Out_ int64_t* targetStartSnapTime,
        _Out_opt_ int64_t* targetEndSnapTime);
  }
  function JsTTDGetSnapTimeTopLevelEventMove(
    runtimeHandle: JsRuntimeHandle;
    moveMode: JsTTDMoveMode;
    var targetEventTime: int64_t;
    var createFreshCxts: bool;
    var targetStartSnapTime: int64_t;
    var targetEndSnapTime: int64_t
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDPrepContextsForTopLevelEventMove(
            _In_ JsRuntimeHandle runtimeHandle,
            _In_ bool createFreshCtxs);
  }
  function JsTTDPrepContextsForTopLevelEventMove(
    runtimeHandle: JsRuntimeHandle;
    createFreshCtxs: bool
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API JsTTDPreExecuteSnapShotInterval(
        _In_ int64_t startSnapTime,
        _In_ int64_t endSnapTime,
        _In_ JsTTDMoveMode moveMode);
  }
  function JsTTDPreExecuteSnapShotInterval(
    startSnapTime: int64_t;
    endSnapTime: int64_t;
    moveMode: JsTTDMoveMode
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDMoveToTopLevelEvent(
            _In_ JsTTDMoveMode moveMode,
            _In_ int64_t snapshotTime,
            _In_ int64_t eventTime);
  }
  function JsTTDMoveToTopLevelEvent(
    moveMode: JsTTDMoveMode;
    snapshotTime: int64_t;
    eventTime: int64_t
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsTTDReplayExecution(
            _Inout_ JsTTDMoveMode* moveMode,
            _Inout_ int64_t* rootEventTime);
  }
  function JsTTDReplayExecution(
    var moveMode: JsTTDMoveMode;
    var rootEventTime: int64_t
  ): JsErrorCode; stdcall; external DLL_NAME;

implementation

end.
