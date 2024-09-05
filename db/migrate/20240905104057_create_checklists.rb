class CreateChecklists < ActiveRecord::Migration[7.1]
  def change
    create_table :checklists, id: false do |t|
      ## ULID
      t.binary :id, limit: 16, primary_key: true

      t.references :user, null: false, foreign_key: true, type: :binary
      t.string :name, null: false

      t.timestamps
    end
  end
end
