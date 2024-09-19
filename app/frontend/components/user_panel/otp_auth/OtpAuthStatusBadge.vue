<template>
  <span :class="classes">
    {{ value ? 'ENABLED' : 'DISABLED' }}
  </span>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, computed } from 'vue'

const props = defineProps({
  value: {
    type: Boolean as PropType<boolean>,
    required: true
  }
})

const classes = computed(() => ({
  'badge': true,
  'badge--lg': true,
  'badge--success': props.value,
  'badge--danger': !props.value
}))
</script>
