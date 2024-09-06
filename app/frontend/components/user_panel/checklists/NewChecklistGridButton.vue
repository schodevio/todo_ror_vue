<template>
  <button
    @click="handleOpen"
    class="checklist__new-button"
    type="button"
  >
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
      class="icon icon-tabler icons-tabler-outline icon-tabler-hexagon-plus"
    >
      <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
      <path d="M19.875 6.27c.7 .398 1.13 1.143 1.125 1.948v7.284c0 .809 -.443 1.555 -1.158 1.948l-6.75 4.27a2.269 2.269 0 0 1 -2.184 0l-6.75 -4.27a2.225 2.225 0 0 1 -1.158 -1.948v-7.285c0 -.809 .443 -1.554 1.158 -1.947l6.75 -3.98a2.33 2.33 0 0 1 2.25 0l6.75 3.98h-.033z" />
      <path d="M9 12h6" />
      <path d="M12 9v6" />
    </svg>

    <div>New Checklist</div>
  </button>

  <teleport to="body">
    <Dialog
      v-model:visible="dialogOpen"
      class="w-full max-w-2xl"
      header="New Checklist"
      modal
    >
      <ChecklistForm
        @cancel:form="dialogOpen = false"
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

defineOptions({
  name: 'NewChecklistGridItem'
})

const props = defineProps({
  links: {
    type: Object as PropType<TGridLinks>,
    required: true
  }
})

const dialogOpen = ref<boolean>(false)
const { checklist, errors, setChecklist, createChecklist } = useChecklist()

const handleOpen = () => {
  setChecklist()
  dialogOpen.value = true
}

const handleSubmit = (params: ChecklistModel['params']) => {
  createChecklist(props.links.checklists_path, params)
    .then(() => {
      window.dispatchEvent(new CustomEvent('refresh:checklists'))
      dialogOpen.value = false
    })
}
</script>
