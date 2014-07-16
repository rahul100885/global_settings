class CreateConfigStores < ActiveRecord::Migration
  def change
    create_table :config_stores do |t|
      t.string :key
      t.text :value
      t.string :value_type

      t.timestamps
    end
  end
end
