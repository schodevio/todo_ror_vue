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

  const forgotPassword = (path: string, params: UserAuthModel['forgotPasswordParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const resetPassword = (path: string, params: UserAuthModel['resetPasswordParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'PUT', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const signIn = (path: string, params: UserAuthModel['signInParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(() => setErrors({ email: [''], password: ['invalid credentials'] }))
        .finally(stopLoading)
    })
  }

  const signUp = (path: string, params: UserAuthModel['signUpParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const updateUser = (path: string, params: UserAuthModel['updateParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'PUT', data: { user: params }})
        .then(resolve)
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
    signIn,
    signUp,
    updateUser
  }
}
