import { createApp } from 'vue'
import UserSignUpForm from '@components/users/SignUpForm.vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: { UserSignUpForm }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })
app.mount('[data-behavior="user-sign-up-form"]')
