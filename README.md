# Ansible Demo

Welcome to my Ansible demo. While there are other things that could be added - monitoring and deployment rollback to name a couple - it should give an idea how to write good Ansible code with best practices for devops to achieve a basic load balanced architectural setup.

The setup consists of:

* 2 application nodes
* 1 load balancer node
* 1 Ansible control machine

The last machine is your Vagrant host and the rest are Vagrant guest virtual machines.

Requests will come into the load balancer and be distributed to the application nodes in a round-robin fashion.

## Requirements

*N.B. This demo was written on OS X and is untested on other operating systems.*

It uses Vagrant with Virtual Box and you will also need to install Ansible on the host machine:

* **Vagrant** - please go to the [downloads page](https://www.vagrantup.com/downloads.html), download the installer, and run it on your host machine
* **Virtual Box** - you can download and install Virtual Box from [here](https://www.virtualbox.org/)
* **Ansible** (>=2.0.2) - please follow the instructions [here](http://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-pip)
* **Ruby** - I recommend [RBenv](https://github.com/rbenv/rbenv)

Also the latest psutil is broken so you'll need to downgrade to 2.2.1 by running:

```
pip uninstall psutil
pip install psutil==2.2.1
```

## Setup

Now you're ready to download and provision the demo.

If you haven't already, clone the demo Git repository.

Change into the repo directory.

If you get a warning saying that you don't have the Ruby version installed, run `rbenv install`.

Run `vagrant up`. This will provision your machines.

When provisioning has completed you should now be able to go to [http://ansible-demo-lb0.local](http://ansible-demo-lb0.local) in your web browser and see the message `Hey there, I'm served from ansible-demo-web0!`. If you refresh the page, you should see `Hey there, I'm served from ansible-demo-web1!` because the last part of the message is the host name of an app server and Nginx is server requests from the app servers in a round-robin fashion.

## Walk-Through

### Vagrantfile

The [Vagrantfile](Vagrantfile) should look pretty familiar to most people.

In this case though, using Vagrant with a multi-machine setup and Ansible, I've had to put the provisioning block inside the last machine to be defined and also set `provision.limit = 'all'`. This means that when we run `vagrant up` the machines will be started before Ansible runs and then provisioned at the same time.

The reason for doing this is so that Ansible can gather facts about all the machines in case it needs them later on, for example, in [app.yml](inf/group_vars/app.yml#L12).

### Provisioning

This demo follows Ansible's [Best Practices](http://docs.ansible.com/ansible/playbooks_best_practices.html). In this case, it means:

* Bootstrapping everything together through [site.yml](inf/site.yml)
* Including *playbooks* for groups - [all](inf/all.yml), [app](inf/app.yml), and [lb](inf/lb.yml)
* Including a playbook for [deployment](inf/deploy.yml) - we'll come back to deployment [later](#redeploying)
* Variables are [configured](inf/group_vars)
* Machines are configured with their respective roles

### Roles

All of the roles in this demo have been designed to be as reusable as Ansible will allow.

I say "allow" because, while Ansible has a lot going for it, code reuse is not one of them. For example, there's no clean way of reusing handlers.

You won't find name spacing in Ansible, the convention is to prepend anything, where collisions might be a problem, with the name of the module. I don't like to do this with tasks because the role is already listed and collisions aren't a concern.

I like to put all of the variables for roles in their defaults directories. This way they're all declared and self-documented for use in [group](inf/group_vars)/host_vars.

Role usage is also self-documenting in the demo. However, further documentation would need to be added if they were broken out to be used elsewhere. I'm planning to release these roles to [Ansible Galaxy](https://galaxy.ansible.com/) after some more features have been added.

All templates should say that they're managed by Ansible using `ansible_managed`.

#### Common

The common role is used to consolidate common tasks across machines, e.g., installing packages.

#### Deploy

Slightly more complicated example. It's inspired by Capistrano but, for the purposes of this demo, it only does deployment, i.e., no rollback and so on.

In between tasks it uses a variable include which defaults to [empty.yml](inf/roles/deploy/files/empty.yml). This allows you to hook other tasks into the deployment, e.g., [symlink_after.yml](inf/hooks/deploy/symlink_after.yml), for things like smoke testing.

#### GoLang

Installs GoLang using GoEnv, sets up environment variables, workspace, and so on.

#### Nginx

Installs Nginx, clears out the default site, enables any sites you've defined, and runs a configuration check.

There's no easy way of testing Nginx configuration before everything is in place. With a lot of the Nginx roles I've seen if configuration check fails first time around, it passes the second time, that's why this one checks during template parsing and on every run.

You should also note the [site.conf.j2](inf/roles/nginx/templates/site.conf.j2) template as this is the best example of how to format Ansible templates so that both the template and rendered file are properly formatted and readable, something that's usually overlooked.

#### Secure

Hardens machines by setting up a few basics:

* SSHD
    * Limits address family to either IPv4 or v6 unless you need both
    * Can disable root login
    * Can disable password authentication, use keys instead
* Removes any services that aren't being used
* iptables firewall to protect against common attacks and restrict access to machines, comes with some sensible defaults
    * Drop fragmented packets
    * Drop null packets
    * Drop new non-syn packets
    * Drop Xmas packets
    * Accept connections to avahi daemon
    * Accept HTTP
    * Accept HTTPS
    * Accept ping
    * Accept established connections
    * Custom rules
    * Logging

Configuration is easy to check in this case with the `validate` argument before a template is copied into place.

#### Upstart

Creates basic Upstart configuration, e.g., for running app services.

## (Re)deploying

The app is deployed when you first provision the machines.

In this demo we use hooks to:

1. Test the app
2. Stop the app service
3. Compile it
4. Start the service
5. Run smoke tests.

If you want to make changes to the code in [app.go](/app.go) and redeploy, you can; just remember to update [app_test.go](/app_test.go) as well because this gets run pre-deployment.

To provision and deploy run `vagrant provision`. To deploy only `VAGRANT_PROVISION_TAGS='deploy' vagrant provision`.

## Testing

My favourite tool, although relatively new, is [Infrataster](http://infrataster.net/). Which uses RSpec to test infrastructure using BDD.

These tests can be found in the [spec](spec/) directory. They get run, as smoke tests, post deployment but you can also run them independently using `bin/rspec`.

Unfortunately just before releasing this demo the [firewall plugin](https://github.com/otahi/infrataster-plugin-firewall) stopped working - I'm currently working with the developer to try and fix it. In the meantime I've left some commented out [examples](spec/inf/ansible-demo-lb0_spec.rb).
