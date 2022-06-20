class BookSerializer < ApplicationSerializer
  attributes :id, :isbn, :title, :author, :category, :description, :price, :fine, :quantity, :is_active
end
