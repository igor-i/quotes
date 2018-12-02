class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :currency_pair
      t.string :state
      t.references :current_rate, polymorphic: true, index: true
      t.belongs_to :real_rate, index: true, foreign_key: true
      t.belongs_to :manual_rate, index: true, foreign_key: true
      t.timestamps
    end
  end
end
