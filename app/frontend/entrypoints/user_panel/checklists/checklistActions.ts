import { createApp } from 'vue'
import ChecklistActions from '@components/user_panel/checklists/ChecklistActions.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ChecklistActions }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="checklist-actions"]')
