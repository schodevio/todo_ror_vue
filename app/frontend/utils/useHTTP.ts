import axios, { AxiosRequestConfig, AxiosHeaders } from 'axios'
import { useAxios } from '@vueuse/integrations/useAxios'

export default (path: string, config?: AxiosRequestConfig & { multipart?: boolean }) => {
  const instance = axios.create()

  instance.interceptors.request.use(
    requestConfig => {
      const contentType = config.multipart ? 'multipart/form-data' : 'application/json'
      const csrfMeta = <HTMLMetaElement>document.querySelector('meta[name=csrf-token]')

      const options = {
        baseURL: window.location.origin,
        headers: new AxiosHeaders({
          'Accept': 'application/json',
          'Content-Type': contentType,
          'X-CSRF-Token': csrfMeta.content
        })
      }

      return { ...requestConfig, ...options }
    },
    requestError => {
      // Raven.captureException(requestError)

      return Promise.reject(requestError)
    }
  )

  instance.interceptors.response.use(
    response => response,
    error => {
      switch (error.response.status) {
        case 401:
          if (!error.config.url.endsWith('sign_in')) window.location.pathname = '/'
        case 422:
          break
        default:
          // Raven.captureException(error)
      }

      return Promise.reject(error)
    }
  )

  return useAxios(path, config, instance)
}
