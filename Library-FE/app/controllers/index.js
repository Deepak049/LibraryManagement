import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),

    actions: {
        // log out functionality
        logout() {
          this.get('session').invalidate();
        }
    },
});