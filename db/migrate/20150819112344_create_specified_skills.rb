class CreateSpecifiedSkills < ActiveRecord::Migration
  def change
    create_table :specified_skills do |t|
      t.integer :owner_id, null: false
      t.string :owner_type, null: false
      t.references :skill, index: true, foreign_key: true, null: false
    end

    add_index :specified_skills, [:owner_id, :owner_type]
  end
end
