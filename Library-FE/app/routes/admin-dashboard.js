import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(AuthenticatedRouteMixin, {
    session: service('session'),
    currentUser: service('currentUser'),
    
    // only admin can access admin dashboard
    beforeModel(){
        if(!this.currentUser.user.is_admin){
            this.transitionTo('dashboard');
        }
    },

    model(){
        // retrieves all information for admin dashboard
       let books = this.store.findAll('book');
       let orders = this.store.findAll('order');
       let users = this.store.findAll('user');
       
       return {
        "books": books,
        "users": users,
        "orders": orders
       };
    }
});
