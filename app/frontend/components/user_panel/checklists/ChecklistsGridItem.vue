<template>
  <a
    :href="checklist.links.checklist_path"
    class="checklist__item"
  >
    <div
      class="checklist__thumbnail"
      :style="{ backgroundImage: `url(${checklist.links.thumbnail_url})` }"
    />

    <h3 class="checklist__title">{{ checklist.name }}</h3>
  </a>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'

defineOptions({
  name: 'ChecklistsGridItem'
})

defineProps({
  checklist: {
    type: ChecklistModel as PropType<ChecklistModel>,
    required: true
  }
})

const random = () => {
  return Math.floor(Math.random() * 24)
}
</script>
