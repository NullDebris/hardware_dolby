ifeq ($(or $(strip $(TARGET_BUILD_DOLBY_CODECS)),$(strip $(TARGET_BUILD_DOLBY_EFFECTS))),true)

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DOLBY_PATH)/configs/vintf/dolby_framework_matrix.xml

endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_EFFECTS)),true)

ifneq ($(strip $(DEVICE_MANIFEST_SKUS)),)
$(foreach sku,$(DEVICE_MANIFEST_SKUS), \
    $(eval DEVICE_MANIFEST_$(call to-upper,$(sku))_FILES += $(DOLBY_PATH)/configs/vintf/vendor.dolby.hardware.dms@2.0-service.xml))
else

ifneq ($(strip $(DEVICE_MANIFEST_FILE)),)
DEVICE_MANIFEST_FILE += $(DOLBY_PATH)/configs/vintf/vendor.dolby.hardware.dms@2.0-service.xml
endif

endif

endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_CODECS)),true)

ifneq ($(strip $(DEVICE_MANIFEST_SKUS)),)
$(foreach sku,$(DEVICE_MANIFEST_SKUS), \
    $(eval DEVICE_MANIFEST_$(call to-upper,$(sku))_FILES += $(DOLBY_PATH)/configs/vintf/vendor.dolby.media.c2@1.0-service.xml))
else

ifneq ($(strip $(DEVICE_MANIFEST_FILE)),)
DEVICE_MANIFEST_FILE += $(DOLBY_PATH)/configs/vintf/vendor.dolby.media.c2@1.0-service.xml
endif

endif
endif


