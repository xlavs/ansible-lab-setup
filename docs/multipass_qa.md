# Multipass Questions and Answers

- Multipass is a VM provisioning tool created by Canonical https://documentation.ubuntu.com/multipass/en/latest/

- Multipass is supported on Windows, Linux, and MacOS

- Installation requires `multipass` executable to be found in the system `PATH` environment

- The power of `multipass` hides in the support of [cloud-init templates](https://cloudinit.readthedocs.io/en/latest/reference/examples.html)

## Common commands

### Launch an instance (by default

you get the current Ubuntu LTS):

```
multipass launch --name foo
```

- Run commands in that instance, try running bash (logout or ctrl-d to quit):

```
multipass exec foo -- lsb_release -a
```

- See your instances:

```
multipass list
```

- Stop and start instances:

```
multipass stop foo bar
```

```
multipass start foo
```

- Clean up what you don't need:

```
multipass delete bar
multipass purge
```

- Find alternate images to launch:

```
multipass find
```

- Pass a cloud-init metadata file to an instance on launch. (See Using cloud-init with Multipass for more details):

```
multipass launch -n bar --cloud-init cloud-config.yaml
```

- Get help:

```
multipass help
```

```
multipass help <command>
```