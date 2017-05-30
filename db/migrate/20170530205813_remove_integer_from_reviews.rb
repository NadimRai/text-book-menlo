class RemoveIntegerFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :integer, :string
  end
end
