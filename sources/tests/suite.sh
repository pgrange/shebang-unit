#!/bin/bash

_SUITE_DIRECTORY="$(dirname ${BASH_SOURCE[0]})"

function _releaseShebangUnit() {
	source ${_SUITE_DIRECTORY}/../../releases/release.sh
	release::concatenate_sources_in_release_file
}

_releaseShebangUnit
./"$(release::get_released_artifact_file)" "${_SUITE_DIRECTORY}" $@