import { createApp } from 'vue'
import EditUserForm from '@components/user_auth/EditUserForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { EditUserForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="edit-user-form"]')
