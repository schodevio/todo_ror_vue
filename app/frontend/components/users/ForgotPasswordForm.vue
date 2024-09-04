<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.email"
      label-for="user_email"
      label="E-mail"
      class="mb-3"
    >
      <InputText
        v-model="formData.email"
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

    <p class="text-center text-sm font-light text-gray-500">
      Nevermind,
      <a
        href="/users/sign_in"
        class="font-medium text-indigo-600 hover:underline"
      >
        Sign In
      </a>
    </p>
  </form>
</template>

<script lang="ts" setup>
import { PropType, reactive } from 'vue'

import type { TFormLinks } from '@components/users/types'
import { UserModel } from '@components/users/models/user'

import useUserAuth from '@components/users/composables/useUserAuth'

import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

defineOptions({
  name: 'UserForgotPasswordForm'
})

const props = defineProps({
  links: {
    type: Object as PropType<TFormLinks>,
    required: true
  }
})

const { user, errors, forgotPassword } = useUserAuth()

const formData = reactive<UserModel['forgotPasswordParams']>({
  ...user.value.forgotPasswordParams
})

const handleSubmit = () => {
  forgotPassword(props.links.submit_path, formData)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
