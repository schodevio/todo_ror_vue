<template>
  <a
    :href="checklist.links.checklist_path"
    class="checklist__item"
  >
    <div
      class="checklist__thumbnail"
      :style="{ backgroundImage }"
    />

    <h3 class="checklist__title">{{ checklist.name }}</h3>
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

const backgroundImage = computed(() => {
  const thumbnailUrl = props.checklist.links?.thumbnail_url

  return thumbnailUrl ? `url(${thumbnailUrl})` : 'none'
})
</script>
