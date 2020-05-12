{#

Expects an object with shape:

{
  active: true | false,
  notification: WYSIWYG content,
  background_color: hex color``?
  text_color: hex color``?
}

Displays a banner at the top of the page.

#}

{% if active && notification %}
  {# Notification #}
  {% set notificationClass = 'notification' %}

  {% if background_color %}
    {# use the background color #}
  {% else %}
    {% set background_color = '#0078ff' %}
  {% endif %}

  {% if text_color %}
    {# use the text color defined #}
  {% else %}
    {% set text_color = '#fff' %}
  {% endif %}

  <style>
    .{{ notificationClass  }} {
      background-color: {{ background_color }};
      color: {{ text_color }};
    }
    .{{ notificationClass  }} p {
      color: {{ text_color }}; 
    }
    .{{ notificationClass  }} a {
      color: {{ text_color }}; 
      border-bottom: 1px dotted {{ text_color }};
    }
  </style>

  <div class="{{ notificationClass }}" data-swiftype-index="false">

    {# The current notification, to be compared with the last one
       that was loaded, to see if we should repsect it previously
       being closed. #}
    <div class="notification__current" style="display: none">{{background_color}}{{text_color}}{{notification|safe}}</div>

    <script>
      {# Get current notification #}
      var currentNotification = document.querySelector('.notification__current').innerHTML;
      {# Capture stored notification. The notification is only stored if
         it has been previously closed. #}
      var storedNotification = window.localStorage.getItem('globalNotification');

      if (currentNotification === storedNotification) {
        document
          .querySelector('.notification')
          .classList
            .add("notification--is-closed");
      }
      else {
        document.body.classList.add('notification--is-opened');
      }
    </script>
    <span>
      {{ notification|safe }}
    </span>
    <button type="button" name="close" class="notification__closer" onclick="closeNotification();"></button>
  </div>

  <script>
    var closer = document.querySelector( '.notification__closer' );
    closer.addEventListener( 'click', closeNotification )

    var notificationEl = document.querySelector( '.notification' );

    setHeightVariable();

    function setHeightVariable () {
      var notificationBBox = notificationEl.getBoundingClientRect();
      document.body.style.setProperty( '--notification-height', `${ notificationBBox.height }px` );
    }
    
    window.addEventListener( 'resize', function onResize () {
      setHeightVariable();
    } );

    function closeNotification () {
      document.body.classList.remove('notification--is-opened');
      window.localStorage.setItem('globalNotification', currentNotification);
      document.querySelector('.notification').classList.add("notification--is-closed");
      document.body.style.setProperty( '--notification-height', '0px' );
    }
  </script>
{% else %}
<script>
  document.body.style.setProperty( '--notification-height', '0px' );
</script>
{% endif %}
