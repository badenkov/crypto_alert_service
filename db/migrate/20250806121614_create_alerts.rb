class CreateAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :alerts do |t|
      t.string :symbol
      t.decimal :threshold, precision: 15, scale: 10
      t.integer :direction

      t.timestamps
    end
  end
end
