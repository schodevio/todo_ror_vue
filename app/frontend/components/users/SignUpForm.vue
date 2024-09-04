<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.first_name"
      label-for="user_first_name"
      label="First Name"
      class="mb-3"
    >
      <InputText
        v-model="formData.first_name"
        :invalid="!!errors.first_name"
        name="user[first_name]"
        id="user_first_name"
        class="w-full"
        type="text"
      />
    </InputField>

    <InputField
      :errors="errors.last_name"
      label-for="user_last_name"
      label="Last Name"
      class="mb-3"
    >
      <InputText
        v-model="formData.last_name"
        :invalid="!!errors.last_name"
        name="user[last_name]"
        id="user_last_name"
        class="w-full"
        type="text"
      />
    </InputField>

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
        Sign Up
      </button>
    </div>

    <p class="text-center text-sm font-light text-gray-500">
      Aleady have an account?
      <a
        href="/users/sign_in"
        class="font-medium text-indigo-600 hover:underline"
      >
        Sign in
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
  name: 'UserSignUpForm'
})

const props = defineProps({
  links: {
    type: Object as PropType<TFormLinks>,
    required: true
  }
})

const { user, errors, signUp } = useUserAuth()

const formData = reactive<UserModel['registerParams']>({
  ...user.value.registerParams
})

const handleSubmit = () => {
  signUp(props.links.submit_path, formData)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
