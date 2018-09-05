class CreateTineeUrl < ActiveRecord::Migration[5.0]
  def change
    create_table :tinee_urls do |t|
      t.string  :url
      t.string  :encoded_id
      t.timestamps
    end
  end
end
