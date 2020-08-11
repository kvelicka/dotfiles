// Firefox user config file
// Typically placed in ~/.mozilla/firefox/$USER_PROFILE/user.js

// disable updating addon state from the Sync server - useful if you want to
// disable something _only_ on this machine
user_pref("services.sync.addons.ignoreUserEnabledChanges", true);

// disable "Pocket" extension
user_pref("extensions.pocket.enabled", false);

// double click only selects the word from an URL, not the whole thing
user_pref("browser.urlbar.doubleClickSelectsAll", false);

// don't warn about accessing about:config
user_pref("browser.aboutConfig.showWarning", false);

// do look at chrome/userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
