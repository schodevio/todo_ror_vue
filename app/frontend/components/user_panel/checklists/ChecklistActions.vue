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
        <a
          :href="checklist.links.export_checklist_pdf_path"
          target="_blank"
        >
          <IconFileArrowRight width="16" />
          Export to PDF
        </a>
      </li>

      <li class="dropdown__item">
        <button
          @click="handleSendEmail"
          type="button"
        >
          <IconSend width="16" />
          Send via E-mail
        </button>
      </li>

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
      v-model:visible="sendEmailDialogOpen"
      header="Send Checklist via E-mail"
      class="dialog"
      modal
    >
      <SendEmailForm
        @cancel:form="sendEmailDialogOpen = false"
        @submit:form="handleSendEmailFormSubmit"
        :checklist
        :errors
      />
    </Dialog>

    <Dialog
      v-model:visible="editDialogOpen"
      header="Edit Checklist"
      class="dialog max-w-2xl"
      modal
    >
      <ChecklistFormBody
        @cancel:form="editDialogOpen = false"
        @submit:form="handleEditFormSubmit"
        :checklist
        :errors
      />
    </Dialog>

    <Dialog
      v-model:visible="deleteDialogOpen"
      header="Delete Checklist"
      class="dialog"
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
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TChecklistsLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklist from '@components/user_panel/checklists/composables/useChecklist'
//- Components
import ChecklistFormBody from '@components/user_panel/checklists/ChecklistFormBody.vue'
import SendEmailForm from '@components/user_panel/checklists/SendEmailForm.vue'
import Dialog from 'primevue/dialog'
import Popover from 'primevue/popover'

import {
  IconAlertHexagon,
  IconDotsVertical,
  IconFileArrowRight,
  IconPencil,
  IconSend,
  IconTrash
} from '@tabler/icons-vue'

const props = defineProps({
  checklist: {
    type: Object as PropType<ChecklistModel>,
    required: true
  },
  links: {
    type: Object as PropType<TChecklistsLinks>,
    required: true
  }
})

const actionsPopover = ref<typeof Popover>()

const {
  checklist,
  errors,
  setChecklist,
  updateChecklist,
  deleteChecklist,
  sendEmailChecklist
} = useChecklist(props.checklist)

//- Send via e-mail
const sendEmailDialogOpen = ref<boolean>(false)

const handleSendEmail = () => {
  setChecklist(props.checklist)
  sendEmailDialogOpen.value = true
}

const handleSendEmailFormSubmit = (params: ChecklistModel['sendEmailParams']) => {
  sendEmailChecklist(params)
    .then(() => sendEmailDialogOpen.value = false)
}

//- Edit checklist
const editDialogOpen = ref<boolean>(false)

const handleEdit = () => {
  setChecklist(props.checklist)
  editDialogOpen.value = true
}

const handleEditFormSubmit = (params: ChecklistModel['params']) => {
  updateChecklist(params)
    .then(() => window.location.reload())
}

//- Delete checklist
const deleteDialogOpen = ref<boolean>(false)

const handleDelete = () => {
  setChecklist(props.checklist)
  deleteDialogOpen.value = true
}

const confirmDelete = () => {
  deleteChecklist()
    .then(() => window.location.pathname = props.links.checklists_path)
}
</script>
