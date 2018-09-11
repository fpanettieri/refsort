function noop() {}

function xhr_delete(url, cb, err) {
  if (!cb) { cb = noop; }
  if (!err) { err = noop; }

  let csrf = $('meta[name="csrf-token"]').attr('content');
  let xhr = new XMLHttpRequest();

  xhr.onerror = function() { err(); }
  xhr.onload = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      cb(xhr.response);
    } else {
      err();
    }
  }

  xhr.open('DELETE', url, true);
  xhr.setRequestHeader('X-CSRF-Token', csrf);
  xhr.send(null);
}
