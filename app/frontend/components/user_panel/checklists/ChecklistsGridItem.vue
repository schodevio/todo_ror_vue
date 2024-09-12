<template>
  <a
    :href="props.checklist.links.checklist_path"
    class="checklists-grid-item"
  >
    <div
      class="checklists-grid-item__thumbnail"
      :style="styles"
    />

    <h3 class="checklists-grid-item__title">{{ props.checklist.name }}</h3>
  </a>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, computed } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'

const props = defineProps({
  checklist: {
    type: ChecklistModel as PropType<ChecklistModel>,
    required: true
  }
})

const styles = computed(() => {
  const thumbnailUrl = props.checklist.links?.thumbnail_url

  return {
    backgroundImage: thumbnailUrl ? `url(${thumbnailUrl})` : 'none'
  }
})
</script>
