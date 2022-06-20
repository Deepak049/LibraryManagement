import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),

    actions: {
        // adding new user
        createUser(user){
            let self = this;
            function successMsg(){
                alert('User Created!');
                self.transitionToRoute('adminDashboard');
            }

            function showError(error){
                alert(error.errors);
            }
            user.save().then(successMsg, showError);
        }
    }
});