<center>
<img src="https://user-images.githubusercontent.com/1039236/51209809-253a8a80-1937-11e9-9dc1-0267bcb74390.png" />
</center>

<p align="center">
<a href="https://github.com/lubusIN/actions"><img src="https://img.shields.io/github/license/lubusIN/actions.svg" alt="Licence"></a>
<a href="https://github.com/lubusIN/actions"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square" alt="PRs"></a>
</p>

<center>
<a href="https://lubus.in/">
<img src="https://user-images.githubusercontent.com/1039236/40877801-3fa8ccf6-66a4-11e8-8f42-19ed4e883ce9.png" />
</a>
</center>

# WordPress

Github action to publish your WordPress plugin to wordpress.org plugin repository. Develop plugin on github and once done tag the release and sit back. WordPress action will publish the relese to wordpress.org SVN and create SVN tag based on the github release tag.

> _**Note**_:
>
>- WordPress action depends on archive action to build the distibution archive which is published to wordpress.org SVN
>
>- Keep all assets for plugin repository under `.wordpress-org`
>
>- Create numeric release tag e.g. `1.0.0` as action uses same name for SVN tag folder

## Environment Variables

- **WP_SLUG**: plugin slug on wordpress.org

## Secrets

- **WP_USERNAME**: your wordpress.org username
- **WP_PASSWORD**: yourwordpress.org password

## Example Workflow

```
# Workflow to publish plugin release to wordpress.org
workflow "Release Plugin" {
    on = "push"
    resolves = ["wordpress"]
}

# Filter for tag
    action "tag" {
    uses = "actions/bin/filter@master"
    args = "tag"
}

# Install Dependencies
    action "install" {
    uses = "actions/npm@e7aaefe"
    needs = "tag"
    args = "install"
}

# Build Plugin
action "build" {
    uses = "actions/npm@e7aaefe"
    needs = ["install"]
    args = "run build"
}

# Create Release ZIP archive
action "archive" {
    uses = "lubusIN/actions/archive"
    needs = ["build"]
    env = {
            ZIP_FILENAME = "plugin-slug"
        }
}

# Publish to wordpress.org repository
action "wordpress" {
    uses = "lubusIN/actions/wordpress"
    needs = ["archive"]
    env = {
        WP_SLUG = "plugin-slug"
    }
    secrets = [
        "WP_USERNAME", 
        "WP_PASSWORD"
    ]
}
```

## Feedback / Suggestions

If you have any suggestions/feature request that you would like to see, feel free to let us know in the [issues section](https://github.com/lubusIN/actions/issues)

## Credits

[Ajit Bohra](https://twitter.com/ajitbohra)

## Support Us

<a href="https://www.patreon.com/lubus">
<img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Become A Patron"/>
</a>

[LUBUS](http://lubus.in) is a web design agency based in Mumbai, India.

You can pledge on [patreon](https://www.patreon.com/lubus) to support the development & maintenance of various [opensource](https://github.com/lubusIN/) stuff we are building.

## License

`wordpress action` is open-sourced software licensed under the [MIT](LICENSE)