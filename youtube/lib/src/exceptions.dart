class BaseMessageException implements Exception {
    String _message;

    BaseMessageException([String message = 'An error occured']) {
        this._message = message;
    }

    @override
    String toString() {
        String class_name = this.runtimeType.toString();

        return '${class_name}: ${this._message}';
    }
}

// Just an example
class ApiResponseError extends BaseMessageException {
    ApiResponseError([String message]) : super(message);
}

class ApiError implements Exception {
    Map<String, dynamic> error;

    ApiError([Map<String, dynamic> error]) {
        this.error = error;
    }

    @override
    String toString() {
        String class_name = this.runtimeType.toString();

        // TODO: This needs to be handled properly!
        print(this.error);

        return '${class_name}: Message here???';
    }
}
