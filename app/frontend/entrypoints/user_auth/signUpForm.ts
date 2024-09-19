import { createApp } from 'vue'
import SignUpForm from '@components/user_auth/SignUpForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { SignUpForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="sign-up-form"]')
