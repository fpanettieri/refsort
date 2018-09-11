function noop() {}

function xhr_delete(url, cb, err) {
  if (!cb) { cb = noop; }
  if (!err) { err = noop; }

  let xhr = new XMLHttpRequest();
  xhr.open('DELETE', url, true);

  let csrf = $('meta[name="csrf-token"]').attr('content');
  xhr.setRequestHeader('X-CSRF-Token', csrf);

  xhr.onerror = () => { err(); }
  xhr.onload = () => {
    if (xhr.readyState === 4 && xhr.status === 200) {
      cb(xhr.response);
    } else {
      err();
    }
  }

  xhr.send();
}
