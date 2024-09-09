<template>
  <button
    @click="actionsPopover.toggle"
    class="btn btn--icon"
  >
    <IconDotsVertical width="24" />
  </button>

  <Popover
    ref="actionsPopover"
    class="dropdown"
  >
    <ul @click="actionsPopover.toggle">
      <li class="dropdown__item">
        <button
          @click="handleEdit"
          type="button"
        >
          <IconPencil width="16" />
          Edit
        </button>
      </li>

      <li class="dropdown__item">
        <button
          @click="handleDelete"
          type="button"
        >
          <IconTrash width="16" />
          Delete
        </button>
      </li>
    </ul>
  </Popover>

  <teleport to="body">
    <Dialog
      v-model:visible="editDialogOpen"
      class="dialog max-w-2xl"
      header="Edit Checklist"
      modal
    >
      <ChecklistForm
        @cancel:form="editDialogOpen = false"
        @submit:form="handleSubmit"
        :checklist
        :errors
      />
    </Dialog>

    <Dialog
      v-model:visible="deleteDialogOpen"
      class="dialog"
      header="Delete Checklist"
      modal
    >
      <div class="dialog__row">
        <IconAlertHexagon width="36" class="text-red-600" />

        <p>
          Are you sure you want to delete the <strong>{{ checklist.name }}</strong> checklist?
          <br />
          This action is irreversible.
        </p>
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
          type="button"
          class="btn btn--danger"
        >
          Delete Checklist
        </button>
      </div>
    </Dialog>
  </teleport>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, ref } from 'vue'
import { useBrowserLocation } from '@vueuse/core'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TGridLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklist from '@components/user_panel/checklists/composables/useChecklist'
//- Components
import ChecklistForm from '@components/user_panel/checklists/ChecklistForm.vue'
import Dialog from 'primevue/dialog'
import Popover from 'primevue/popover'

import {
  IconAlertHexagon,
  IconDotsVertical,
  IconPencil,
  IconTrash
} from '@tabler/icons-vue'

const props = defineProps({
  checklist: {
    type: Object as PropType<ChecklistModel>,
    required: true
  },
  links: {
    type: Object as PropType<TGridLinks>,
    required: true
  }
})

const actionsPopover = ref<typeof Popover>()
const editDialogOpen = ref<boolean>(false)
const deleteDialogOpen = ref<boolean>(false)

const {
  checklist,
  errors,
  setChecklist,
  updateChecklist,
  deleteChecklist
} = useChecklist(props.checklist)

const location = useBrowserLocation()

//- Edit
const handleEdit = () => {
  setChecklist(props.checklist)
  editDialogOpen.value = true
}

const handleSubmit = (params: ChecklistModel['params']) => {
  updateChecklist(params)
    .then((response: any) => {
      const detail = response.data.value.checklist as ChecklistModel

      window.dispatchEvent(new CustomEvent('refresh:checklists:item', { detail }))
      editDialogOpen.value = false
    })
}

//- Delete
const handleDelete = () => {
  setChecklist(props.checklist)
  deleteDialogOpen.value = true
}

const confirmDelete = () => {
  deleteChecklist()
    .then(() => location.value.pathname = props.links.checklists_path)
}
</script>
