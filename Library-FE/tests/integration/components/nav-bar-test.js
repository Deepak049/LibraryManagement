import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | nav-bar', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    this.set('title', "testing")
    await render(hbs`{{nav-bar title=title}}`);

    assert.dom("h2").hasText("testing")
    assert.dom("[data-test-actions]").hasText("Login Signup")

    this.set('session', {"isAuthenticated": true})
    this.set('user', {"wallet": 100})
    await render(hbs`{{nav-bar title=title session=session user=user}}`);
    assert.dom("[data-test-actions]").hasText("Dashboard Logout Wallet () You have 100 rupees.")

    this.set('user', {"is_admin": true, "wallet": 100})
    await render(hbs`{{nav-bar title=title session=session user=user}}`);
    assert.dom("[data-test-actions]").hasText("Dashboard Logout")
  });
});
