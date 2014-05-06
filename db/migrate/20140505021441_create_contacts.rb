class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.text :message
      t.integer :client_id

      t.timestamps
    end
  end
end
