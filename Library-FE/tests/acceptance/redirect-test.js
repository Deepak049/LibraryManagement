import { module, test } from 'qunit';
import { visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';

module('Acceptance | redirect', function(hooks) {
  setupApplicationTest(hooks);

  test('visiting /redirect', async function(assert) {
    await visit('/');

    assert.equal(currentURL(), '/');

    await visit('/login');

    assert.equal(currentURL(), '/login');

    await visit('/signup');

    assert.equal(currentURL(), '/signup');

    await this.pauseTest();
  });
});
