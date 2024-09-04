import { createApp } from 'vue'
import UserForgotPasswordForm from '@components/users/ForgotPasswordForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { UserForgotPasswordForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="user-forgot-password-form"]')
