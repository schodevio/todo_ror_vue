<template>
  <div class="input-field">
    <label
      v-if="label"
      :for="labelFor"
      class="input-field__label"
    >
      {{ label }}
    </label>

    <slot />

    <div
      v-if="errors.length > 0"
      class="input-field__error"
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
