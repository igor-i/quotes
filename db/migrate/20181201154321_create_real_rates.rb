class CreateRealRates < ActiveRecord::Migration[5.2]
  def change
    create_table :real_rates do |t|
      t.float :rate

      t.timestamps
    end
  end
end
