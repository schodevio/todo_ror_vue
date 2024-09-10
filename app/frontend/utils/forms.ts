import { serialize } from 'object-to-formdata'

export const objectToFormData = (obj: object, namespace: string, form = new FormData()) => {
  const options = {
    /**
     * include array indices in FormData keys
     * defaults to false
     */
    indices: false,

    /**
     * treat null values like undefined values and ignore them
     * defaults to false
     */
    nullsAsUndefineds: false,

    /**
     * convert true or false to 1 or 0 respectively
     * defaults to false
     */
    booleansAsIntegers: false,

    /**
     * store arrays even if they're empty
     * defaults to false
     */
    allowEmptyArrays: true,

    /**
     * don't include array notation in FormData keys for Files in arrays
     * defaults to false
     */
    noFilesWithArrayNotation: false,

    /**
     * use dots instead of brackets for object notation in FormData keys
     * defaults to false
     */
    dotsForObjectNotation: false
  }

  return serialize(obj, options, form, namespace)
}
