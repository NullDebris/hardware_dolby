#
# Copyright (C) 2022 FlamingoOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_BUILD_DOLBY_CODECS ?= true
TARGET_BUILD_DOLBY_EFFECTS ?= true

# Dolby path
DOLBY_PATH := hardware/dolby

# Soong Namespace
PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(DOLBY_PATH)/sepolicy/vendor

ifeq ($(or $(strip $(TARGET_BUILD_DOLBY_CODECS)),$(strip $(TARGET_BUILD_DOLBY_EFFECTS))),true)

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DOLBY_PATH)/configs/vintf/dolby_framework_matrix.xml

endif 

ifeq ($(strip $(TARGET_BUILD_DOLBY_EFFECTS)),true)

# LunarisDolby
PRODUCT_PACKAGES += LunarisDolby

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.dolby.dax.version=DAX3_3.7.0.8_r1 \
    ro.audio.spatializer_enabled=true \
    ro.vendor.audio.dolby.dax.support=true \
    ro.vendor.audio.dolby.surround.enable=true \
    ro.audio.spatializer_transaural_enabled_default=false \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false

endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_CODECS)),true)
PRODUCT_PACKAGES +=  DolbyCodecs
endif

