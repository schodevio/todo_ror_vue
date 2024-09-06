export class ChecklistModel {
  id: string
  name: string = ''

  links: {
    checklist_path: string
    thumbnail_url: string
  }

  constructor(data: Partial<ChecklistModel> = {}) {
    Object.assign(this, data)
  }

  get params() {
    return {
      name: this.name
    }
  }
}

export class ChecklistsList {
  models: ChecklistModel[]

  constructor(items: ChecklistModel[] = []) {
    this.models = items.map(item => new ChecklistModel(item))
  }
}
