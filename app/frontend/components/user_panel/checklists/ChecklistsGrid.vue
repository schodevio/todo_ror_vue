<template>
  <div class="checklists-grid">
    <NewChecklistButton :links="props.links" />

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
import type { TChecklistsLinks } from '@components/user_panel/checklists/types'
//- Composables
import useChecklists from '@components/user_panel/checklists/composables/useChecklists'
//- Components
import ChecklistsGridItem from '@components/user_panel/checklists/ChecklistsGridItem.vue'
import NewChecklistButton from '@components/user_panel/checklists/NewChecklistButton.vue'

const props = defineProps({
  checklists: {
    type: Array as PropType<ChecklistModel[]>,
    default: (): ChecklistModel[] => []
  },
  links: {
    type: Object as PropType<TChecklistsLinks>,
    required: true
  }
})

//- Checklists collection
const { checklists, fetchChecklists } = useChecklists(props.checklists)
useEventListener(window, 'refresh:checklists:collection', () => fetchChecklists(props.links.checklists_path))
</script>
