export type TFormLinks = {
  submit_path: string
  redirect_path: string
}

export type TForgotPasswordFormLinks = TFormLinks & {
  sign_in_path: string
}

export type TResetPasswordFormLinks = TFormLinks & {
  sign_in_path: string
}

export type TResendConfirmationFormLinks = TFormLinks & {
  sign_in_path: string
}

export type TSignInFormLinks = TFormLinks & {
  forgot_password_path: string
  resend_confirmation_path: string
  sign_up_path: string
}

export type TSignUpFormLinks = TFormLinks & {
  sign_in_path: string
}
