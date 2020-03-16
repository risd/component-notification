# @risd/component-notification

This is the global notification banner component. It wants to live at the top of your page in order to deliver a breif message to the user.

### Usage

1. `npm install @risd/component-notification`

2. Add the SCSS to your `site.scss`:

```
@import "../node_modules/@risd/component-notification/scss/index";
```

3. Copy over the notification close image from this directory into the one expected within your project. It resides at `images/icon-close.svg` of this repository, and should be moved to `static/images/notification--icon-close.svg` within your project.

4. reference the template within your swig templates:

```
{% set notification = {
    active: cms.home.notification_active,
    notification: cms.home.notification,
    background_color: cms.home.notification_background_color,
    text_color: cms.home.notification_text_color,
  }
%}

{% include 'node_modules/@risd/component-notification/template.swig' with notification only %}
```

This should render a global notification across the top of your screen.

### In use

The height of the notification is stored as a CSS variable named `'--notification-height` on the body, this can be useful for offseting content that appears on the rest of the page.

When the notification is in use the body has a class `notification--is-opened`. This is removed with closed, and there is a class `notification--is-closed` that is added to the notification.
