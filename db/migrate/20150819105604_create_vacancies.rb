class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :title, null: false
      t.date :expiration_date, null: false
      t.int4range :salary, null: false
      t.text :contact_info, null: false

      t.timestamps null: false
    end
  end
end
