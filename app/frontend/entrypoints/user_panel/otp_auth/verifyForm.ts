import { createApp } from 'vue'
import VerifyOtpCodeForm from '@components/user_panel/otp_auth/VerifyOtpCodeForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { VerifyOtpCodeForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="verify-otp-code-form"]')
