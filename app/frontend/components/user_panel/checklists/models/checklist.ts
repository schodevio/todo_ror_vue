export class ChecklistModel {
  id: string
  name: string = ''

  thumbnail?: File

  links: {
    checklist_path: string
    export_checklist_pdf_path: string
    send_email_checklist_path: string
    thumbnail_url: string
  }

  constructor(data: Partial<ChecklistModel> = {}) {
    Object.assign(this, data)
  }

  get params() {
    return {
      name: this.name,
      thumbnail: this.thumbnail
    }
  }

  get sendEmailParams() {
    return {
      receiver_email: ''
    }
  }
}

export class ChecklistsCollection {
  models: ChecklistModel[]

  constructor(items: ChecklistModel[] = []) {
    this.models = items.map(item => new ChecklistModel(item))
  }
}
