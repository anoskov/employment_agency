class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :contact_info, null: false
      t.string :job_status, null: false
      t.integer :desired_salary, null: false

      t.timestamps null: false
    end
  end
end
