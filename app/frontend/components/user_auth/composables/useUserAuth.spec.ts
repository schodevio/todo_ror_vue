import { describe, expect, it, vi } from 'vitest'
import * as useHTTP from '@utils/useHTTP'

import { UserAuthModel } from '../models/userAuth'
import useUserAuth from './useUserAuth'

const mocks = vi.hoisted(() => ({ default: vi.fn() }))
vi.mock('@utils/useHTTP', () => ({ default: mocks.default }))

describe('userAuth state', () => {
  it('is empty UserAuthModel by default', () => {
    const { userAuth } = useUserAuth()

    expect(userAuth.value).toBeInstanceOf(UserAuthModel)
    expect(userAuth.value).toMatchObject({ first_name: '' })
  })

  it('matches initialData', () => {
    const { userAuth } = useUserAuth({ first_name: 'John' })

    expect(userAuth.value).toBeInstanceOf(UserAuthModel)
    expect(userAuth.value).toMatchObject({ first_name: 'John' })
  })
})

describe('setUserAtuh', () => {
  it('sets new userAuth state', () => {
    const { userAuth, setUserAuth } = useUserAuth({ first_name: 'John' })

    setUserAuth({ first_name: 'Jane' })

    expect(userAuth.value).toBeInstanceOf(UserAuthModel)
    expect(userAuth.value).toMatchObject({ first_name: 'Jane' })
  })

  it('cleares errors', () => {
    const { errors, setUserAuth } = useUserAuth({ first_name: 'John' })

    errors.value = { first_name: ['is invalid'] }
    setUserAuth({ first_name: 'Jane' })

    expect(errors.value).toEqual({})
  })
})

describe('forgotPassword', () => {
  it('makes a POST request', () => {
    const { userAuth, errors, forgotPassword } = useUserAuth()

    const requestOptions = {
      method: 'POST',
      data: { user: userAuth.value.forgotPasswordParams }
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    forgotPassword('/users/password').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/password', requestOptions)
      expect(errors.value).toEqual({})
    })

  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, forgotPassword } = useUserAuth()

    const requestOptions = {
      method: 'POST',
      data: { user: userAuth.value.forgotPasswordParams }
    }

    const response = {
      data: {
        errors: {
          email: ['is invalid' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    forgotPassword('/users/password').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/password', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})

describe('resetPassword', () => {
  it('makes a PUT request', () => {
    const { userAuth, errors, resetPassword } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.resetPasswordParams },
      method: 'PUT'
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    resetPassword('/users/password').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/password', requestOptions)
      expect(errors.value).toEqual({})
    })
  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, resetPassword } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.resetPasswordParams },
      method: 'PUT',
    }

    const response = {
      status: 422,
      data: {
        errors: {
          password: ['is invalid' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    resetPassword('/users/password').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/password', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})

describe('resendConfirmation', () => {
  it('makes a POST request', () => {
    const { userAuth, errors, resendConfirmation } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.resendConfirmationParams },
      method: 'POST'
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    resendConfirmation('/users/confirmation').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/confirmation', requestOptions)
      expect(errors.value).toEqual({})
    })
  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, resendConfirmation } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.resendConfirmationParams },
      method: 'POST',
    }

    const response = {
      status: 422,
      data: {
        errors: {
          email: ['is invalid' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    resendConfirmation('/users/confirmation').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/confirmation', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})

describe('signIn', () => {
  it('makes a POST request', () => {
    const { userAuth, errors, signIn } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.signInParams },
      method: 'POST'
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    signIn('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual({})
    })
  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, signIn } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.signInParams },
      method: 'POST',
    }

    const response = {
      status: 422,
      data: {
        errors: {
          base: ['invalid credentials' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    signIn('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})

describe('signUp', () => {
  it('makes a POST request', () => {
    const { userAuth, errors, signUp } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.signUpParams },
      method: 'POST'
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    signUp('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual({})
    })
  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, signUp } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.signUpParams },
      method: 'POST',
    }

    const response = {
      status: 422,
      data: {
        errors: {
          base: ['invalid credentials' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    signUp('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})

describe('updateUser', () => {
  it('makes a PUT request', () => {
    const { userAuth, errors, updateUser } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.updateParams },
      method: 'PUT'
    }

    const response = {
      status: 200,
      data: {}
    }

    mocks.default.mockResolvedValue(response)
    const spy = vi.spyOn(useHTTP, 'default')

    updateUser('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual({})
    })
  })

  it('sets errors on rejected request', () => {
    const { userAuth, errors, updateUser } = useUserAuth()

    const requestOptions = {
      data: { user: userAuth.value.updateParams },
      method: 'PUT',
    }

    const response = {
      status: 422,
      data: {
        errors: {
          email: ['is invalid' ]
        }
      }
    }

    mocks.default.mockRejectedValue({ response })
    const spy = vi.spyOn(useHTTP, 'default')

    updateUser('/users/sign_in').then(() => {
      expect(spy).toHaveBeenCalledWith('/users/sign_in', requestOptions)
      expect(errors.value).toEqual(response.data.errors)
    })
  })
})
