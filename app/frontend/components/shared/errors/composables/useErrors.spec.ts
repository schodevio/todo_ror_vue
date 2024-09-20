import { describe, expect, it } from 'vitest'
import useErrors from './useErrors'

describe('errors state', () => {
  it('is empty object by default', () => {
    const { errors } = useErrors()
    expect(errors.value).toEqual({})
  })

  it('has entries when initialData passed', () => {
    const { errors } = useErrors({ name: ['is invalid'] })

    expect(errors.value).toEqual({
      name: ['is invalid']
    })
  })
})

describe('setErrors', () => {
  it('overrides errors state with new data', () => {
    const { errors, setErrors } = useErrors()

    errors.value = { name: ["can't be blank"] }
    setErrors({ name: ['is invalid'] })

    expect(errors.value).toEqual({
      name: ['is invalid']
    })
  })
})

describe('clearErrors', () => {
  it('overrides errors state with empty object', () => {
    const { errors, clearErrors } = useErrors()

    errors.value = { name: ["can't be blank"] }
    clearErrors()

    expect(errors.value).toEqual({})
  })
})
