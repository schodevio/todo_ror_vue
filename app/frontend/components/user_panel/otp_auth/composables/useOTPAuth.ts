//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { OTPAuthModel } from '@components/user_panel/otp_auth/models/otpAuth'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData: Partial<OTPAuthModel> = {}) => {
  const state = reactive({
    otpAuth: new OTPAuthModel(initialData)
  })

  const { loading, startLoading, stopLoading } = useLoading()
  const { errors, setErrors, clearErrors } = useErrors()

  const setOTPAuth = (data: Partial<OTPAuthModel> = {}) => {
    state.otpAuth = new OTPAuthModel(data)
    clearErrors()
  }

  const disableOTPAuth = (path: string, params: OTPAuthModel['disableParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'DELETE', data: { otp_auth: params } })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const enableOTPAuth = (path: string, params: OTPAuthModel['enableParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { otp_auth: params } })
        .then(response => {
          setOTPAuth(response.data.value.otp_auth)
          resolve(response)
        })
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const verifyOTPCode = (path: string, params: OTPAuthModel['verifyParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'PUT', data: { otp_auth: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  return {
    ...toRefs(state),
    loading,
    errors,

    setOTPAuth,
    disableOTPAuth,
    enableOTPAuth,
    verifyOTPCode
  }
}
