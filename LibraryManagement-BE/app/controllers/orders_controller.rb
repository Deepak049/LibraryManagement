class OrdersController < ApplicationController

    def show
        if(@user.is_admin)
            render json: Order.find(params[:id])
        else
            # checking the user has requesting their order
            @user.orders.each do |order|
                if(order.id == params[:id])
                    render json: Order.find(params[:id]) and return
                end
            end
            render json: {:errors => "Unauthorized"}, status: 400 and return
        end
    end

    def index
        if(@user.is_admin)
            # only admin can get all orders
            render json: Order.all.order(id: :desc)
        else
            # filtering the orders of the user
            user = User.find(params[:user_id])
            orders = user.orders if user

            # returns the active orders based on request
            if(params[:return_date])
                orders = orders.where(return_date: nil)
            end
            render json: orders
        end
    end

    def create
        user_id = params[:order][:user_id]
        book_id = params[:order][:book_id]
        order_date = params[:order][:order_date]
        due_date = params[:order][:due_date]

        user = User.find(user_id)
        book = Book.find(book_id)

        # check if user has sufficient amount of money
        if (book.price > user.wallet)
            render json: {:errors => "Not enough Money!"}, status: 400 and return
        end

        # checking with the borrow limit
        borrowLimit = 2
        orders = Order.where(user_id: user_id, return_date: nil)
        if (orders.length() >= borrowLimit)
            render json: {:errors => "Exceeded borrowing limit!"}, status: 400 and return
        end

        # reducing the amount from user's wallet
        user.wallet -= book.price
        user.save()

        order = Order.create!(
            user_id: user_id,
            book_id: book_id,
            order_date: order_date,
            due_date: due_date
        )

        # reducing the book quantity upon order confirmation
        book.quantity -= 1
        book.save()

        render json: order, status: 201 and return
    end

    def update
        # returning book
        order = Order.find(params[:id])
        order.return_date = params[:order][:return_date]
        daysDiff = (order.return_date - order.due_date).to_i
        if(daysDiff > 0)
            fine = daysDiff * order.book.fine
            # checks the user has sufficient amount to pay the fine
            if(order.user.wallet < fine)
                render json: {:msg => "Not enough Money!"}, status: 400 and return
            end
            # reducing fine amount from user's wallet
            order.user.wallet -= fine
        end
        # updating user's wallet
        order.user.save()

        # increasing book quantity upon successful return
        order.book.quantity += 1
        order.book.save()
        order.save()

        render json: order, status: 200 and return
    end
end
