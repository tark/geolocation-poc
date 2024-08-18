class UnauthorizedError extends Error {}

class ApiError extends Error {
  ApiError(this.message);

  final String message;
}

class EmailNotConfirmedError extends Error {}

class UserAlreadyExistsError extends Error {}

class UserIsNotInInviteList extends Error {}

class ResetPasswordForGoogleUserError extends Error {}

class ResetPasswordForFacebookUserError extends Error {}