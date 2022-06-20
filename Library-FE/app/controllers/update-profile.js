import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),

    actions:{
        // profile update
        updateProfile(user){
            function successMsg(){
                alert('Profile Updated!');
                window.location.reload(true);
            }

            function showError(error){
                alert(error.errors);
            }
            user.save().then(successMsg, showError);
        },
    
        // password change action
        changePassword(user){
            function successMsg(){
                alert('Password Updated!');
                window.location.reload(true);
            }

            function showError(error){
                alert(error.errors);
            }
            user.save().then(successMsg, showError);
        }
    }
});
