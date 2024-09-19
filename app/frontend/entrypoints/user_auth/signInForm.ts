import { createApp } from 'vue'
import SignInForm from '@components/user_auth/SignInForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { SignInForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="sign-in-form"]')
