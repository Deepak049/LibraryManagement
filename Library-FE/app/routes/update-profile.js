import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(AuthenticatedRouteMixin, {
    currentUser: service('currentUser'),

    model(){
        // returning current user
        return this.currentUser.user
    }
});
