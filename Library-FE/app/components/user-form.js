import Component from '@ember/component';

export default Ember.Component.extend({

    actions: {
      // submitting user form
      submit(){
        let user = this.get('user')
        this.attrs.updateUser(user);
      }
   }
  });
