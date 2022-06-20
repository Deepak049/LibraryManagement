class BooksController < ApplicationController
    def show
        book = Book.find(params[:id])
        render json: book, status: 200
    end

    def index
        if(@user.is_admin)
            books = Book.all()
        else
            # filter the books the user has already borrowed
            user = User.find(params[:user_id]) if params[:user_id]
            orders = user.orders.where(return_date: nil) if user
            books = Book.where.not(orders: orders)
            books = books.order(is_active: :desc)
            books = books.order(quantity: :desc)
        end
        
        render json: books
    end

    def create
        # only admin can add book
        if(@user.is_admin)
            book = Book.new()     

            book.title = params[:book][:title]
            book.author = params[:book][:author]
            book.description = params[:book][:description]
            book.isbn = params[:book][:isbn]
            book.category = params[:book][:category]
            book.quantity = params[:book][:quantity]
            book.price = params[:book][:price]
            book.fine = params[:book][:fine]


            if book.save()
                render json: book, status: 200
            else
                render json: {:errors => book.errors.full_messages}, status: 400
            end
        else
            render json: {:errors => "Unauthorized"}, status: 400
        end
    end

    def update
        # only admin can update book
        if(@user.is_admin)
            book = Book.find(params[:id])
            
            book.title = params[:book][:title]
            book.author = params[:book][:author]
            book.description = params[:book][:description]
            book.isbn = params[:book][:isbn]
            book.category = params[:book][:category]
            book.quantity = params[:book][:quantity]
            book.price = params[:book][:price]
            book.fine = params[:book][:fine]
            book.is_active = params[:book][:is_active]


            if book.save()
                render json: book, status: 200
            else
                render json: {:errors => book.errors.full_messages}, status: 400
            end
        else
            render json: {:errors => "Unauthorized"}, status: 400
        end
    end

    def destroy
        # only admin can disable book
        if(@user.is_admin)
            book = Book.find(params[:id])
            # we use soft delete in order to track the orders
            book.is_active = false
            book.save()
            render json: book, status: 200
        else
            render json: {:errors => "Access Denied"}, status: 400
        end
    end
end
