import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const { service } = Ember.inject;

export default Route.extend(AuthenticatedRouteMixin,{
    currentUser: service('currentUser'),

    async beforeModel() {
        // admin can't access user's dashboard
        if(this.currentUser.user.is_admin){
            this.transitionTo('adminDashboard');
        }

        // setting books borrowing dialog box to false initially to not pop up
        this.controllerFor('books').set('dialogBox', false)

        let self = this;
        let book_id = this.paramsFor('books').book_id;

        // checks if the user has already borrowed that book
        let orders = await this.store.query('order', {user_id: this.currentUser.user.get('id'), return_date: null})
        .then(function(orders){
            orders.forEach(order => {
            if(order.belongsTo('book_id').id() == book_id){
                alert('This book is already borrowed!');
                self.transitionTo('dashboard');
            }
            });
        });        
    },

    async model(params){
        let due = new Date();
        // default due date is 15 days after ordering date
        due.setDate(due.getDate() + 15);

        let self = this;
        let book = await this.store.findRecord('book', params.book_id).catch((error)=>{
                alert(error.errors);
                self.transitionTo('dashboard');
        })

        // checking the availability of book
        if(book.quantity < 1 || !book.is_active){
            alert('Book is not available!');
            self.transitionTo('dashboard');
        }

        return {
            "due_date" : due,
            "book" : book,
        };
    }
});
