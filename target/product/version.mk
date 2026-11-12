#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     AOSPA_MAJOR_VERSION
#     AOSPA_MINOR_VERSION
#     AOSPA_BUILD_VARIANT
#

# This is the global AOSPA version flavor that determines the focal point
# behind our releases. This is bundled alongside $(AOSPA_MINOR_VERSION)
# and only changes per major Android releases.
AOSPA_MAJOR_VERSION := vertex

# Release signing keys.
# In-tree keys are used automatically; external keys must be supplied with
# build.sh -s <path>, which exports ANDROID_CERTS_DIR.
ARCVELLE_KEYS_DIR ?= vendor/arcvelle-priv/keys

RELEASE_KEYS_DIR :=
ifneq ($(ANDROID_CERTS_DIR),)
  ifneq ($(wildcard $(ANDROID_CERTS_DIR)/releasekey.x509.pem),)
    RELEASE_KEYS_DIR := $(ANDROID_CERTS_DIR)
    AOSPA_EXTERNAL_KEYS := true
  endif
else ifneq ($(wildcard $(ARCVELLE_KEYS_DIR)/releasekey.x509.pem),)
  RELEASE_KEYS_DIR := $(ARCVELLE_KEYS_DIR)
endif

ifneq ($(RELEASE_KEYS_DIR),)
  ifneq ($(AOSPA_EXTERNAL_KEYS),true)
    $(call inherit-product-if-exists, $(ARCVELLE_KEYS_DIR)/keys.mk)
  endif
  PRODUCT_DEFAULT_DEV_CERTIFICATE := $(RELEASE_KEYS_DIR)/releasekey
  PRODUCT_MAINLINE_BLUETOOTH_SEPOLICY_DEV_CERTIFICATES := $(RELEASE_KEYS_DIR)/
  AOSPA_SIGNED_KEYS := true
endif

# The version code is the upgradable portion during the cycle of
# every major Android release. Each version code upgrade indicates
# our own major release during each lifecycle.
# It is based in three parts
# X for SPL changes, Y for week, and Z for hotfix.
ifdef AOSPA_BUILDVERSION
    AOSPA_MINOR_VERSION := $(AOSPA_BUILDVERSION)
endif

# Build Variants
#
# Alpha: Development / Test releases
# Beta: Public releases with CI
# Stable: Signed final release
# Official: Signed release with private keys
# Unofficial: Unsigned / non-release keys
ifdef AOSPA_BUILDTYPE
  ifeq ($(AOSPA_BUILDTYPE), ALPHA)
      AOSPA_BUILD_VARIANT := alpha
  else ifeq ($(AOSPA_BUILDTYPE), BETA)
      AOSPA_BUILD_VARIANT := beta
  else ifeq ($(AOSPA_BUILDTYPE), STABLE)
    ifeq ($(AOSPA_SIGNED_KEYS), true)
        AOSPA_BUILD_VARIANT := stable
    else
        AOSPA_BUILD_VARIANT := unofficial
    endif
  else ifeq ($(AOSPA_BUILDTYPE), OFFICIAL)
    ifeq ($(AOSPA_SIGNED_KEYS), true)
        AOSPA_BUILD_VARIANT := official
    else
        AOSPA_BUILD_VARIANT := unofficial
    endif
  endif
else
  ifeq ($(AOSPA_SIGNED_KEYS), true)
      AOSPA_BUILD_VARIANT := official
  else
      AOSPA_BUILD_VARIANT := unofficial
  endif
endif

# Build Date
BUILD_DATE := $(shell date -u +%Y%m%d)

# AOSPA Version
AOSPA_VERSION := $(AOSPA_MAJOR_VERSION)-$(AOSPA_BUILD_VARIANT)-
AOSPA_DISPLAY_VERSION := $(shell echo $(AOSPA_MAJOR_VERSION) | awk '{ print toupper(substr($$0,1,1)) substr($$0,2) }') $(shell echo $(AOSPA_BUILD_VARIANT) | awk '{ print toupper(substr($$0,1,1)) substr($$0,2) }')

ifdef AOSPA_MINOR_VERSION
    AOSPA_VERSION += $(AOSPA_MINOR_VERSION)-
    AOSPA_DISPLAY_VERSION += $(AOSPA_MINOR_VERSION)
endif

# Add BUILD_DATE for zip naming
AOSPA_VERSION += $(AOSPA_BUILD)-$(BUILD_DATE)

# Remove unwanted characters for zip naming
AOSPA_VERSION := $(shell echo -n $(AOSPA_VERSION) | tr -d '[:space:]')
