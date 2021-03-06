ifneq ($(BUILD_TINY_ANDROID),true)
#Compile this library only for builds with the latest modem image

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libloc_eng
LOCAL_MODULE_OWNER := qcom

LOCAL_MODULE_TAGS := optional

LOCAL_SHARED_LIBRARIES := \
    libutils \
    libcutils \
    libdl \
    liblog \
    libloc_core \
    libgps.utils \
    libprocessgroup

LOCAL_SRC_FILES += \
    loc_eng.cpp \
    loc_eng_agps.cpp \
    loc_eng_xtra.cpp \
    loc_eng_ni.cpp \
    loc_eng_log.cpp \
    loc_eng_nmea.cpp \
    LocEngAdapter.cpp

LOCAL_SRC_FILES += \
    loc_eng_dmn_conn.cpp \
    loc_eng_dmn_conn_handler.cpp \
    loc_eng_dmn_conn_thread_helper.c \
    loc_eng_dmn_conn_glue_msg.c \
    loc_eng_dmn_conn_glue_pipe.c

LOCAL_CFLAGS += \
     -fno-short-enums \
     -D_ANDROID_

ifeq ($(QCPATH),)
LOCAL_CFLAGS += -DOSS_BUILD
endif

LOCAL_C_INCLUDES:= \
    $(LOCAL_PATH) \
    $(TARGET_OUT_HEADERS)/libflp

LOCAL_HEADER_LIBRARIES += \
    gps_utils_headers \
    libloc_core_headers

#LOCAL_COPY_HEADERS_TO:= libloc_eng/
#LOCAL_COPY_HEADERS:= \
#   LocEngAdapter.h \
#   loc.h \
#   loc_eng.h \
#   loc_eng_xtra.h \
#   loc_eng_ni.h \
#   loc_eng_agps.h \
#   loc_eng_msg.h \
#   loc_eng_log.h

LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := gps.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_OWNER := qcom

LOCAL_MODULE_TAGS := optional

## Libs

LOCAL_SHARED_LIBRARIES := \
    libutils \
    libcutils \
    liblog \
    libloc_eng \
    libloc_core \
    libgps.utils \
    libdl \
    libprocessgroup

ifneq ($(filter $(TARGET_DEVICE), apq8084 msm8960), false)
endif

LOCAL_SRC_FILES += \
    loc.cpp \
    gps.c

LOCAL_CFLAGS += \
    -fno-short-enums \
    -D_ANDROID_ \

ifeq ($(TARGET_BUILD_VARIANT),user)
   LOCAL_CFLAGS += -DTARGET_BUILD_VARIANT_USER
endif

ifeq ($(TARGET_USES_QCOM_BSP), true)
LOCAL_CFLAGS += -DTARGET_USES_QCOM_BSP
endif

ifeq ($(QCPATH),)
LOCAL_CFLAGS += -DOSS_BUILD
endif

LOCAL_HEADER_LIBRARIES += \
    gps_utils_headers \
    libloc_core_headers

LOCAL_C_INCLUDES:= \
    $(TARGET_OUT_HEADERS)/libflp

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_RELATIVE_PATH := hw

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
