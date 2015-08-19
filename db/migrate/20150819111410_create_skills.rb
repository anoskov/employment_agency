class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :title, null: false
    end

    add_index :skills, :title, unique: true
  end
end
