//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import { objectToFormData } from '@utils/forms'
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

    const checklistParams = params.thumbnail
      ? objectToFormData(params, 'checklist')
      : { checklist: params }

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: checklistParams, multipart: true })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const updateChecklist = (params: ChecklistModel['params']) => {
    startLoading()
    clearErrors()

    const checklistParams = params.thumbnail
      ? objectToFormData(params, 'checklist')
      : { checklist: params }

    return new Promise(resolve => {
      useHTTP(state.checklist.links.checklist_path, { method: 'PUT', data: checklistParams, multipart: true })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const deleteChecklist = () => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(state.checklist.links.checklist_path, { method: 'DELETE' })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const sendEmailChecklist = (params: ChecklistModel['sendEmailParams']) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(state.checklist.links.send_email_checklist_path, { method: 'POST', data: { checklist: params } })
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
    createChecklist,
    updateChecklist,
    deleteChecklist,
    sendEmailChecklist
  }
}
