<template>
  <form @submit.prevent="handleSubmit">
    <OtpAuthStatusBadge
      :value="otpAuth.otp_required_for_login"
      class="mb-4"
    />

    <div class="grid grid-cols-2 gap-2">
      <div class="col-span-2">
        <InputField
          :errors="errors.current_password"
          label-for="otp_auth_current_password"
          label="Current Password"
          class="mb-3"
        >
          <InputText
            v-model="otpAuth.current_password"
            :invalid="!!errors.current_password"
            name="otp_auth[current_password]"
            id="otp_auth_current_password"
            class="w-full"
            type="password"
          />
        </InputField>
      </div>

      <div class="col-span-2">
        <button
          class="btn btn--danger w-full"
          type="submit"
        >
          Disable 2FA
        </button>
      </div>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'
//- Models
import { OTPAuthModel } from '@components/user_panel/otp_auth/models/otpAuth'
//- Composables
import useOTPAuth from '@components/user_panel/otp_auth/composables/useOTPAuth'
//- Components
import OtpAuthStatusBadge from '@components/user_panel/otp_auth/OtpAuthStatusBadge.vue'
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  otp_auth: {
    type: Object as PropType<OTPAuthModel>,
    required: true
  }
})

const { otpAuth, errors, disableOTPAuth } = useOTPAuth(props.otp_auth)

const handleSubmit = () => {
  disableOTPAuth(otpAuth.value.links.otp_auth_path, otpAuth.value.disableParams)
    .then(() => window.location.reload())
}
</script>
