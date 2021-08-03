class CreateSees < ActiveRecord::Migration[5.2]
  def change
    create_table :sees do |t|
      t.string :ip

      t.timestamps
    end
  end
end
