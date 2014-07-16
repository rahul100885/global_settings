##GlobalSettings##

This is simple rails application with single model which is responsible for storing and fetching key-value pair

### Steps to use
Set database yml and create and migrate db.

### How to use
Store value (Note: only support string, integer, float and boolean value)

```console
> ConfigStore['email'] = "rahul@example.com"
```
Fetch value
```console
> ConfigStore[:email]
=> "rahul@example.com"

> ConfigStore["not_set"]
=> nil
```
### Testing
```console
rake test
```
