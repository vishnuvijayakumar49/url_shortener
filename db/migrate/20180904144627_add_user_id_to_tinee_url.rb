class AddUserIdToTineeUrl < ActiveRecord::Migration[5.0]
  def change
    change_table :tinee_urls do |t|
      t.integer :user_id
    end
  end
end
