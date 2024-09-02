<template>
  <h1 class="text-3xl font-bold">Hello {{ name }}!</h1>
  <Select v-model="name" :options="options" />
</template>

<script lang="ts" setup>
import { ref } from 'vue'

import Select from 'primevue/select'

const name = ref<string>('Vue')

const options: string[] = ['Vue', 'React', 'Svelte']
</script>
