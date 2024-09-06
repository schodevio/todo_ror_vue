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

    <InputField
      :errors="errors.password"
      label-for="user_password"
      label="Password"
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

    <div class="flex justify-end items-center mb-3">
      <a
        href="/users/password/new"
        class="text-sm font-medium text-indigo-600 hover:underline"
      >
        Forgot password?
      </a>
    </div>


    <div class="my-8">
      <button
        type="submit"
        class="btn btn--primary w-full"
      >
        Sign In
      </button>
    </div>

    <p class="text-center text-sm font-light text-gray-500">
      Don't have an account yet?
      <a
        href="/users/sign_up"
        class="font-medium text-indigo-600 hover:underline"
      >
        Sign up
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
  name: 'UserSignInForm'
})

const props = defineProps({
  links: {
    type: Object as PropType<TFormLinks>,
    required: true
  }
})

const { user, errors, signIn } = useUserAuth()

const formData = reactive<UserModel['loginParams']>({
  ...user.value.loginParams
})

const handleSubmit = () => {
  signIn(props.links.submit_path, formData)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
