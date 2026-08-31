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
DOLBY_TARGET_USES_AIDL ?= false

# Dolby path
DOLBY_PATH := hardware/dolby

# Soong Namespace
PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)

# AIDL
ifeq ($(strip $(DOLBY_TARGET_USES_AIDL)),true)
BOARD_VENDOR_SEPOLICY_DIRS += $(DOLBY_PATH)/sepolicy/aidl/vendor
PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)/aidl
else
BOARD_VENDOR_SEPOLICY_DIRS += $(DOLBY_PATH)/sepolicy/vendor
PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)/hidl
endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_EFFECTS)),true)

# Lunaris Dolby
PRODUCT_SOONG_NAMESPACES += $(DOLBY_PATH)/LunarisDolby
PRODUCT_PACKAGES += LunarisDolby

ifeq ($(strip $(DOLBY_TARGET_USES_AIDL)),true)

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio.effectimplenter=dolby \
    persist.vendor.audio_fx.current=dolby \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false \
    ro.vendor.dolby.dax.version=DAX3_3.12.0.8_r1 \
    persist.vendor.audio.dolby.tws_tuning=true

else 

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.dolby.dax.version=DAX3_3.7.0.8_r1 \
    ro.audio.spatializer_enabled=true \
    ro.vendor.audio.dolby.dax.support=true \
    ro.vendor.audio.dolby.surround.enable=true \
    ro.audio.spatializer_transaural_enabled_default=false \
    vendor.audio.dolby.ds2.enabled=false \
    vendor.audio.dolby.ds2.hardbypass=false

endif

endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_CODECS)),true)
PRODUCT_PACKAGES +=  DolbyCodecs
endif

