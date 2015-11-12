# TeamCity Notifier

This tools hepls you keep track of your TeamCity builds via Desktopnotifications

## Requirements

This gem requires *libnotify* to be installed on your system.

## USAGE

First you need the URL of your personal notification RSS feed. This can be found at 
*https://[YOUR_TEAM_CITY_URL]/feed/generateFeedUrl.html*

Settings are made via Environment Variables, so to start the daemon run

```
$ TEAM_CITY_URL=[MY_TEAMCITY_URL  TEAM_CITY_USER=USERNAME TEAM_CITY_PASS=PASSWORD team_city_notifier start
```

To stop the daemon run

```
$ team_city_notifier stop
```

