#!/usr/bin/bats

setup() {
	settings=$(mktemp -t gleshys-test.XXXXXX)
	echo "one=1" > "$settings"
}

teardown() {
  rm -f "$settings"
}

@test "cfg-set: Write to settings file." {
  run bin/cfg-set "$settings" "two" "2"

  (( status == 0 ))
  [[ $output == "" ]]
}

@test "cfg-set: Overwrite earlier information in settings file." {
  run bin/cfg-set "$settings" "one" "2"

  (( status == 0 ))

  run bin/cfg-get "$settings" "one"

  [[ $output == "2" ]]
}

@test "cfg-set: Store multiple values in settings file." {
  run bin/cfg-set "$settings" "two" "2"
  run bin/cfg-set "$settings" "three" "3"

  (( status == 0 ))

  run bin/cfg-get "$settings" "one"
  [[ $output == "1" ]]
  run bin/cfg-get "$settings" "two"
  [[ $output == "2" ]]
  run bin/cfg-get "$settings" "three"
  [[ $output == "3" ]]
}


@test "cfg-set: Missing file will be created for storage." {
  # remove temporary file created in setup
  run rm -f "$settings"

  # cfg-set will create the file and then store.
  if [[ ! -f "$settings" ]]; then
	  run bin/cfg-set "$settings" "hello" "world"
  fi
  (( status == 0 ))

  # Only execute command if file has been created, thus fail the test
  # if file is still missing.
  if [[ -f "$settings" ]]; then
	  run cfg-get "$settings" "hello"
  fi
  [[ $output == "world" ]]
}

@test "cfg-set: Missing options will exit usage and error messages and exit code 1." {
  run bin/cfg-set

  (( status == 1 ))
  [[ $output == "USAGE: cfg-set filename key value

ERROR: Invalid number of arguments." ]]
}
