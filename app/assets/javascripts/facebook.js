// Share on Facebook
window.fbAsyncInit = function() {
    FB.init({
      appId      : 476354419169210,
      xfbml      : true,
      version    : 'v2.1'
    });
  };

(function(d, s, id) {
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/en_US/sdk.js";
   fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));

// Publish the url on facebook wall
function publishPostOnFbWall(fb_element_id, url) {
  $(fb_element_id).on('click', function() {
    FB.api(
      'me/explorizers:design',
      'post',
    )
    FB.ui(
      {
        method: 'share',
        href: url
      },
    function(response) {
      if (response && !response.error_code) {
        alert('Posting completed.');
      } else {
        alert('Error while posting.');
      }
    });
  });
}