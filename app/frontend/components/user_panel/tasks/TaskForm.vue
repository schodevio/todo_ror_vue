<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.name"
      label-for="task_name"
      label="Task Name"
      class="mb-3"
    >
      <InputText
        v-model="task.name"
        :invalid="!!errors.name"
        placeholder="Task Name"
        name="task[name]"
        id="task_name"
        class="w-full"
        type="text"
      />
    </InputField>

    <InputField
      :errors="errors.description"
      label-for="task_description"
      label="Description"
      class="mb-3"
    >
      <Textarea
        v-model="task.description"
        :invalid="!!errors.description"
        placeholder="Your short description here..."
        name="task[description]"
        id="task_description"
        class="w-full"
        rows="4"
        auto-resize
      />
    </InputField>

    <div class="task-view__actions">
      <button
        @click="emit('close:form')"
        type="button"
        class="btn"
      >
        Cancel
      </button>

      <button
        type="submit"
        class="btn btn--primary"
      >
        Save Task
      </button>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'
import Textarea from 'primevue/textarea'

const props = defineProps({
  task: {
    type: Object as PropType<TaskModel>,
    required: true
  }
})

const emit = defineEmits<{
  (e: 'close:form'): void
}>()

const { task, errors, updateTask} = useTask(props.task)

const handleSubmit = () => {
  updateTask(task.value.params)
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:tasks:collection'))
      window.dispatchEvent(new CustomEvent('show:task', { detail: task.value }))
    })
}
</script>
