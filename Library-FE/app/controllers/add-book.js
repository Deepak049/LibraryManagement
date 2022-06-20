import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),


    actions: {
        // adding new book
        addBook(book){
            let self = this;
            function successMsg(){
                alert('Book Created!');
                self.transitionToRoute('adminDashboard');
            }

            function showError(error){
                alert(error.errors);
            }
            book.save().then(successMsg, showError);
        }
    }
});