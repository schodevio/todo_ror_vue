//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData: Partial<ChecklistModel> = {}) => {
  const state = reactive({
    checklist: new ChecklistModel(initialData)
  })

  const { loading, startLoading, stopLoading } = useLoading()
  const { errors, setErrors, clearErrors } = useErrors()

  const setChecklist = (data: Partial<ChecklistModel> = {}) => {
    state.checklist = new ChecklistModel(data)
    clearErrors()
  }

  const createChecklist = (path: string, params: ChecklistModel['params']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { checklist: params }})
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  return {
    ...toRefs(state),
    loading,
    errors,

    setChecklist,
    createChecklist
  }
}
