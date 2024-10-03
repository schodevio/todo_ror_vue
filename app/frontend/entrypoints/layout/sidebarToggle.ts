import { createApp } from 'vue'
import SidebarToggle from '@components/layout/SidebarToggle.vue'

const app = createApp({
  components: { SidebarToggle }
})

app.mount('[data-behavior="sidebar-toggle"]')
