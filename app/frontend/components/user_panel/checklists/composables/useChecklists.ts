//- Libs
import { reactive, toRefs } from 'vue'
//- Models
import { ChecklistModel, ChecklistsList } from '@components/user_panel/checklists/models/checklist'
//- Utils
import useHTTP from '@utils/useHTTP'

export default (initialData?: ChecklistModel[]) => {
  const state = reactive({
    checklists: new ChecklistsList(initialData)
  })

  const setChecklists = (items: ChecklistModel[]) => {
    state.checklists = new ChecklistsList(items)
  }

  const fetchChecklists = (path: string) => {
    useHTTP(path, { method: 'GET' })
      .then(response => setChecklists(response.data.value.checklists))
  }

  return {
    ...toRefs(state),

    setChecklists,
    fetchChecklists
  }
}
