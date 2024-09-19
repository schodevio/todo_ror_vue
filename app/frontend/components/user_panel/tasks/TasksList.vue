<template>
  <Draggable
    :list="tasks"
    @change="handlePositionChange"
    handle=".tasks-list-item__handle"
    class="tasks-list"
    item-key="id"
  >
    <template #item="{ element }">
      <TasksListItem :task="element" />
    </template>
  </Draggable>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
import type { TPositionChangeEvent } from '@components/user_panel/tasks/types'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
//- Components
import TasksListItem from '@components/user_panel/tasks/TasksListItem.vue'
import Draggable from 'vuedraggable'

defineProps({
  tasks: {
    type: Array as PropType<TaskModel[]>,
    default: (): TaskModel[] => []
  }
})

//- Update task position
const { setTask, updateTask } = useTask()

const handlePositionChange = (event: TPositionChangeEvent<TaskModel>) => {
  setTask(event.moved.element)

  updateTask({ position: event.moved.newIndex + 1 })
    .then(() => window.dispatchEvent(new CustomEvent('refresh:tasks:collection')))
}
</script>
