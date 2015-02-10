class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.integer :support, :default => 0
      

      t.references :article, index: true

      t.timestamps null: false
    end
  end
end
