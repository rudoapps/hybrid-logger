## 1.1.0
* Fix logs on Flutter Web Debug didn't print the correct StackTrace
* Fix logs on Flutter Web Release with foreceLogs doesn't crashes trying to show StackTrace logs

## 1.0.5
* Fix line style logger was changed by not updated branch
* Fix max line length on Log Headers

## 1.0.4

* Fix max log length was not working on HTTP logs & Stacktrace logs

## 1.0.3

* Add documentation comments to package code
* Add max log length parameter to HybridLogger

## 1.0.2

* Change HybridLogger().error method to have optional StackTrace parameter to show with the log

## 1.0.1

* Changed console library initials

## 1.0.0

* Initial releasee:
    * Added configurable HybridLogger Object
    * Added logtypes: StackTrace logs, common logs and Http logs