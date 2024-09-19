import { createApp } from 'vue'
import DisableOtpAuthForm from '@components/user_panel/otp_auth/DisableOtpAuthForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { DisableOtpAuthForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="disable-otp-auth-form"]')
