# Vibe.d Template Project

Sample project template for a [Vibe.D](https://vibed.org) web app in a Docker container.

This project uses [nix](https://nixos.org/nix/) with [direnv](https://direnv.net) for development. You can instead install [dmd](https://dlang.org/download.html#dmd) and [dub](http://code.dlang.org/packages/dub) from their respective sources or [homebrew](https://brew.sh).

## Building

```sh
direnv allow  # or: nix-shell
make # or: dub
```

## Provisioning on Azure

This uses the [azure-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli). Get it with `brew install azure-cli`.

```sh
az login
az group create --name rg-vibeweb --location eastasia
az appservice plan create --name plan-vibeweb --resource-group rg-vibeweb --is-linux
az webapp create --resource-group rg-vibeweb --name vibeweb --plan plan-vibeweb --deployment-container-image-name lionello/vibeweb
```

## Deployment

It's recommended to grab Azure's webhook URL from portal.azure.com and add it to your Docker repo as a webhook. This way Azure will get notified when the container is updated.

```
make push
```
