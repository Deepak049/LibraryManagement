import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),
    booksOpen: true,
    usersOpen: false,
    ordersOpen: false,

    actions: {
        toggleBooks(){
            // toggle books tab
            this.set('booksOpen', true);
            this.set('usersOpen', false);
            this.set('ordersOpen', false);
        },

        toggleUsers(){
            // toggle users tab
            this.set('booksOpen', false);
            this.set('usersOpen', true);
            this.set('ordersOpen', false);
        },

        toggleOrders(){
            // toggle orders tab
            this.set('booksOpen', false);
            this.set('usersOpen', false);
            this.set('ordersOpen', true);
        },

        disableBook(book){
            // disable book
            book.destroyRecord().then(()=>{
                alert('Book is disabled!');
                window.location.reload(true);
            })
        },

        enableBook(book){
            // enable book
            book.set('is_active', true);
            book.save().then(()=>{
                alert('Book is set to active');
                window.location.reload(true);
            })
        },

        disableUser(user){
            // disable user if he/she doesn't hold books
            let holdBooks = false;
            user.orders.forEach(order => {
                if(order.return_date == null){
                    holdBooks = true;
                    return;
                }
            });

            if(!holdBooks){
                user.destroyRecord().then(()=>{
                    alert('User is disabled!')
                    window.location.reload(true);
                })
            }
            else{
                alert("User has book, so you can't disable!")
                window.location.reload(true);
            }
        },

        enableUser(user){
            // enable user
            user.set('is_active', true);
            user.save().then(()=>{
                alert('User is set to active');
                window.location.reload(true);
            })
        }
    }
});
