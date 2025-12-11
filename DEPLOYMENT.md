# Deployment

This fork uses [Kamal](https://kamal-deploy.org/) for deployment with 1Password CLI for secrets management.

## Prerequisites

1. **1Password CLI**: Install and authenticate with `op signin`
2. **Server**: Linux server with Docker installed and an `app` user with docker access
3. **SSH Access**: Configure SSH access in `~/.ssh/config`:

```
Host fizzy.bartasurba.com
	HostName YOUR_SERVER_IP
	User app
```

## Deploying

```bash
kamal deploy -d production
```

## 1Password Setup

Create these items in your 1Password AppSecrets vault:

- **Fizzy Rails Master Key** with field `RAILS_MASTER_KEY`
- **Fizzy ForwardEmail SMTP** with fields `SMTP_ADDRESS`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`
- **Fizzy APP_HOST** with field `username` (your domain)
- **Fizzy SMTP Reply-To** with field `username` (reply-to email)
- **Fizzy VAPID Keys** with fields `VAPID_PRIVATE_KEY`, `VAPID_PUBLIC_KEY`
- **Fizzy Email Whitelist** with field `ALLOWED_EMAIL_ADDRESSES`

Generate VAPID keys with: `bundle exec rails fizzy:vapid`

## Updating from Upstream

```bash
git fetch upstream
git rebase upstream/main
git push origin main
```
