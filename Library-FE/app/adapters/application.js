import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';
import Ember from 'ember';
import { computed } from '@ember/object';
import DS from 'ember-data';

const { service } = Ember.inject;

export default DS.RESTAdapter.extend(DataAdapterMixin, {
  session: service('session'),
  host: 'http://localhost:3000',
  authorizer: 'authorizer:devise',
  // sending authentication token and email in headers of every request for backend authentication
  headers: computed('session.{data.authenticated.token,isAuthenticated}', function() {
    let headers = {};
    if (this.session.isAuthenticated) {
      headers['Authorization'] = `Bearer ${this.session.data.authenticated.token}, email=${this.session.data.authenticated.email}`;
    }
    return headers;
  }),
});