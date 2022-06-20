import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('signup');
  this.route('login');
  this.route('dashboard');
  this.route('books', {path: 'dashboard/book/:book_id'});
  this.route('updateProfile', {path: 'profile/'});
  this.route('adminDashboard');
  this.route('edit-book', {path: 'editBook/:book_id'});
  this.route('addBook');
  this.route('editUser', {path: 'editUser/:user_id'});
  this.route('addUser');
  this.route('404-not-found', {path: '/*path'});
});

export default Router;
