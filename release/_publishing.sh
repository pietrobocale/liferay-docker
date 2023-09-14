#!/bin/bash

function init_gcs {
	if [ ! -e /opt/liferay/patcher-storage-service-account.json ]
	then
		lc_log INFO "Skipping initialization of GCS because /opt/liferay/patcher-storage-service-account.json does not exist."

		return "${LIFERAY_COMMON_EXIT_CODE_SKIPPED}"
	fi

	gcloud auth activate-service-account --key-file /opt/liferay/patcher-storage-service-account.json
}

function upload_bundle {
	if [ "${LIFERAY_RELEASE_UPLOAD}" == "true" ]
	then
		lc_log INFO "Skipping upload of artifacts because the environment variable LIFERAY_RELEASE_UPLOAD was not set to \"true\"."

		return "${LIFERAY_COMMON_EXIT_CODE_SKIPPED}"
	fi

	gsutil cp "${_BUILD_DIR}"/release/* "gs://patcher-storage/dxp/${_DXP_VERSION}/"
}

function upload_hotfix {
	if [ "${LIFERAY_RELEASE_UPLOAD}" == "true" ]
	then
		lc_log INFO "Skipping upload of artifacts because the environment variable LIFERAY_RELEASE_UPLOAD was not set to \"true\"."

		return "${LIFERAY_COMMON_EXIT_CODE_SKIPPED}"
	fi

	gsutil cp "${_BUILD_DIR}/${_HOTFIX_FILE_NAME}" "gs://patcher-storage/hotfix/${_DXP_VERSION}/"
}