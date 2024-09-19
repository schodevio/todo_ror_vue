<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.password"
      label-for="user_password"
      label="New Password"
      class="mb-3"
    >
      <InputText
        v-model="userAuth.password"
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
        v-model="userAuth.password_confirmation"
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
import { useUrlSearchParams } from '@vueuse/core'
//- Models
import type { TResetPasswordFormLinks } from '@components/user_auth/types'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  links: {
    type: Object as PropType<TResetPasswordFormLinks>,
    required: true
  }
})

const { reset_password_token } = useUrlSearchParams<{ reset_password_token: string }>('history')
const { userAuth, errors, resetPassword } = useUserAuth({ reset_password_token })

const handleSubmit = () => {
  resetPassword(props.links.submit_path, userAuth.value.resetPasswordParams)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
