import Devise from 'ember-simple-auth/authenticators/devise';

export default Devise.extend({
  // where can we token for authentication from backend
  serverTokenEndpoint: 'http://localhost:3000/signin',
});
