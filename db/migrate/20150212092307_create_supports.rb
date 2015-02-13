class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.integer :number, :default => 0
      t.references :user, index: true
      t.references :article, index: true
      t.references :comment, index: true

      t.timestamps
    end
  end
end
