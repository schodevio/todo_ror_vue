import { ref } from 'vue'

export default (initial: boolean = false) => {
  const loading = ref<boolean>(initial)

  const startLoading = () => {
    loading.value = true
  }

  const stopLoading = () => {
    loading.value = false
  }

  return {
    loading,

    startLoading,
    stopLoading
  }
}
