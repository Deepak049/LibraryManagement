import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Helper | format-date', function(hooks) {
  setupRenderingTest(hooks);

  // Replace this with your real tests.
  test('it renders', async function(assert) {
    this.set('inputValue', new Date("June 25, 2022"));

    await render(hbs`{{format-date inputValue}}`);

    assert.equal(this.element.textContent.trim(), '25 Jun 2022');
  });
});
