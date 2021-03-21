#!/usr/bin/bats

setup() {
	settings=$(mktemp -t gleshys-test.XXXXXX)
	echo "one=1" > "$settings"
}

teardown() {
  rm -f "$settings"
}

@test "cfg-get: Correct value shown when found." {
  run bin/cfg-get "$settings" "one"

  (( status == 0 ))
  [[ $output == "1" ]]
}

@test "cfg-get: Default value shown when needle not in haystack." {
  run bin/cfg-get "$settings" "two" "2"

  (( status == 0 ))
  [[ $output == "2" ]]
}

@test "cfg-get: Default value shown when file is not present." {
  run bin/cfg-get "no file" "two" "2"

  (( status == 0 ))
  [[ $output == "2" ]]
}

@test "cfg-get: Default value NOT shown when needle is present." {
  run bin/cfg-get "$settings" "one" "2"

  (( status == 0 ))
  [[ $output == "1" ]]
}

@test "cfg-get: Missing options will exit silent with error code 1." {
  run bin/cfg-get

  (( status == 1 ))
  [[ $output == "" ]]
}

@test "cfg-get: Missing default and no file exit silent with error code 1." {
  run bin/cfg-get "no file" "two"

  (( status == 1 ))
  [[ $output == "" ]]
}
