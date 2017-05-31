class Listing < ApplicationRecord
	has_attached_file :image, styles: { medium: "800x800>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	validates :name, :description, :price, presence: true
  	validates :price, numericality: { greater_than: 0 }
  	validates_attachment_presence :image

  	belongs_to :user
  	has_many :orders
  	has_many :reviews
  	belongs_to :category

  	def self.search(search)
  		where("name ILIKE ?", "%#{search}%") 
	end
end
