import { createApp, defineAsyncComponent } from 'vue'

import PrimeVue from 'primevue/config'
import MyTheme from '@utils/primeTheme'

const app = createApp({
  components: {
    HelloWorld: defineAsyncComponent(
      () => import('@components/HelloWorld.vue')
    )
   }
})

app.use(PrimeVue, { theme: { preset: MyTheme } })

app.mount('[data-behavior="hello-world"]')
