import Ember from 'ember';
export default Ember.Controller.extend({
  session: Ember.inject.service('session'),
  actions: {
    async save(user){
      // creating user
      let userCreated = true;
      var self = this;
      
      // login user upon successful signup
      function login(){
        self.get('session').authenticate('authenticator:devise', 
          newUser.get('email'), newUser.get('password'))
        .then(()=>{},
        (error)=>
        {
          alert("SignIn Failed!");
        })
      }

      // shows respective error message
      function showError(error){
        userCreated = false;
        alert("SignUp failed");
        self.set('errorMessage', error.errors);
      }

      let newUser = user;
      await newUser.save().catch(showError);

      if(userCreated){
        login();
      }
    }
  }
});