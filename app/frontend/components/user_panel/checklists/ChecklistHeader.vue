<template>
  <h2>{{ checklist.name }}</h2>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
import { useEventListener } from '@vueuse/core'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
//- Composables
import useChecklist from '@components/user_panel/checklists/composables/useChecklist'

const props = defineProps({
  checklist: {
    type: Object as PropType<ChecklistModel>,
    required: true
  }
})

const { checklist, setChecklist } = useChecklist(props.checklist)
useEventListener(window, 'refresh:checklists:item', ({ detail }: CustomEvent) => setChecklist(detail))
</script>
