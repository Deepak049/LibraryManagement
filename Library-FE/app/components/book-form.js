import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Component.extend({
  session: service('session'),
  actions: {
    submit(){
      // submitting book form
      let book = this.get('book')
      this.attrs.updateBook(book);
    }
 }
});
