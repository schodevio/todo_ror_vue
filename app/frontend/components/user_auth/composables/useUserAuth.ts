//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { UserAuthModel } from '@components/user_auth/models/userAuth'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData: Partial<UserAuthModel> = {}) => {
  const state = reactive({
    userAuth: new UserAuthModel(initialData)
  })

  const { loading, startLoading, stopLoading } = useLoading()
  const { errors, setErrors, clearErrors } = useErrors()

  const setUserAuth = (data: Partial<UserAuthModel> = {}) => {
    state.userAuth = new UserAuthModel(data)
    clearErrors()
  }

  const forgotPassword = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'POST', data: { user: state.userAuth.forgotPasswordParams }})
        .then(() => resolve())
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const resetPassword = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'PUT', data: { user: state.userAuth.resetPasswordParams }})
        .then(() => resolve())
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const resendConfirmation = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'POST', data: { user: state.userAuth.resendConfirmationParams }})
        .then(() => resolve())
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const signIn = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'POST', data: { user: state.userAuth.signInParams }})
        .then(() => resolve())
        .catch(() => setErrors({ base: ['invalid credentials'] }))
        .finally(stopLoading)
    })
  }

  const signUp = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'POST', data: { user: state.userAuth.signUpParams }})
        .then(() => resolve())
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const updateUser = (path: string) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(path, { method: 'PUT', data: { user: state.userAuth.updateParams }})
        .then(() => resolve())
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  return {
    ...toRefs(state),
    loading,
    errors,

    setUserAuth,
    forgotPassword,
    resetPassword,
    resendConfirmation,
    signIn,
    signUp,
    updateUser
  }
}
