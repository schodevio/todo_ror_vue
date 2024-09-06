import { createApp } from 'vue'
import ChecklistsGrid from '@components/user_panel/checklists/ChecklistsGrid.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ChecklistsGrid }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="checklists-grid"]')
