<template>
  <div class="task-view">
    <div
      v-if="editMode"
      class="task-view__form"
    >
      <EditTaskForm
        @close:form="editMode = false"
        :task
      />
    </div>

    <div
      v-else
      class="task-view__wrapper"
    >
      <div class="task-view__header">
        <div class="task-view__title">
          <span>{{ props.task.name }}</span>
        </div>

        <div class="task-view__actions">
          <button
            v-tooltip.bottom="'Edit'"
            @click="editMode = true"
            class="btn btn--icon"
            type="button"
          >
            <IconPencil width="18" />
          </button>

          <button
            v-tooltip.bottom="'Delete'"
            @click="deleteDialogOpen = true"
            class="btn btn--icon"
            type="button"
          >
            <IconTrash width="18" />
          </button>
        </div>
      </div>

      <div class="task-view__content">
        <p>{{ props.task.description }}</p>
      </div>
    </div>
  </div>

  <teleport to="body">
    <Dialog
      v-model:visible="deleteDialogOpen"
      header="Delete Task"
      class="dialog max-w-xl"
      modal
    >
      <div class="dialog__row">
        <IconAlertHexagon
          class="text-red-600"
          width="36"
        />

        <p>Are you sure you want to delete the <strong>{{ props.task.name }}</strong> task?</p>
      </div>

      <div class="dialog__actions">
        <button
          @click="deleteDialogOpen = false"
          type="button"
          class="btn"
        >
          Cancel
        </button>

        <button
          @click="confirmDelete"
          class="btn btn--danger"
          type="button"
        >
          Delete Task
        </button>
      </div>
    </Dialog>
  </teleport>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, ref, watch } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
//- Composables
import useTask from '@components/user_panel/tasks/composables/useTask'
//- Components
import EditTaskForm from '@components/user_panel/tasks/EditTaskForm.vue'
import Dialog from 'primevue/dialog'

import {
  IconAlertHexagon,
  IconPencil,
  IconTrash
} from '@tabler/icons-vue'

const props = defineProps({
  task: {
    type: TaskModel as PropType<TaskModel>,
    required: true
  }
})

//- Edit task
const editMode = ref<boolean>(false)

watch(
  () => props.task,
  () => editMode.value = false
)

//- Delete task
const deleteDialogOpen = ref<boolean>(false)
const { deleteTask } = useTask(props.task)

const confirmDelete = () => {
  deleteTask()
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:tasks:collection'))
      window.dispatchEvent(new CustomEvent('show:task', { detail: {} }))
    })
}
</script>
