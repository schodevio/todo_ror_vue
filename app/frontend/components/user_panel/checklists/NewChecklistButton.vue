<template>
  <button
    @click="handleOpen"
    class="checklist-new-btn"
    type="button"
  >
    <i class="icon icon-hexagon-plus text-4xl" />
    <div>New Checklist</div>
  </button>

  <teleport to="body">
    <Dialog
      v-model:visible="newDialogOpen"
      class="dialog max-w-2xl"
      header="New Checklist"
      modal
    >
      <ChecklistFormBody
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
import type { TChecklistsLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklist from '@components/user_panel/checklists/composables/useChecklist'
//- Components
import ChecklistFormBody from '@components/user_panel/checklists/ChecklistFormBody.vue'
import Dialog from 'primevue/dialog'

const props = defineProps({
  links: {
    type: Object as PropType<TChecklistsLinks>,
    required: true
  }
})

//- Create checklist
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
