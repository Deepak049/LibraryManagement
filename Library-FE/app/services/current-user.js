import Ember from 'ember';
import { resolve } from 'rsvp';
import { computed } from '@ember/object';

const { service } = Ember.inject;

export default Ember.Service.extend({
    session: service('session'),
    store: service('store'),
    user: null,

    // stores the current user upon successful authentication
    async fetchUser(){
        let email = this.session.data.authenticated.email;

        if(email){
            this.set('user', await this.store.queryRecord('user', {email: email}));
        }
        else{
            return resolve();
        }
    }  
});
