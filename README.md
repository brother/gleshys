# The GleShYS cloud.

Welcome to the new^wold world.

# tldr; aka Quick Start

Set your PATH to include the `bin` directory of this repo as the first
instance.

> brother ~$ grep brother.*PATH .bashrc

> export PATH="/home/brother/git/other/gleshys/bin:$PATH"

And then execute `gleshys start` to login. If you do not provide any
flags the login will prompt you to pick an organization and project.

You can logout by executing `gleshys session-destroy`, this will also
wipe on disk information about username, api access key, active
organization and active project. If you do not worry about logging out
the GleSYS API still has a timeout that will invalidate your access
key.

## Persistent environment

The GleShYS settings file is found by validating in this particular
order.

1. A file provided on the command line
2. environment variable GLESHYSSETTINGS
3. ~/.config/gleshys.cfg
4. A temporary file created at login time in TMPDIR (eg. /tmp). A
   successful login will keep the apikey stored in this file. Use
   `gleshys-session-destroy` to invalidate the key and remove the
   settings file.

TODO / NOTE: Number 4 was working at some point but doesn't
currently. Use one of the others.

To avoid having to login, an API key can be obtained via the web
interface at https://cloud.glesys.com. This key has no timeout and as
long as the config file is provided (or you use the standard file) the
commands will just continue to work. Uee with care.  `gleshys
session-destroy` will wipe all these settings regardless of what login
mechanism was used.

# What's up?

As a first bare minimum goal I want to have a bunch of binaries that
can be installed in your PATH and give you easy access to command line
tools for interacting with the API and the services behind it.

For this to work there are a couple of important must haves with
login, configuration persistence and the likes.

As a related challenge I want the dependency list to be small.

* bash
  It uses bash specifics and will not be portable to other shell
  types. I will use shellcheck and honour readability before cool
  shell syntax.

* curl
  The GleSYS API is accessible via HTTPs. Curl is a widely used
  application to interact with such services.

* jq
  The GleSYS API can be accessed from your application in numerous
  ways. I've opted for json and will use jq extensivly. Parsing XML
  would have meant something like XML Starlet. Choose your poison.

* coreutils
  Some commands provided by coreutils are in use. Should pretty much
  never pose a problem on a system having bash already.

## Current status

See also the TODO section below and the script
`bin/gleshys-project-status`.

* [ ] api
  * [ ] maintenance
  * [ ] serviceinfo
  * [ ] listfunctions
* [x] archive
  * covered by `bin/gleshys-archive`
  * [ ] cloak passwords, they are managed via -p command line flag and
        thus public for the machine.
* [ ] customer
  * [!] customer/listprojects
* [ ] domain
* [ ] email
* [x] filestorage
  * covered by `bin/gleshys-file-storage`
  * [ ] Need to settle the output. Possibly add an interactive mode.
* [ ] invoice
  * [ ] list
* [x] ip
  * covered by `bin/gleshys-ip`
* [ ] loadbalancer
* [x] network
  * covered by `bin/gleshys-network`
* [ ] networkadapter
* [x] objectstorage
  * covered by `bin/gleshys-object-storage`
  [ ] initial bucket need to be addressed, it's not returned as
      response to creteinstance statement.
* [ ] project
  * [ ] delete
  * [ ] rename
* [ ] server
  * [x] server/list
  * [x] server/templates
  * [x] server/create
   * TODO. -u for kvm is not implemented, provide a correctly
     formatted JSON string - or use the interactive mode by not using
     the -u switch at all.
  * [x] server/destroy
  * [!] server/allowedarguments
  * [x] server/backup
   * Revisit this when server/edit is done/can handle backups for KVM.
  * [x] server/console
  * [x] server/details
  * [ ] server/reboot
   * Not applicable, covered by server/stop with type reboot.
  * [x] server/start
  * [x] server/status
    * TODO need formatting and input handling. Just dumps the json for
      now.
  * [x] server/stop
  * [ ] server/clone
  * [ ] server/edit
  * [ ] server/costs
  * [ ] server/estimatedcost
  * [ ] server/createfrombackup
  * [ ] server/listbackups
  * [ ] server/addiso
  * [ ] server/listiso
  * [ ] server/mountiso
  * [ ] server/networkadapters
  * [ ] server/previewcloudconfig
  * [ ] server/resetpassword
  * [ ] server/resourceusage
  * [ ] Add helper `gleshys server has key` to check if server exists in
        project.
  * [ ] server/limits
    * Only for OpenVZ.
  * [ ] server/resetlimit
    * Only for OpenVZ.
* [ ] sshkey
  * This feature is obsolete.
* [ ] transaction
* [ ] user
  * [!] user/login
  * [!] user/logout
  * [!] user/listorganizations
* [x] vpn
 * covered by `bin/gleshys-vpn`

* ! Are touched in some way during the process.
* x These are considered 'done' by some definition. See further notes.

## TODO / Help needed

This is stuff that has popped up during development. There are also
som TODO comments sprinkled in the code files, use `git grep '# TODO'`
to find these. Some of them overlap this list.

The script `bin/gleshys-project-status` will list all public endpoints
that remain to implement in some capacity. Do however note that the
list will not guarantee that omitted endpoints are fully implemented -
it just tells you that they are in use in some capacity.

* [ ] check depedencies
* [ ] login
  * a `session-restart` to check if the apikey provided is a permanent
    or not...or if the session is still valid.
  * add a common way to find settingsfile if no one was provided, will
    show as a login prompt and be seemless for the user.  if no
    GLESHYSSETTINGS and no ~/.config... create a disposable
    settingsfile and be vocal about it. If the tool created the file
    it can also remove it.
	Probably a good idea to check if executed as interactive or not....
* [ ] bash completion support
* [ ] do we need a INPUTRC for readline?
* [ ] add fault tolerance and internals for curl-json
      as a start it would be nice if it piped a !200 to jq and then
      exited with error code from curl. current process pretty much
      forces the user to never ever fail in the input. or forces the
      script to do input validation (and that require knowledge about
      acceptable inputs....which is hard)
* [ ] Impove information extraction for object storage.
* [ ] Does object storage call the identifier "key" or "id". Minor
      clean up.
* [ ] Use shellspec?
* [ ] Propose to expose the session timeout timestamp in user/details
* [ ] Rewrite `bin/gleshys-project-status` to use `api/listfunctions`?
* [ ] `gleshys ip info 1.1.1.1` will return jq error if IP is not owned by
      project.
* [ ] The usage of `server/allowedarguments` is spread all over the
      server script. Need an overhaul.
* [ ] man pages for all commands.
* [ ] Add `--max-time` to `curl-json`?

# License

This project is distributed free using the MIT license as approved by
the OSI. This information is also stated in all applicable files in
the project.

The license text can be found in the file LICENSE or at the [OSI web
pages](https://opensource.org/licenses/MIT).

# Development and reporting issues

There will be some project page somewhere some day.

If some dependency is not aligned the version check can be
bypassed... when that feature is built.
See `gleshys-dep-check` for notes.
