import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),

    actions: {
        // updating user details
        updateUser(user){
            let self = this;
            function successMsg(){
                alert('User Updated!');
                self.transitionToRoute('adminDashboard');
            }

            function showError(error){
                alert(error.errors);
            }
            user.save().then(successMsg, showError);
        }
    }
});
