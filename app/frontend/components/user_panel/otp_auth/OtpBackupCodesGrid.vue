<template>
  <div class="grid grid-cols-4 gap-2">
      <div class="col-span-4">
        <p class="mb-4">
          Two Factor Authentication is ON now! <br />
          Keep the following backup codes safe in case you lose access to your authenticator app:</p>
      </div>

      <div
        v-for="backupCode in props.otpBackupCodes"
        :key="backupCode"
        class="col-span-1"
      >
        {{ backupCode }}
      </div>
    </div>
</template>

<script lang="ts" setup>
//- Libs
import { PropType } from 'vue'

const props = defineProps({
  otpBackupCodes: {
    type: Array as PropType<string[]>,
    default: (): string[] => []
  }
})
</script>
