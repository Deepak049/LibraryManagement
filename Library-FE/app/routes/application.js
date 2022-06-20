import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin'
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(ApplicationRouteMixin, AuthenticatedRouteMixin, {
    currentUser: service('currentUser'),
    session: service('session'),
    routeAfterAuthentication: 'dashboard',

    // tries to retrieve user before every request
    beforeModel() {
        return this._loadCurrentUser();
    },
    
    // stores current user upon successful authentication
    async sessionAuthenticated(){
        const _super = this._super;
        await this.currentUser.fetchUser();
        if(this.currentUser.user.is_admin){
            this.set('routeAfterAuthentication', 'adminDashboard');
        }
        _super.call(this, ...arguments);
    },
    
    // logout session if couldn't fetch current user
    _loadCurrentUser() {
        return this.currentUser.fetchUser().catch(() => this.session.invalidate());
    },
})