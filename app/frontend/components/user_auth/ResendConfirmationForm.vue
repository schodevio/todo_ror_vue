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
      <div
        v-if="isSubmitSuccess"
        class="btn btn--success w-full"
      >
        <IconSend width="20px" />
        Email has been sent!
      </div>

      <button
        v-else
        type="submit"
        class="btn btn--primary w-full"
      >
        Resend Confirmation Instructions
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
import { PropType, ref } from 'vue'
//- Models
import type { TResendConfirmationFormLinks } from '@components/user_auth/types'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'
import { IconSend } from '@tabler/icons-vue'

const props = defineProps({
  links: {
    type: Object as PropType<TResendConfirmationFormLinks>,
    required: true
  }
})

const { userAuth, errors, resendConfirmation } = useUserAuth()
const isSubmitSuccess = ref<boolean>()

const handleSubmit = () => {
  resendConfirmation(props.links.submit_path)
    .then(() => isSubmitSuccess.value = true)
}
</script>
