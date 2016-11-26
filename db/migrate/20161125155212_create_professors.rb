class CreateProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.index :email, unique: true

      t.timestamps
    end
  end
end
