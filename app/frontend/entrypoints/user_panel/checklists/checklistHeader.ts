import { createApp } from 'vue'
import ChecklistHeader from '@components/user_panel/checklists/ChecklistHeader.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ChecklistHeader }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="checklist-header"]')
