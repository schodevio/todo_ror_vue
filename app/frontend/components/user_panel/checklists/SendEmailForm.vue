<template>
  <form @submit.prevent="emit('submit:form', formData)">
    <InputField
      :errors="errors.receiver_email"
      label-for="checklist_receiver_email"
      label="Receiver E-mail"
      class="mb-3"
    >
      <InputText
        v-model="formData.receiver_email"
        :invalid="!!errors.receiver_email"
        name="checklist[receiver_email]"
        id="checklist_receiver_email"
        class="w-full"
        type="text"
      />
    </InputField>

    <div class="dialog__actions">
      <button
        @click="$emit('cancel:form')"
        type="button"
        class="btn"
      >
        Cancel
      </button>

      <button
        type="submit"
        class="btn btn--primary"
      >
        Save Checklist via E-mail
      </button>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, reactive } from 'vue'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TErrors } from '@components/shared/errors/types'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import InputText from 'primevue/inputtext'

const props = defineProps({
  checklist: {
    type: ChecklistModel as PropType<ChecklistModel>,
    default: (): ChecklistModel => new ChecklistModel()
  },
  errors: {
    type: Object as PropType<TErrors>,
    default: (): TErrors => ({})
  }
})

const emit = defineEmits<{
  (e: 'submit:form', value: typeof formData): void,
  (e: 'cancel:form'): void
}>()

//- Form data
const formData = reactive<ChecklistModel['sendEmailParams']>({
  ...props.checklist.sendEmailParams
})
</script>
