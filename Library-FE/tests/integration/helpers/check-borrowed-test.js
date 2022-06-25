import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Helper | check-borrowed', function(hooks) {
  setupRenderingTest(hooks);

  // Replace this with your real tests.
  test('it renders', async function(assert) {
    this.set('inputValue', ["dummy-order-1", "dummy-order-2"]);

    await render(hbs`{{check-borrowed inputValue}}`);

    assert.equal(this.element.textContent.trim(), "false");
  });
});
