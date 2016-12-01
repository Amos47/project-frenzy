class AddUsersToProject < ActiveRecord::Migration[5.0]
  def up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.time :publish_at
      t.belongs_to :student, index: { unique: true }, foreign_key: true
      t.belongs_to :professor, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
