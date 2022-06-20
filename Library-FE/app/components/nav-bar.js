import Component from '@ember/component';

export default Component.extend({
    actions: {
        logout() {
          this.get('session').invalidate();
        }
    },
});
