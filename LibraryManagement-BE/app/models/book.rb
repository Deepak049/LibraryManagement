class Book < ApplicationRecord
    validates :isbn, :title, :author, presence: true
    validates :isbn, uniqueness: true    

    has_many :orders
end