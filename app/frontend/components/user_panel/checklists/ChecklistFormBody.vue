<template>
  <form @submit.prevent="emit('submit:form', formData)">
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

    <InputField
      :errors="errors.thumbnail"
      label-for="checklist_thumbnail"
      label="Thumbnail"
      class="mb-3"
    >
      <FileUpload
        @select="handleFileSelect"
        :show-upload-button="false"
        :max-file-size="5242880"
        name="checklist[thumbnail]"
        accept="image/*"
        mode="basic"
      />

      <img
        v-if="fileUrl || checklist.links?.thumbnail_url"
        :src="fileUrl || checklist.links?.thumbnail_url"
        class="w-full max-w-80 rounded-lg mx-auto my-4"
      >
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
        Save Checklist
      </button>
    </div>
  </form>
</template>

<script lang="ts" setup>
//- Libs
import { PropType, reactive, shallowRef } from 'vue'
import { useObjectUrl } from '@vueuse/core'
//- Models
import { ChecklistModel } from '@components/user_panel/checklists/models/checklist'
import type { TErrors } from '@components/shared/errors/types'
//- Components
import InputField from '@components/shared/fields/InputField.vue'
import FileUpload, { FileUploadSelectEvent } from 'primevue/fileupload'
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
const file = shallowRef()
const fileUrl = useObjectUrl(file)

const formData = reactive<ChecklistModel['params']>({
  ...props.checklist.params
})

const handleFileSelect = (event: FileUploadSelectEvent) => {
  formData.thumbnail = file.value = event.files[0]
}
</script>
