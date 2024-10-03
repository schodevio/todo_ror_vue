<template>
  <form @submit.prevent="handleSubmit">
    <div class="grid grid-cols-2 gap-2">
      <div class="col-span-2 lg:col-span-1">
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
      </div>

      <div class="col-span-2 lg:col-span-1">
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
      </div>

      <div class="col-span-2">
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
      </div>

      <div class="col-span-2">
        <InputField
          :errors="errors.current_password"
          label-for="user_current_password"
          hint="we need your current password to confirm these changes"
          label="Password"
          class="mb-3"
        >
          <InputText
            v-model="userAuth.current_password"
            :invalid="!!errors.current_password"
            name="user[current_password]"
            id="user_current_password"
            class="w-full"
            type="password"
          />
        </InputField>
      </div>

      <div class="col-span-2">
        <hr class="text-gray-500 my-8">
      </div>

      <div class="col-span-2 lg:col-span-1">
        <InputField
          :errors="errors.password"
          label-for="user_password"
          hint="leave blank if you don't want to change it"
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
      </div>

      <div class="col-span-2 lg:col-span-1">
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
      </div>

      <div class="col-span-2">
        <button
          class="btn btn--primary w-full"
          type="submit"
        >
          Update Profile
        </button>
      </div>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import type { TFormLinks } from '@components/user_auth/types'
import { UserAuthModel } from '@components/user_auth/models/userAuth'
//- Composables
import useUserAuth from '@components/user_auth/composables/useUserAuth'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  user: {
    type: Object as PropType<UserAuthModel>,
    required: true
  },
  links: {
    type: Object as PropType<TFormLinks>,
    required: true
  }
})

const { userAuth, errors, updateUser } = useUserAuth(props.user)

const handleSubmit = () => {
  updateUser(props.links.submit_path)
    .then(() => window.location.pathname = props.links.redirect_path)
}
</script>
