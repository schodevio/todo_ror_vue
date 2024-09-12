<template>
  <div class="task-view">
    <div v-if="editMode" class="task-view__form">
      <TaskForm
        @close:form="editMode = false"
        :task
      />
    </div>

    <div v-else class="task-view__wrapper">
      <div class="task-view__header">
        <div class="task-view__title">
          <span>{{ task.name }}</span>
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
            class="btn btn--icon"
            type="button"
          >
            <IconTrash width="18" />
          </button>
        </div>
      </div>

      <div class="task-view__content">
        <p>{{ task.description }}</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, ref, watch } from 'vue'
//- Models
import { TaskModel } from '@components/user_panel/tasks/models/task'
//- Components
import TaskForm from '@components/user_panel/tasks/TaskForm.vue'
import { IconPencil, IconTrash } from '@tabler/icons-vue'

const props = defineProps({
  task: {
    type: Object as PropType<TaskModel>,
    required: true
  }
})

const editMode = ref<boolean>(false)

watch(
  () => props.task,
  () => editMode.value = false
)
</script>
