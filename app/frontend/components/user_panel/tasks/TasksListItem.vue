<template>
  <div class="tasks-list-item">
    <div class="tasks-list-item__checkbox">
      <Checkbox
        :model-value="props.task.completed"
        @change="handleCompletedChange"
        binary
      />
    </div>

    <button
      @click="handleButtonClick"
      class="tasks-list-item__name"
      type="button"
    >
      <span :class="{ 'line-through': props.task.completed }">
        {{ props.task.name }}
      </span>
    </button>

    <div class="tasks-list-item__actions">
      <IconGripVertical
        class="tasks-list-item__handle"
        width="20"
      />
    </div>
  </div>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
//- Components
import Checkbox from 'primevue/checkbox'
import { IconGripVertical } from '@tabler/icons-vue'

const props = defineProps({
  task: {
    type: Object as PropType<TaskModel>,
    required: true
  }
})

//- (Un)complete task
const { updateTask } = useTask(props.task)

const handleCompletedChange = (event: Event) => {
  const completed = (event.target as HTMLInputElement).checked

  updateTask({ completed })
    .then(() => window.dispatchEvent(new CustomEvent('refresh:tasks:collection')))
}

//- Show task
const handleButtonClick = () => {
  window.dispatchEvent(new CustomEvent('show:task', { detail: props.task }))
}
</script>
