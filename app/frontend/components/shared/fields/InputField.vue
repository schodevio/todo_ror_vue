<template>
  <div>
    <label
      v-if="label"
      :for="labelFor"
      class="block mb-2 text-sm font-medium text-gray-900"
      >
      {{ label }}
    </label>

    <slot />

    <div
      v-if="errors.length > 0"
      class="block mt-1 text-sm text-red-600"
      >
      {{ errors[0] }}
    </div>
  </div>
</template>

<script lang="ts" setup>
import { PropType } from 'vue'

defineProps({
  errors: {
    type: Array as PropType<string[]>,
    default: (): string[] => []
  },
  labelFor: {
    type: String as PropType<string>,
    required: true
  },
  label: {
    type: String as PropType<string>,
    default: undefined
  }
})
</script>
