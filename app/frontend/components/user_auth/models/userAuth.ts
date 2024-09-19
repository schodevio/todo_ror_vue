export class UserAuthModel {
  id: string
  first_name: string = ''
  last_name: string = ''
  email: string = ''
  password: string = ''
  password_confirmation: string = ''
  current_password: string = ''
  reset_password_token: string = ''

  constructor(data: Partial<UserAuthModel> = {}) {
    Object.assign(this, data)
  }

  get resetPasswordParams() {
    return {
      password: this.password,
      password_confirmation: this.password_confirmation,
      reset_password_token: this.reset_password_token
    }
  }

  get forgotPasswordParams() {
    return {
      email: this.email
    }
  }

  get signInParams() {
    return {
      email: this.email,
      password: this.password
    }
  }

  get signUpParams() {
    return {
      first_name: this.first_name,
      last_name: this.last_name,
      email: this.email,
      password: this.password,
      password_confirmation: this.password_confirmation
    }
  }

  get updateParams() {
    return {
      ...this.signUpParams,
      current_password: this.current_password
    }
  }
}
