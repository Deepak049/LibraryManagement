import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),
    borrowedOpen: false,
    booksOpen: true,

    actions: {
        // toggling borrowing books
        toggleBorrowed(){
            this.set('borrowedOpen', !this.borrowedOpen);
        },

        // toggling books
        toggleBooks(){
            this.set('booksOpen', !this.booksOpen);
        },

        // returning book
        returnBook(order_id){
            let self = this;
            let inSufficientAmount = false;
            let order = this.store.findRecord('order', order_id).then((order)=>{
                let today = new Date();
                let timeDiff = today - order.due_date;
                let daysDiff = Math.floor(timeDiff / (1000 * 3600 * 24));
                // calculating fine if the due date is exceeded
                if(daysDiff > 0){
                    let fine = order.belongsTo('book_id').value().fine * daysDiff
                    alert(
                    "You have crossed the due date! And the fine amount is " +
                    String(fine));

                    if(fine > this.currentUser.user.wallet){
                        inSufficientAmount = true;
                    }
                }
                // alert if the user doesn't have money for fine
                if(inSufficientAmount){
                    alert("You don't have sufficient money in your wallet to pay the fine!");
                    alert('Please contact Admin to return your book!');
                }
                else{
                    order.set('return_date', today);
                    order.save();
                    alert('Successfully returned your book!');
                }
                window.location.reload(true);
            });
        }
    }
});
