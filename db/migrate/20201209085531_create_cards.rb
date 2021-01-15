class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.text          :cards  , null: false
      t.text          :hand
      t.timestamps
    end
  end
end
