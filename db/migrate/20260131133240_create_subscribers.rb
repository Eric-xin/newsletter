class CreateSubscribers < ActiveRecord::Migration[8.1]
  def change
    create_table :subscribers do |t|
      t.string :email
      t.datetime :subscribed_at
      t.datetime :unsubscribed_at
      t.string :token

      t.timestamps
    end
    add_index :subscribers, :email, unique: true
    add_index :subscribers, :token, unique: true
  end
end
