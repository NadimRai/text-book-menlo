class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :rating
      t.string :integer
      t.text :comment

      t.timestamps
    end
  end
end
