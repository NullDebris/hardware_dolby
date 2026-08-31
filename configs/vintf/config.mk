define add-dolby-manifest-file
  ifneq ($(strip $(DEVICE_MANIFEST_SKUS)),)
    $$(foreach sku,$$(DEVICE_MANIFEST_SKUS), \
      $$(eval DEVICE_MANIFEST_$$(call to-upper,$$(sku))_FILES += $(1)))
  else
    ifneq ($(strip $(DEVICE_MANIFEST_FILE)),)
      DEVICE_MANIFEST_FILE += $(1)
    endif
  endif
endef

ifeq ($(strip $(DOLBY_TARGET_USES_AIDL)),true)

ifeq ($(or $(strip $(TARGET_BUILD_DOLBY_CODECS)),$(strip $(TARGET_BUILD_DOLBY_EFFECTS))),true)
  DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DOLBY_PATH)/configs/vintf/dolby_framework_matrix_aidl.xml
endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_EFFECTS)),true)
  $(eval $(call add-dolby-manifest-file,$(DOLBY_PATH)/configs/vintf/dms-service.xml))
endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_CODECS)),true)
  $(eval $(call add-dolby-manifest-file,$(DOLBY_PATH)/configs/vintf/vendor.dolby.media.c2-default-service-dax.xml))
endif

else 

ifeq ($(or $(strip $(TARGET_BUILD_DOLBY_CODECS)),$(strip $(TARGET_BUILD_DOLBY_EFFECTS))),true)
  DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DOLBY_PATH)/configs/vintf/dolby_framework_matrix.xml
endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_EFFECTS)),true)
  $(eval $(call add-dolby-manifest-file,$(DOLBY_PATH)/configs/vintf/vendor.dolby.hardware.dms@2.0-service.xml))
endif

ifeq ($(strip $(TARGET_BUILD_DOLBY_CODECS)),true)
  $(eval $(call add-dolby-manifest-file,$(DOLBY_PATH)/configs/vintf/vendor.dolby.media.c2@1.0-service.xml))
endif

endif
