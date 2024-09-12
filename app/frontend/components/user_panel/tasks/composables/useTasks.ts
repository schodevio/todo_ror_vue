//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { TaskModel, TasksCollection } from '@components/user_panel/tasks/models/task'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData?: TaskModel[]) => {
  const state = reactive({
    tasks: new TasksCollection(initialData)
  })

  const setTasks = (items: TaskModel[]) => {
    state.tasks = new TasksCollection(items)
  }

  const fetchTasks = async (path: string) => {
    useHTTP(path, { method: 'GET' })
      .then(response => setTasks(response.data.value.tasks))
  }

  return {
    ...toRefs(state),

    setTasks,
    fetchTasks
  }
}
