# teleport

> Project to learn how to write a CLI in Haskell, inspired by https://bollu.github.io/teleport/

## Usage

`teleport add NAME`

* Add a warp location called `NAME` pointing to the current directory

`teleport warp NAME`

* Warp to the location associated with `NAME`

`teleport rm NAME`

* Remove the warp location called `NAME`

## Building/Running it locally

* Install [Stack](https://docs.haskellstack.org/en/stable/README/)
* Pull down repo `git clone https://github.com/jaredramirez/teleport.git`
* `cd teleport`
* `./scripts/build.sh` (this make take a while since it will download all of this project's dependecies)
* `./scripts/run.sh`

## Other things

While the idea for this project is a direct copy from https://bollu.github.io/teleport/, this implementation is unique and unrelated to bollu's project
