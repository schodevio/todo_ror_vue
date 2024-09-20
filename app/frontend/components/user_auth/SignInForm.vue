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

    <div class="flex justify-end items-center mb-3">
      <a
        :href="props.links.forgot_password_path"
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

    <div class="mb-3">
      <p class="text-center text-sm font-light text-gray-500">
        Didn't receive a confirmation e-mail?
        <a
          :href="props.links.resend_confirmation_path"
          class="font-medium text-indigo-600 hover:underline"
        >
          Resend
        </a>
      </p>
    </div>

    <div class="mb-3">
      <p class="text-center text-sm font-light text-gray-500">
        Don't have an account yet?
        <a
          :href="props.links.sign_up_path"
          class="font-medium text-indigo-600 hover:underline"
        >
          Sign up
        </a>
      </p>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import type { TSignInFormLinks } from '@components/user_auth/types'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  links: {
    type: Object as PropType<TSignInFormLinks>,
    required: true
  }
})

const { userAuth, errors, signIn } = useUserAuth()

const handleSubmit = () => {
  signIn(props.links.submit_path, userAuth.value.signInParams)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
