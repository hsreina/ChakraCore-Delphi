unit ChakraCore;

interface

uses ChakraCommon;

type

  JsModuleRecord =  System.Pointer;

  JsParseModuleSourceFlags = (
    JsParseModuleSourceFlags_DataIsUTF16LE = $00000000,
    JsParseModuleSourceFlags_DataIsUTF8 = $00000001
  );

  JsModuleHostInfoKind = (
    JsModuleHostInfo_Exception = $01,
    JsModuleHostInfo_HostDefined = $02,
    JsModuleHostInfo_NotifyModuleReadyCallback = $3,
    JsModuleHostInfo_FetchImportedModuleCallback = $4
  );

  {
    typedef JsErrorCode(CHAKRA_CALLBACK * FetchImportedModuleCallBack)(
      _In_ JsModuleRecord referencingModule,
      _In_ JsValueRef specifier,
      _Outptr_result_maybenull_ JsModuleRecord* dependentModuleRecord
    );
  }
  FetchImportedModuleCallBack = function(
    referencingModule: System.Pointer; specifier: JsValueRef; var dependentModuleRecord: System.Pointer
  ): JsErrorCode; stdcall;

  {
    typedef JsErrorCode(CHAKRA_CALLBACK * NotifyModuleReadyCallback)(
      _In_opt_ JsModuleRecord referencingModule,
      _In_opt_ JsValueRef exceptionVar
    );
  }
  NotifyModuleReadyCallback = function(
    referencingModule: JsModuleRecord;
    exceptionVar: JsValueRef
  ): JsErrorCode; stdcall;

  {
    CHAKRA_API
    JsInitializeModuleRecord(
        _In_opt_ JsModuleRecord referencingModule,
        _In_ JsValueRef normalizedSpecifier,
        _Outptr_result_maybenull_ JsModuleRecord* moduleRecord);
  }
  function JsInitializeModuleRecord(
    referencingModule: JsModuleRecord;
    normalizedSpecifier: JsValueRef;
    var moduleRecord: JsModuleRecord
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
    JsParseModuleSource(
        _In_ JsModuleRecord requestModule,
        _In_ JsSourceContext sourceContext,
        _In_ BYTE* script,
        _In_ unsigned int scriptLength,
        _In_ JsParseModuleSourceFlags sourceFlag,
        _Outptr_result_maybenull_ JsValueRef* exceptionValueRef);
  }
  function JsParseModuleSource(
    requestModule: JsModuleRecord;
    sourceContext: JsSourceContext;
    script: PByte;
    scriptLength: uint;
    sourceFlag: JsParseModuleSourceFlags;
    var exceptionValueRef: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
     CHAKRA_API
    JsModuleEvaluation(
        _In_ JsModuleRecord requestModule,
        _Outptr_result_maybenull_ JsValueRef* result);
  }
  function JsModuleEvaluation(
    requestModule: JsModuleRecord;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
    JsSetModuleHostInfo(
        _In_ JsModuleRecord requestModule,
        _In_ JsModuleHostInfoKind moduleHostInfo,
        _In_ void* hostInfo);
  }
  function JsSetModuleHostInfo(
    requestModule: JsModuleRecord;
    moduleHostInfo: JsModuleHostInfoKind;
    hostInfo: Pointer
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
    JsGetModuleHostInfo(
        _In_  JsModuleRecord requestModule,
        _In_ JsModuleHostInfoKind moduleHostInfo,
        _Outptr_result_maybenull_ void** hostInfo);
  }
  function JsGetModuleHostInfo(
    requestModule: JsModuleRecord;
    moduleHostInfo: JsModuleHostInfoKind;
    var hostInfo: Pointer
  ): JsErrorCode; stdcall; external DLL_NAME;

implementation

end.
