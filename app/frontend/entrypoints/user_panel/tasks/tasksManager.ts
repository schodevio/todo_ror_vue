import { createApp } from 'vue'
import TasksManager from '@components/user_panel/tasks/TasksManager.vue'

import Tooltip from 'primevue/tooltip'
import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { TasksManager }
})

app.directive('tooltip', Tooltip)
app.use(PrimeVue, { theme: { preset: MyTheme } })

app.mount('[data-behavior="tasks-manager"]')
