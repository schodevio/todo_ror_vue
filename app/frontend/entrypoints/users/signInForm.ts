import { createApp } from 'vue'
import UserSignInForm from '@components/users/SignInForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { UserSignInForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="user-sign-in-form"]')
