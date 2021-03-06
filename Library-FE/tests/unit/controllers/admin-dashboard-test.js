import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Controller | admin-dashboard', function(hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function(assert) {
    let controller = this.owner.lookup('controller:admin-dashboard');
    assert.ok(controller);
  });

  test('disable book', function(assert) {
    let controller = this.owner.lookup('controller:admin-dashboard');
    let book = {is_active: true}
    controller.actions.enableBook(book)
    assert_equal(book, true)
  });
});
