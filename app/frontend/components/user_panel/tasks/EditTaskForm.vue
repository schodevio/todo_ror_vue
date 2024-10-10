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
      <Editor
        v-model="task.description"
        content-type="html"
      >
        <template #toolbar>
          <span class="ql-formats">
            <select
              v-tooltip.bottom="'Font'"
              class="ql-font"
            />

            <button
              v-tooltip.bottom="'Header'"
              class="ql-header"
              value="1"
            />

            <button
              v-tooltip.bottom="'Subheader'"
              class="ql-header"
              value="2"
            />
          </span>

          <span class="ql-formats">
            <button
              v-tooltip.bottom="'Bold'"
              class="ql-bold"
            />

            <button
              v-tooltip.bottom="'Italic'"
              class="ql-italic"
            />

            <button
              v-tooltip.bottom="'Underline'"
              class="ql-underline"
            />

            <button
              v-tooltip.bottom="'Strike'"
              class="ql-strike"
            />
          </span>

          <span class="ql-formats">
            <button
              v-tooltip.bottom="'Blockquote'"
              class="ql-blockquote"
            />

            <button
              v-tooltip.bottom="'Code'"
              class="ql-code-block"
            />
          </span>

          <span class="ql-formats">
            <select
              v-tooltip.bottom="'Color'"
              class="ql-color"
            />

            <select
              v-tooltip.bottom="'Background'"
              class="ql-background"
            />
          </span>

          <span class="ql-formats">
            <button
              v-tooltip.bottom="'Ordered List'"
              class="ql-list"
              value="ordered"
            />

            <button
              v-tooltip.bottom="'List'"
              class="ql-list"
              value="bullet"
            />

            <button
              v-tooltip.bottom="'Add Indentation'"
              class="ql-indent"
              value="-1"
            />

            <button
              v-tooltip.bottom="'Remove Indentation'"
              class="ql-indent"
              value="+1"
            />
          </span>

          <span class="ql-formats">
            <select
              v-tooltip.bottom="'Align'"
              class="ql-align"
            />
          </span>
        </template>
      </Editor>
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
        class="btn btn--primary"
        type="submit"
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
import Editor from 'primevue/editor'
import InputText from 'primevue/inputtext'

const props = defineProps({
  task: {
    type: TaskModel as PropType<TaskModel>,
    required: true
  }
})

const emit = defineEmits<{
  (e: 'close:form'): void
}>()

//- Update task
const { task, errors, updateTask } = useTask(props.task)

const handleSubmit = () => {
  updateTask(task.value.params)
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:tasks:collection'))
      window.dispatchEvent(new CustomEvent('show:task', { detail: task.value }))
    })
}
</script>
