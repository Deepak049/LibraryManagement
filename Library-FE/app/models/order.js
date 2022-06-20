import DS from 'ember-data';

export default DS.Model.extend({
    user_id: DS.belongsTo('user'),
    book_id: DS.belongsTo('book'),
    order_date: DS.attr('date'),
    due_date: DS.attr('date'),
    return_date: DS.attr('date')
});
