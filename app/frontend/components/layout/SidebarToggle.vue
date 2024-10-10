<template>
  <button
    @click="handleClick"
    class="btn btn--icon"
    type="button"
  >
    <i class="icon icon-arrows-horizontal" />
  </button>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { useCookies } from '@vueuse/integrations/useCookies'

const sidebarElement = document.querySelector('.sidebar')

const cookies = useCookies(['isSidebarMini'])
const isMini = ref(cookies.get('isSidebarMini'))

const handleClick = () => {
  isMini.value = !isMini.value

  cookies.set('isSidebarMini', isMini.value)
  if (sidebarElement) sidebarElement.classList.toggle('sidebar--mini')
}
</script>
