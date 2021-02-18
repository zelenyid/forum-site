class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false, default: ''
      t.text :description, default: ''

      t.timestamps
    end
  end
end
