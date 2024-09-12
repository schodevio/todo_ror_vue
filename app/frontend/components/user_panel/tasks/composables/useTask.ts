//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
//- Composables
import useErrors from '@components/shared/errors/composables/useErrors'
import useLoading from '@components/shared/loading/composables/useLoading'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData: Partial<TaskModel> = {}) => {
  const state = reactive({
    task: new TaskModel(initialData)
  })

  const { loading, startLoading, stopLoading } = useLoading()
  const { errors, setErrors, clearErrors } = useErrors()

  const setTask = (data: Partial<TaskModel> = {}) => {
    state.task = new TaskModel(data)
    clearErrors()
  }

  const createTask = (path: string, params: Partial<TaskModel['params']>) => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(path, { method: 'POST', data: { task: params } })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const updateTask = (params: Partial<TaskModel['params']>) => {
    startLoading()
    clearErrors()

    return new Promise<void>(resolve => {
      useHTTP(state.task.links.task_path, { method: 'PUT', data: { task: params } })
        .then(response => {
          setTask(response.data.value.task)
          resolve()
        })
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  const deleteTask = () => {
    startLoading()
    clearErrors()

    return new Promise(resolve => {
      useHTTP(state.task.links.task_path, { method: 'DELETE' })
        .then(resolve)
        .catch(error => setErrors(error.response.data.errors))
        .finally(stopLoading)
    })
  }

  return {
    ...toRefs(state),
    loading,
    errors,

    setTask,
    createTask,
    updateTask,
    deleteTask
  }
}
