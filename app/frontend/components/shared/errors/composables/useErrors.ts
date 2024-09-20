import { ref } from 'vue'

import type { TErrors } from '@components/shared/errors/types'

export default (initialData: TErrors = {}) => {
  const errors = ref<TErrors>(initialData)

  const setErrors = (data: TErrors) => {
    errors.value = data
  }

  const clearErrors = () => {
    errors.value = {}
  }

  return {
    errors,

    setErrors,
    clearErrors
  }
}
