import { describe, expect, it } from 'vitest'
import useLoading from './useLoading'

describe('loading state', () => {
  it('is false by default', () => {
    const { loading } = useLoading()
    expect(loading.value).toBe(false)
  })

  it('is true when initialData passed', () => {
    const { loading } = useLoading(true)
    expect(loading.value).toBe(true)
  })
})

describe('startLoading', () => {
  it('changes loading state to true', () => {
    const { loading, startLoading } = useLoading()

    loading.value = false
    startLoading()

    expect(loading.value).toBe(true)
  })
})

describe('stopLoading', () => {
  it('changes loading state to false', () => {
    const { loading, stopLoading } = useLoading()

    loading.value = true
    stopLoading()

    expect(loading.value).toBe(false)
  })
})
