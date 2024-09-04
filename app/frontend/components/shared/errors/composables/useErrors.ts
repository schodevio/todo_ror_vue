import { ref } from 'vue'

import type { TErrors } from '@components/shared/errors/types'

export default () => {
  const errors = ref<TErrors>({})

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
