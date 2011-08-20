class CreateIrcs < ActiveRecord::Migration
  def self.up
    create_table :ircs do |t|
      t.string :by
      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :ircs
  end
end
