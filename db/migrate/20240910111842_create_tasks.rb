class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks, id: false do |t|
      ## ULID
      t.binary :id, limit: 16, primary_key: true

      t.references :checklist, null: false, foreign_key: true, type: :binary
      t.string :name, null: false
      t.text :description
      t.integer :position, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :tasks, %i[checklist_id position], unique: true
  end
end
