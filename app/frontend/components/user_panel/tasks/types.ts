export type TTasksLinks = {
  tasks_path: string
}

export type TPositionChangeEvent<T> = {
  moved: {
    element: T,
    newIndex: number,
    oldIndex: number
  }
}
