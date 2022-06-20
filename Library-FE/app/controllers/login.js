import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
    session: service('session'),
    currentUser: service('currentUser'),
    actions: {
      authenticate() {
        // login
        let { email, password } = this.getProperties('email', 'password');
        this.get('session')
          .authenticate('authenticator:devise', email, password)
          .catch(
            // shows respective error
            async (error)=>{
                let errorMessage = "Please check your email/password!"
                let promise = error.json()
                await promise.then((data)=>{errorMessage = data.errors})
                alert("Login Failed");
                this.set('errorMessage', errorMessage);
            }
          );
      },
    }
});
