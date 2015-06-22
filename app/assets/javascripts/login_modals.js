function showSignUpModal() {
  $('#mySignInModal').modal('hide');
  $('#mySignUpModal').modal('show');
  ga('send', 'event', 'User', 'Show Sign up modal', 'ShowSignUpModal function have been called');
}
function showSignInModal() {
  $('#mySignUpModal').modal('hide');
  $('#mySignInModal').modal('show');
  ga('send', 'event', 'User', 'Show Sign in modal', 'ShowSignInModal function have been called');
}