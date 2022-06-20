import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(AuthenticatedRouteMixin, {
    session: service('session'),
    currentUser: service('currentUser'),
    
    // only admin can add book
    beforeModel(){
        if(!this.currentUser.user.is_admin){
            this.transitionTo('dashboard');
        }
    },

    model(){
        // create new instance of book
        return this.store.createRecord('book');
    }
});
