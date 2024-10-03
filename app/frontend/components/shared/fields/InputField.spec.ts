import { describe, expect, it } from 'vitest'
import { mount } from '@vue/test-utils'

import InputField from './InputField.vue'

describe('InputField label', () => {
  it('is visible when present in props', () => {
    const wrapper = mount(InputField, {
      props: {
        labelFor: 'name',
        label: 'Name'
      }
    })

    const label = wrapper.find('.input-field__label')
    expect(label.text()).toContain('Name')
  })

  it('is null when label prop undefined', () => {
    const wrapper = mount(InputField, {
      props: {
        labelFor: 'name',
      }
    })

    const label = wrapper.find('.input-field__label')
    expect(label.exists()).toBe(false)
  })
})

describe('InputField errors', () => {
  it('is visible when at least 1 error present in props', () => {
    const wrapper = mount(InputField, {
      props: {
        errors: ['is invalid'] as string[],
        labelFor: 'name'
      }
    })

    const errorDiv = wrapper.find('.input-field__error')
    expect(errorDiv.text()).toContain('is invalid')
  })

  it('shows only 1 error when multiple errors present in props', () => {
    const wrapper = mount(InputField, {
      props: {
        errors: ['is invalid', 'is too short'] as string[],
        labelFor: 'name'
      }
    })

    const errorDiv = wrapper.find('.input-field__error')
    expect(errorDiv.text()).toContain('is invalid')
  })

  it('is null when errors prop empty', () => {
    const wrapper = mount(InputField, {
      props: {
        errors: [] as string[],
        labelFor: 'name',
      }
    })

    const label = wrapper.find('.input-field__error')
    expect(label.exists()).toBe(false)
  })
})

describe('InputField hint', () => {
  it('is visible when present in props', () => {
    const wrapper = mount(InputField, {
      props: {
        hint: 'sample text',
        labelFor: 'name'
      }
    })

    const label = wrapper.find('.input-field__hint')
    expect(label.text()).toContain('Hint: sample text')
  })

  it('is null when label prop undefined', () => {
    const wrapper = mount(InputField, {
      props: {
        labelFor: 'name'
      }
    })

    const label = wrapper.find('.input-field__hint')
    expect(label.exists()).toBe(false)
  })
})
