<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.email"
      label-for="user_email"
      label="E-mail"
      class="mb-3"
    >
      <InputText
        v-model="userAuth.email"
        :invalid="!!errors.email"
        name="user[email]"
        id="user_email"
        class="w-full"
        type="email"
      />
    </InputField>

    <div class="my-8">
      <button
        type="submit"
        class="btn btn--primary w-full"
      >
        Send Reset Password Instructions
      </button>
    </div>

    <div class="mb-3">
      <p class="text-center text-sm font-light text-gray-500">
        Nevermind,
        <a
          :href="props.links.sign_in_path"
          class="font-medium text-indigo-600 hover:underline"
        >
          Sign in
        </a>
      </p>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import type { TForgotPasswordFormLinks } from '@components/user_auth/types'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  links: {
    type: Object as PropType<TForgotPasswordFormLinks>,
    required: true
  }
})

const { userAuth, errors, forgotPassword } = useUserAuth()

const handleSubmit = () => {
  forgotPassword(props.links.submit_path, userAuth.value.forgotPasswordParams)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
