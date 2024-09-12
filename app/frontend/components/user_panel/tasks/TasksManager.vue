<template>
  <div class="tasks-manager">
    <div class="tasks-manager__col">
      <div class="tasks-manager__form">
        <NewTaskForm :links />
      </div>

      <div class="tasks-manager__list">
        <TasksList :tasks="tasks.models" />
      </div>
    </div>

    <div class="tasks-manager__col">
      <div class="tasks-manager__task">
        <TaskView
          v-if="task.id"
          :key="task.id"
          :task
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
import { useEventListener } from '@vueuse/core'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
import type { TTasksLinks } from '@components/user_panel/tasks/types'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
import useTasks from '@components/user_panel/tasks/composables/useTasks'
//- Components
import NewTaskForm from '@components/user_panel/tasks/NewTaskForm.vue'
import TasksList from '@components/user_panel/tasks/TasksList.vue'
import TaskView from '@components/user_panel/tasks/TaskView.vue'

const props = defineProps({
  tasks: {
    type: Array as PropType<TaskModel[]>,
    default: (): TaskModel[] => []
  },
  links: {
    type: Object as PropType<TTasksLinks>,
    required: true
  }
})

//- Tasks Collection
const { tasks, fetchTasks } = useTasks(props.tasks)
useEventListener(window, 'refresh:tasks:collection', () => fetchTasks(props.links.tasks_path))

//- Single Task
const { task, setTask } = useTask()
useEventListener(window, 'show:task', (event: CustomEvent) => setTask(event.detail))
</script>
