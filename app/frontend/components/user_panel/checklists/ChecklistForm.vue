<template>
  <form @submit.prevent="$emit('submit:form', formData)">
    <InputField
      :errors="errors.name"
      label-for="checklist_name"
      label="Name"
      class="mb-3"
    >
      <InputText
        v-model="formData.name"
        :invalid="!!errors.name"
        name="checklist[name]"
        id="checklist_name"
        class="w-full"
        type="text"
      />
    </InputField>

    <div class="form__actions">
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
        Save Checklist
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

defineOptions({
  name: 'ChecklistForm'
})

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


const formData = reactive<ChecklistModel['params']>({
  ...props.checklist.params
})
</script>
