import { describe, expect, it } from 'vitest'
import { UserAuthModel } from './userAuth'

describe('params methods', () => {
  it('have correct values', () => {
    const subject = new UserAuthModel({
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password-confirm',
      current_password: 'current-password',
      reset_password_token: 'sample-token'
    })

    expect.soft(subject.forgotPasswordParams).toEqual({
      email: subject.email
    })

    expect.soft(subject.resetPasswordParams).toEqual({
      password: subject.password,
      password_confirmation: subject.password_confirmation,
      reset_password_token: subject.reset_password_token
    })

    expect.soft(subject.resendConfirmationParams).toEqual({
      email: subject.email
    })

    expect.soft(subject.signInParams).toEqual({
      email: subject.email,
      password: subject.password
    })

    expect.soft(subject.signUpParams).toEqual({
      first_name: subject.first_name,
      last_name: subject.last_name,
      email: subject.email,
      password: subject.password,
      password_confirmation: subject.password_confirmation
    })

    expect.soft(subject.updateParams).toEqual({
      ...subject.signUpParams,
      current_password: subject.current_password
    })
  })
})
