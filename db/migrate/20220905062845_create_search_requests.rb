class CreateSearchRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :search_requests do |t|
      t.string :keyword
      t.integer :count, default: 0
      t.integer :page

      t.timestamps
    end
  end
end
