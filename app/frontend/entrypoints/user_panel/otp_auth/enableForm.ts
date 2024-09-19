import { createApp } from 'vue'
import EnableOtpAuthForm from '@components/user_panel/otp_auth/EnableOtpAuthForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { EnableOtpAuthForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="enable-otp-auth-form"]')
