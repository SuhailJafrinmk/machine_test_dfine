class AppExceptions implements Exception {
  final String errorMessage;
  final String? errorCode;  
  AppExceptions({required this.errorMessage, this.errorCode});
  @override
  String toString() {
    if (errorCode != null) {
      return 'Error Code: $errorCode - $errorMessage';
    }
    return errorMessage;
  }
}


class InternetException extends AppExceptions {
  InternetException() : super(errorMessage: 'No internet connection');
}

class ServerException extends AppExceptions {
  ServerException() : super(errorMessage: 'Something went wrong on the server');
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException() : super(errorMessage: 'Request timed out');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException() : super(errorMessage: 'User is not authorized');
}

class ResourceNotFoundException extends AppExceptions {
  ResourceNotFoundException() : super(errorMessage: 'Requested resource not found');
}

class InternalServerException extends AppExceptions {
  InternalServerException() : super(errorMessage: 'Internal server error');
}

class BadRequestException extends AppExceptions {
  BadRequestException() : super(errorMessage: 'Invalid request');
}


class FirebaseAuthException extends AppExceptions {
  FirebaseAuthException(String errorMessage, String errorCode) 
      : super(errorMessage: errorMessage, errorCode: errorCode);
}

class FirebaseDatabaseException extends AppExceptions {
  FirebaseDatabaseException(String errorMessage, String errorCode) 
      : super(errorMessage: errorMessage, errorCode: errorCode);
}

class FirebaseStorageException extends AppExceptions {
  FirebaseStorageException(String errorMessage, String errorCode)
      : super(errorMessage: errorMessage, errorCode: errorCode);
}

class UnknownException extends AppExceptions {
  UnknownException() : super(errorMessage: 'An unknown error occurred');
}
