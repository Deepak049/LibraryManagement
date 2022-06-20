import Controller from '@ember/controller';
import Ember from 'ember';

const { service } = Ember.inject;

export default Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),
    dialogBox: false,

    actions: {
        borrowBook(){
            this.set('dialogBox', false);

            // creating order for borrowing book
            let order = this.store.createRecord('order',{
                user_id: this.currentUser.user,
                book_id: this.model.book,
                order_date: new Date(),
                due_date: this.model.due_date
            });

            let self = this;

            function transitionToDashboard(){
                self.currentUser.fetchUser();
                alert("Success! Book is borrowed!");
                self.transitionToRoute('dashboard');
            }

            function failure(error){
                console.log(error.errors)
                alert(error.errors);
                window.location.reload(true);
            }
            order.save().then(transitionToDashboard).catch(failure);
        },

        // show/hide confirmation dialog box
        showDialog(){
            this.set('dialogBox', true);
        },

        hideDialog(){
            this.set('dialogBox', false);
        }
    }
});
