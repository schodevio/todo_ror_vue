export class UserModel {
  id: string
  first_name: string = ''
  last_name: string = ''
  email: string

  constructor(data: Partial<UserModel> = {}) {
    Object.assign(this, data)
  }

  get resetPasswordParams() {
    return {
      password: '',
      password_confirmation: '',
      reset_password_token: ''
    }
  }

  get forgotPasswordParams() {
    return {
      email: this.email
    }
  }

  get loginParams() {
    return {
      email: this.email,
      password: ''
    }
  }

  get registerParams() {
    return {
      first_name: this.first_name,
      last_name: this.last_name,
      email: this.email,
      password: '',
      password_confirmation: ''
    }
  }
}

export class UsersList {
  models: UserModel[]

  constructor(items: UserModel[] = []) {
    this.models = items.map(item => new UserModel(item))
  }
}
