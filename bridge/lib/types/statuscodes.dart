enum StatusCode {
  // 0xx: Unknown
  unknown(0),

  // 1xx: Informational
  continue_(100),
  switchingProtocols(101),
  processing(102),
  earlyHints(103),

  // 2xx: Success
  ok(200),
  created(201),
  accepted(202),
  nonAuthoritativeInformation(203),
  noContent(204),
  resetContent(205),
  partialContent(206),
  multiStatus(207),
  alreadyReported(208),
  imUsed(226),

  // 3xx: Redirection
  multipleChoices(300),
  movedPermanently(301),
  found(302),
  seeOther(303),
  notModified(304),
  useProxy(305),
  temporaryRedirect(307),
  permanentRedirect(308),

  // 4xx: Client Error
  badRequest(400),
  unauthorized(401),
  paymentRequired(402),
  forbidden(403),
  notFound(404),
  methodNotAllowed(405),
  notAcceptable(406),
  proxyAuthenticationRequired(407),
  requestTimeout(408),
  conflict(409),
  gone(410),
  lengthRequired(411),
  preconditionFailed(412),
  payloadTooLarge(413),
  uriTooLong(414),
  unsupportedMediaType(415),
  rangeNotSatisfiable(416),
  expectationFailed(417),
  misdirectedRequest(421),
  unprocessableEntity(422),
  locked(423),
  failedDependency(424),
  tooEarly(425),
  upgradeRequired(426),
  preconditionRequired(428),
  tooManyRequests(429),
  requestHeaderFieldsTooLarge(431),
  unavailableForLegalReasons(451),

  // 5xx: Server Error
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504),
  httpVersionNotSupported(505),
  variantAlsoNegotiates(506),
  insufficientStorage(507),
  loopDetected(508),
  notExtended(510),
  networkAuthenticationRequired(511);

  final int code;

  const StatusCode(this.code);

  StatusCodeCategory get category {
    if (code >= 100 && code < 200) return StatusCodeCategory.informational;
    if (code >= 200 && code < 300) return StatusCodeCategory.success;
    if (code >= 300 && code < 400) return StatusCodeCategory.redirection;
    if (code >= 400 && code < 500) return StatusCodeCategory.clientError;
    if (code == 0) return StatusCodeCategory.unknown;
    return StatusCodeCategory.serverError;
  }

  // Returns the status code from the code value
  // Returns null if the code is not found
  static StatusCode? mayfromCode(int code) {

    for (var value in StatusCode.values) {
      if (value.code == code) {
        return value;
      }
    }

    return null;
  }

  // Returns the status code from the code value
  // Returns 0 if the code is not found (unknown)
  static StatusCode fromCode(int code) {

    for (var value in StatusCode.values) {
      if (value.code == code) {
        return value;
      }
    }

    return StatusCode.unknown;
  }

  
  bool isSuccess() {
    return category == StatusCodeCategory.success;
  }
}

enum StatusCodeCategory {
  unknown,
  informational,
  success,
  redirection,
  clientError,
  serverError,
}
