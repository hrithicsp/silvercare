/* Optional: profile photo preview */
(function() {
  var input = document.getElementById('profilePic');
  var preview = document.getElementById('profilePreview');
  if (input && preview) {
    input.addEventListener('change', function() {
      preview.innerHTML = '';
      if (this.files && this.files[0]) {
        var f = this.files[0];
        if (!f.type.match('image.(jpeg|jpg|png)')) return;
        var r = new FileReader();
        r.onload = function(e) {
          var img = document.createElement('img');
          img.src = e.target.result;
          img.style.maxWidth = '120px';
          img.style.maxHeight = '120px';
          img.style.borderRadius = '8px';
          img.style.marginTop = '8px';
          preview.appendChild(img);
        };
        r.readAsDataURL(f);
      }
    });
  }
})();
