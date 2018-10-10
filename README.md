# Vibe.d Template Project

## Building

This project uses direnv + nix for development. You can optionally install dmd and dub from their respective sources.

```sh
direnv allow  # or: nix-shell
make push
```

## Deployment

```sh
az login
az group create --name rg-vibeweb --location eastasia
az appservice plan create --name plan-vibeweb --resource-group rg-vibeweb --is-linux
az webapp create --resource-group rg-vibeweb --name vibeweb --plan plan-vibeweb --deployment-container-image-name lionello/vibeweb
```
