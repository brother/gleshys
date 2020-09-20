# The GleShYS cloud.

Welcome to the new^wold world.

# tldr;

TODO: The quick start gudie

Set your PATH to include the bin directory of this repo as the first
instance.

> brother ~$ grep brother.*PATH .bashrc

> export PATH="/home/brother/git/other/gleshys/bin:$PATH"


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

* [ ] account
* [ ] api
* [x] archive
  * covered by `bin/archive`
  * [ ] cloak passwords, they are managed via -p command line flag and
        thus public for the machine.
* [ ] country
* [ ] customer
  * [!] customer/listprojects
* [ ] domain
* [ ] email
* [x] filestorage
  * covered by `bin/file-storage`
  * [ ] Need to settle the output. Possibly add an interactive mode.
* [ ] invoice
* [x] ip
  * covered by `bin/gip`
* [ ] loadbalancer
* [x] network
  * covered by `bin/network`
* [ ] networkadapter
* [x] objectstorage
  * covered by `bin/object-storage`
* [ ] paymentcard
* [ ] project
* [ ] server
  * [x] server/list
  * [ ] Add helper `server has key` to check if server exists in
        project.
* [ ] sshkey
* [ ] transaction
* [ ] user
  * [!] user/login
  * [!] user/logout
  * [!] user/listorganizations
* [x] vpn
 * covered by `bin/vpn`
 * Must revisit enable and disable feature. It wasn't working in
   https://cloud.glesys.com either.

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

* [ ] Rename commands to a sane pattern. They are too generic.
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
