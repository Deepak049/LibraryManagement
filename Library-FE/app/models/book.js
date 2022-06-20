import DS from 'ember-data';

export default DS.Model.extend({
    isbn: DS.attr('number'),
    title: DS.attr('string'),
    author: DS.attr('string'),
    category: DS.attr('string'),
    description: DS.attr('string'),
    quantity: DS.attr('number'),
    price: DS.attr('number'),
    fine: DS.attr('number'),
    is_active: DS.attr('boolean'),

    // has many orders
    orders: DS.hasMany('order')
});
