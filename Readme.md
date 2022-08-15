<img src="https://svgur.com/i/jYf.svg" width="200"/>

## Descritpion
A simple API proxy for managing
[Venly custodial wallets](https://docs.venly.io/api/) for the [SocialClaim](https://socialclaim.nescrypto.com) project

## Project setup
```shell
bundle install
```
## ENV variables
```shell
export VUE_APP_VENLY_API_URL="https://..."
export VUE_APP_VENLY_LOGIN_URL="https://..."
export VUE_APP_VENLY_CLIENT_ID="Testaccount-xxxxx"
export VUE_APP_SECRET_ID=""
export VUE_APP_APPLICATION_ID=""
export VUE_APP_SOCIALCLAIM_API_URL=""
```


### Easy deploy with dokku
```
// On the remote server
dokku apps:create socialclaim-api
dokku config:set socialclaim VUE_APP_VENLY_API_URL="https://...
dokku config:set socialclaim VUE_APP_VENLY_LOGIN_URL="https://..."
dokku config:set ...

```

### Run locally
```
foreman start
```
