class AddPictureToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :picture, :string
  end
end
