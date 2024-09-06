<template>
  <div class="checklist__grid">
    <NewChecklistGridButton :links />

    <ChecklistsGridItem
      v-for="checklist in checklists.models"
      :key="checklist.id"
      :checklist
    />
  </div>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
import { useEventListener } from '@vueuse/core'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TGridLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklists from '@components/user_panel/checklists/composables/useChecklists'
//- Components
import ChecklistsGridItem from '@components/user_panel/checklists/ChecklistsGridItem.vue'
import NewChecklistGridButton from '@components/user_panel/checklists/NewChecklistGridButton.vue'

defineOptions({
  name: 'ChecklistsGrid'
})

const props = defineProps({
  checklists: {
    type: Array as PropType<ChecklistModel[]>,
    default: (): ChecklistModel[] => []
  },
  links: {
    type: Object as PropType<TGridLinks>,
    required: true
  }
})

const { checklists, fetchChecklists } = useChecklists(props.checklists)
useEventListener(window, 'refresh:checklists', () => fetchChecklists(props.links.checklists_path))
</script>
