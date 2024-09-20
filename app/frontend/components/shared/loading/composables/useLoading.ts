import { ref } from 'vue'

export default (initialData: boolean = false) => {
  const loading = ref<boolean>(initialData)

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
