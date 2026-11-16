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

async function updateToggle(toggle) {
  const value = toggle.dataset.value === 'true';
  // eslint-disable-next-line no-alert
  if (shouldConfirm(toggle, value) && !confirm(toggle.dataset.confirm_message)) return;

  const response = await fetch(toggle.dataset.url, {
    method: 'PATCH',
    headers: { 'Accept': 'application/json', 'X-CSRF-Token': csrfToken() },
    body: requestBody(toggle, value),
  }).catch(() => null);
  if (!response || !response.ok) {
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
