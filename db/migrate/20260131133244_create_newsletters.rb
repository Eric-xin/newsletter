class CreateNewsletters < ActiveRecord::Migration[8.1]
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.text :body
      t.boolean :is_public
      t.datetime :sent_at
      t.string :status

      t.timestamps
    end
  end
end
