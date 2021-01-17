class CreateUfRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :uf_records do |t|
      t.string :client
      t.date :resquest_date
      t.float :uf_value

      t.timestamps
    end
  end
end
