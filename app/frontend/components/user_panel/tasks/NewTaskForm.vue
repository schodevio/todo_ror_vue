<template>
  <form @submit.prevent="handleSubmit">
    <div class="flex items-start gap-2">
      <InputField
        :errors="errors.name"
        label-for="task_name"
        class="flex-1"
      >
        <InputText
          v-model="task.name"
          :invalid="!!errors.name"
          placeholder="A short task name..."
          name="task[name]"
          id="task_name"
          class="w-full"
          type="text"
        />
      </InputField>

      <button
        type="submit"
        class="btn btn--primary"
      >
        <i class="icon icon-plus" />
        <span>Add Task</span>
      </button>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import type { TTasksLinks } from '@components/user_panel/tasks/types'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  links: {
    type: Object as PropType<TTasksLinks>,
    required: true
  }
})

//- Create task
const { task, errors, setTask, createTask } = useTask()

const handleSubmit = () => {
  createTask(props.links.tasks_path, task.value.params)
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:tasks:collection'))
      setTask()
    })
}
</script>
