import Component from '@ember/component';

export default Component.extend({
    dialogBox: false,
    
    actions: {
        // submitting form
        submit(){
            let user = this.get('user');
            this.attrs.updateProfile(user);
        },

        // password submission
        submitPassword(){
            let user = this.get('user');
            this.attrs.changePassword(user);
        },

        // show/hide change password dialog box
        showDialog(){
            this.set('dialogBox', true);
        },

        hideDialog(){
            this.set('dialogBox', false);
        }
    }
});
