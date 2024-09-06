//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { UserModel } from '@components/users/models/user'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData: Partial<UserModel> = {}) => {
  const state = reactive({
    user: new UserModel(initialData)
  })

  const { loading, startLoading, stopLoading } = useLoading()
  const { errors, setErrors, clearErrors } = useErrors()

  const setUser = (data: Partial<UserModel> = {}) => {
    state.user = new UserModel(data)
    clearErrors()
  }

  const forgotPassword = (path: string, params: UserModel['forgotPasswordParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const resetPassword = (path: string, params: UserModel['resetPasswordParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'PUT', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const signIn = (path: string, params: UserModel['loginParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(() => setErrors({ email: [''], password: ['invalid credentials'] }))
        .finally(stopLoading)
    })
  }

  const signUp = (path: string, params: UserModel['registerParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { user: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  return {
    ...toRefs(state),
    loading,
    errors,

    setUser,
    forgotPassword,
    resetPassword,
    signIn,
    signUp
  }
}
