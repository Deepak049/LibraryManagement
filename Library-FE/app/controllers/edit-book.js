import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),


    actions: {
        updateBook(book){
            // updating book details
            let self = this;
            function successMsg(){
                alert('Book Updated!');
                self.transitionToRoute('adminDashboard');
            }

            function showError(error){
                alert(error.errors);
            }
            book.save().then(successMsg, showError);
        }
    }
});
