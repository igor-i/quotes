class CreateManualRates < ActiveRecord::Migration[5.2]
  def change
    create_table :manual_rates do |t|
      t.float :rate
      t.datetime :die_at

      t.timestamps
    end
  end
end
