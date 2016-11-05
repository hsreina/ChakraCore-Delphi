unit ChakraCommonWindows;

interface

uses ChakraCommon;

type

  {
    typedef bool (CHAKRA_CALLBACK * JsSerializedScriptLoadSourceCallback)(
      _In_ JsSourceContext sourceContext,
      _Outptr_result_z_ const wchar_t** scriptBuffer
    );
  }
  JsSerializedScriptLoadSourceCallback = function(sourceContext: JsSourceContext; var scriptBuffer: pwchar_t): bool; stdcall;

  {
    CHAKRA_API
        JsParseScript(
            _In_z_ const wchar_t *script,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef *result);
  }
  function JsParseScript(
    script: pwchar_t;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsParseScriptWithAttributes(
            _In_z_ const wchar_t *script,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _In_ JsParseScriptAttributes parseAttributes,
            _Out_ JsValueRef *result);
  }
  function JsParseScriptWithAttributes(
    script: pwchar_t;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    parseAttributes: JsParseScriptAttributes;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsRunScript(
            _In_z_ const wchar_t *script,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef *result);
  }
  function JsRunScript(
    const script: pwchar_t;
    sourceContext: JsSourceContext;
    const sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsExperimentalApiRunModule(
            _In_z_ const wchar_t *script,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef *result);
  }
  function JsExperimentalApiRunModule(
    script: pwchar_t;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
     CHAKRA_API
        JsSerializeScript(
            _In_z_ const wchar_t *script,
            _Out_writes_to_opt_(*bufferSize, *bufferSize) BYTE *buffer,
            _Inout_ unsigned int *bufferSize);
  }
  function JsSerializeScript(
    script: pwchar_t;
    buffer: PByte;
    var bufferSize: uint
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsParseSerializedScriptWithCallback(
            _In_ JsSerializedScriptLoadSourceCallback scriptLoadCallback,
            _In_ JsSerializedScriptUnloadCallback scriptUnloadCallback,
            _In_ BYTE *buffer,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef * result);
  }
  function JsParseSerializedScriptWithCallback(
    scriptLoadCallback: JsSerializedScriptLoadSourceCallback;
    scriptUnloadCallback: JsSerializedScriptUnloadCallback;
    buffer: PByte;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
     CHAKRA_API
        JsRunSerializedScriptWithCallback(
            _In_ JsSerializedScriptLoadSourceCallback scriptLoadCallback,
            _In_ JsSerializedScriptUnloadCallback scriptUnloadCallback,
            _In_ BYTE *buffer,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_opt_ JsValueRef * result);
  }
  function JsRunSerializedScriptWithCallback(
    scriptLoadCallback: JsSerializedScriptLoadSourceCallback;
    scriptUnloadCallback: JsSerializedScriptUnloadCallback;
    buffer: PByte;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsParseSerializedScript(
            _In_z_ const wchar_t *script,
            _In_ BYTE *buffer,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef *result);
  }
  function JsParseSerializedScript(
    script: pwchar_t;
    buffer: PByte;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsRunSerializedScript(
            _In_z_ const wchar_t *script,
            _In_ BYTE *buffer,
            _In_ JsSourceContext sourceContext,
            _In_z_ const wchar_t *sourceUrl,
            _Out_ JsValueRef *result);
  }
  function JsRunSerializedScript(
    script: pwchar_t;
    buffer: PByte;
    sourceContext: JsSourceContext;
    sourceUrl: pwchar_t;
    var result: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsGetPropertyIdFromName(
            _In_z_ const wchar_t *name,
            _Out_ JsPropertyIdRef *propertyId);
  }
  function JsGetPropertyIdFromName(
    name: pwchar_t;
    var propertyId: JsPropertyIdRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsGetPropertyNameFromId(
            _In_ JsPropertyIdRef propertyId,
            _Outptr_result_z_ const wchar_t **name);
  }
  function JsGetPropertyNameFromId(
    propertyId: JsPropertyIdRef;
    var name: pwchar_t
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsPointerToString(
            _In_reads_(stringLength) const wchar_t *stringValue,
            _In_ size_t stringLength,
            _Out_ JsValueRef *value);
  }
  function JsPointerToString(
    const stringValue: pwchar_t;
    stringLength: size_t;
    var value: JsValueRef
  ): JsErrorCode; stdcall; external DLL_NAME;

  {
    CHAKRA_API
        JsStringToPointer(
            _In_ JsValueRef value,
            _Outptr_result_buffer_(*stringLength) const wchar_t **stringValue,
            _Out_ size_t *stringLength);
  }
  function JsStringToPointer(
    value: JsValueRef;
    var stringValue: pwchar_t;
    var stringLength: size_t
  ): JsErrorCode; stdcall; external DLL_NAME;

implementation

end.
