class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest

      t.index :email, unique: true

      t.timestamps
    end
  end
end
