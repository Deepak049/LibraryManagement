require "test_helper"

class BookTest < ActiveSupport::TestCase
    setup do
        @book = books(:one)
    end

    test "should create book with isbn, title and author" do
        book = Book.new(isbn: 1234, title: "Testing", author: "Author")
        assert(book.save, "book is not saved")
    end

    test "should not create book without isbn, title and author" do
        book = Book.new()
        assert_not(book.save, "Book is saved without isbn, title and author")
    end


    test "should create book with quantity 1" do
        book = Book.new(isbn: 1234, title: "Testing", author: "Author")
        book.save
        assert_equal(book.quantity, 1)
    end

    test "isbn should be unique" do
        book_one = Book.new(isbn: 1234, title: "Testing", author: "Author")
        book_one.save
        book_two = Book.new(isbn: 1234, title: "Testing book", author: "Author 1")
        assert_not(book_two.save, "Book is saved with same isbn")
    end
end