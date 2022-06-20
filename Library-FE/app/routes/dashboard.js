import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  session: service('session'),
  currentUser: service('currentUser'),

  beforeModel(){
    // redirecting admin
    if(this.currentUser.user.is_admin){
      this.transitionTo('adminDashboard');
    }
  },

  model(){
    // retrieving user's active orders
    let orders = this.store.query('order', {user_id: this.currentUser.user.get('id'), return_date: null});
    // retrieving the remaining books
    let books = this.store.query('book', {user_id : this.currentUser.user.get('id')});
    
    return {
      "orders" : orders,
      "books" : books
    }
  }
  
});
