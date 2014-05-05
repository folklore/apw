class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.string :name,  null: false, unique: true
      t.string :title, null: false
      t.text :text,    null: false
      t.integer :p_id

      t.timestamps
    end

    add_index :sheets, :p_id
  end
end
