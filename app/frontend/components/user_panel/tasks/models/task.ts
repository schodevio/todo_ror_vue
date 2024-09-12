export class TaskModel {
  id: string
  name: string = ''
  description: string
  completed: boolean = false
  position: number

  links: {
    task_path: string
  }

  constructor(data: Partial<TaskModel> = {}) {
    Object.assign(this, data)
  }

  get params() {
    return {
      name: this.name,
      description: this.description,
      completed: this.completed,
      position: this.position
    }
  }
}

export class TasksCollection {
  models: TaskModel[]

  constructor(items: TaskModel[] = []) {
    this.models = items.map(item => new TaskModel(item))
  }
}
