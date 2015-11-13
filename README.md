# TeamCity Notifier

This tools hepls you keep track of your TeamCity builds via Desktop Notifications

## Requirements

This gem requires __libnotify__ to be installed on your system.

## USAGE

First you need the URL of your personal notification RSS feed. This can be found at
*https://[YOUR_TEAM_CITY_URL]/feed/generateFeedUrl.html*

To start the program than run
```
$ team_city_notifier -h HOST -u USER -p PASSWORD
```
If you want to run it in background use the `-d` option. For all options run
```
$ team_city_notifier --help
```
