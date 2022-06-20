import DS from 'ember-data';

export default DS.Model.extend({
    first_name: DS.attr('string'),
    last_name: DS.attr('string'),
    address: DS.attr('string'),
    email: DS.attr('string'),
    old_password: DS.attr('string'),
    password: DS.attr('string'),
    password_confirmation: DS.attr('string'),
    wallet: DS.attr('number'),
    is_admin: DS.attr('boolean'),
    is_active: DS.attr('boolean'),

    // has many orders
    orders: DS.hasMany('order')
});
