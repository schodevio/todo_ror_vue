import { createApp } from 'vue'
import ForgotPasswordForm from '@components/user_auth/ForgotPasswordForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ForgotPasswordForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="forgot-password-form"]')
