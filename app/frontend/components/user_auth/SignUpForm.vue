<template>
  <form @submit.prevent="handleSubmit">
    <InputField
      :errors="errors.first_name"
      label-for="user_first_name"
      label="First Name"
      class="mb-3"
    >
      <InputText
        v-model="userAuth.first_name"
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
        v-model="userAuth.last_name"
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
        v-model="userAuth.email"
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
        Sign Up
      </button>
    </div>

    <div class="mb-3">
      <p class="text-center text-sm font-light text-gray-500">
        Aleady have an account?
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
import type { TSignUpFormLinks } from '@components/user_auth/types'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  links: {
    type: Object as PropType<TSignUpFormLinks>,
    required: true
  }
})

const { userAuth, errors, signUp } = useUserAuth()

const handleSubmit = () => {
  signUp(props.links.submit_path, userAuth.value.signUpParams)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
