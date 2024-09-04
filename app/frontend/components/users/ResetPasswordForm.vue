<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.password"
      label-for="user_password"
      label="New Password"
      class="mb-3"
    >
      <InputText
        v-model="formData.password"
        :invalid="!!errors.password"
        name="user[password]"
        id="user_password"
        class="w-full"
        type="password"
      />
    </InputField>

    <InputField
      :errors="errors.password_confirmation"
      label-for="user_password_confirmation"
      label="Password Confirmation"
      class="mb-3"
    >
      <InputText
        v-model="formData.password_confirmation"
        :invalid="!!errors.password_confirmation"
        name="user[password_confirmation]"
        id="user_password_confirmation"
        class="w-full"
        type="password"
      />
    </InputField>

    <div class="my-8">
      <button
        type="submit"
        class="btn btn--primary w-full"
      >
        Change Password
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
import { useUrlSearchParams } from '@vueuse/core'

import type { TFormLinks } from '@components/users/types'
import { UserModel } from '@components/users/models/user'

import useUserAuth from '@components/users/composables/useUserAuth'

import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

defineOptions({
  name: 'UserResetPasswordForm'
})

const props = defineProps({
  links: {
    type: Object as PropType<TFormLinks>,
    required: true
  }
})

const { user, errors, resetPassword } = useUserAuth()
const { reset_password_token } = useUrlSearchParams('history')

const formData = reactive<UserModel['resetPasswordParams']>({
  ...user.value.resetPasswordParams,
  reset_password_token
})

const handleSubmit = () => {
  resetPassword(props.links.submit_path, formData)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
