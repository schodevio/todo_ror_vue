import { createApp } from 'vue'
import ResetPasswordForm from '@components/user_auth/ResetPasswordForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ResetPasswordForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="reset-password-form"]')
