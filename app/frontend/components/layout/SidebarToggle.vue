<template>
  <button
    @click="handleClick"
    class="btn btn--icon"
    type="button"
  >
    <IconArrowsHorizontal width="16" />
  </button>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { useCookies } from '@vueuse/integrations/useCookies'
import { IconArrowsHorizontal } from '@tabler/icons-vue'

const sidebarElement = document.querySelector('.sidebar')

const cookies = useCookies(['isSidebarMini'])
const isMini = ref(cookies.get('isSidebarMini'))

const handleClick = () => {
  isMini.value = !isMini.value

  cookies.set('isSidebarMini', isMini.value)
  sidebarElement && sidebarElement.classList.toggle('sidebar--mini')
}
</script>
