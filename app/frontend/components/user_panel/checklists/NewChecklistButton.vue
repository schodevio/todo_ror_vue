<template>
  <button
    @click="handleOpen"
    class="checklist-new"
    type="button"
  >
    <IconHexagonPlus width="24" />
    <div>New Checklist</div>
  </button>

  <teleport to="body">
    <Dialog
      v-model:visible="newDialogOpen"
      class="w-full max-w-2xl"
      header="New Checklist"
      modal
    >
      <ChecklistForm
        @cancel:form="newDialogOpen = false"
        @submit:form="handleSubmit"
        :checklist
        :errors
      />
    </Dialog>
  </teleport>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, ref } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TGridLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklist from '@components/user_panel/checklists/composables/useChecklist'
//- Components
import ChecklistForm from '@components/user_panel/checklists/ChecklistForm.vue'
import Dialog from 'primevue/dialog'

import { IconHexagonPlus } from '@tabler/icons-vue'

const props = defineProps({
  links: {
    type: Object as PropType<TGridLinks>,
    required: true
  }
})

const newDialogOpen = ref<boolean>(false)
const { checklist, errors, setChecklist, createChecklist } = useChecklist()

const handleOpen = () => {
  setChecklist()
  newDialogOpen.value = true
}

const handleSubmit = (params: ChecklistModel['params']) => {
  createChecklist(props.links.checklists_path, params)
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:checklists:collection'))
      newDialogOpen.value = false
    })
}
</script>
