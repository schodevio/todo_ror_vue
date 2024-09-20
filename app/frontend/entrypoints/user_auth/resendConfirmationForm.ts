import { createApp } from 'vue'
import ResendConfirmationForm from '@components/user_auth/ResendConfirmationForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { ResendConfirmationForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="resend-confirmation-form"]')
