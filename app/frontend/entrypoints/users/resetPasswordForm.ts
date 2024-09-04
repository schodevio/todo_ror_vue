import { createApp } from 'vue'
import UserResetPasswordForm from '@components/users/ResetPasswordForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { UserResetPasswordForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="user-reset-password-form"]')
