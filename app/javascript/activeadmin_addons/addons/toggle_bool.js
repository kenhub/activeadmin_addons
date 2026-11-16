function csrfToken() {
  const meta = document.querySelector('meta[name="csrf-token"]');

  return meta && meta.content;
}

// confirm_message_trigger: 'on' asks when switching on, 'off' when switching off
function shouldConfirm(toggle, value) {
  if (!toggle.dataset.confirm_message) return false;

  const trigger = toggle.dataset.confirm_message_trigger || 'both';

  return trigger === 'both' || trigger === (value ? 'off' : 'on');
}

function requestBody(toggle, value) {
  const { model, field } = toggle.dataset;
  const body = new URLSearchParams();
  body.append('id', toggle.dataset.object_id);
  body.append(`${model}[${field}]`, String(!value));

  return body;
}

// a redirect (e.g. to a login page) or a non-JSON body means nothing was saved
const NO_CONTENT = 204;

async function saved(response) {
  if (!response || !response.ok) return false;
  if (response.status === NO_CONTENT) return true;

  return response.json().then(() => true, () => false);
}

async function updateToggle(toggle) {
  const value = toggle.dataset.value === 'true';
  // eslint-disable-next-line no-alert
  if (shouldConfirm(toggle, value) && !confirm(toggle.dataset.confirm_message)) return;

  const response = await fetch(toggle.dataset.url, {
    method: 'PATCH',
    // X-Requested-With as jQuery sent it, for request.xhr? checks
    headers: {
      'Accept': 'application/json',
      'X-CSRF-Token': csrfToken(),
      'X-Requested-With': 'XMLHttpRequest',
    },
    body: requestBody(toggle, value),
    redirect: 'error',
  }).catch(() => null);
  if (!(await saved(response))) {
    // eslint-disable-next-line no-alert
    alert('Error: Update Unsuccessful');

    return;
  }

  toggle.dataset.value = String(!value);
  toggle.classList.toggle('on');
  if (toggle.classList.contains('notify-success')) {
    // eslint-disable-next-line no-alert
    alert(toggle.dataset.success_message);
  }
}

// one delegated listener also covers switches rendered after Turbo visits
document.addEventListener('click', (event) => {
  const toggle = event.target.closest('.toggle-bool-switch');
  if (toggle) updateToggle(toggle);
});
