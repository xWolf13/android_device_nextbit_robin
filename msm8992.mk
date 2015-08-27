# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8992/overlay

ifneq ($(TARGET_USES_AOSP),true)
TARGET_USES_QCA_NFC := true
TARGET_USES_QCOM_BSP := false
endif
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# copy customized media_profiles and media_codecs xmls for 8992
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8992/media_profiles.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8992/media_codecs.xml:system/etc/media_codecs.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common64.mk)

PRODUCT_NAME := msm8992
PRODUCT_DEVICE := msm8992
PRODUCT_BRAND := Android
PRODUCT_MODEL := MSM8992 for arm64

PRODUCT_BOOT_JARS += vcard
PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += qcmediaplayer
#PRODUCT_BOOT_JARS += org.codeaurora.Performance

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += qcom.fmradio
PRODUCT_BOOT_JARS += com.qti.dpmframework
PRODUCT_BOOT_JARS += dpmapi
PRODUCT_BOOT_JARS += oem-services
PRODUCT_BOOT_JARS += WfdCommon
#PRODUCT_BOOT_JARS += extendedmediaextractor
#PRODUCT_BOOT_JARS += security-bridge
#PRODUCT_BOOT_JARS += qsb-port
endif

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
ifeq ($(TARGET_USES_AOSP), true)
PRODUCT_COPY_FILES += \
    device/qcom/common/media/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
    device/qcom/msm8992/audio_policy.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    device/qcom/msm8992/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/qcom/msm8992/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/msm8992/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/qcom/msm8992/mixer_paths_i2s.xml:system/etc/mixer_paths_i2s.xml \
    device/qcom/msm8992/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    device/qcom/msm8992/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    device/qcom/msm8992/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/qcom/msm8992/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/qcom/msm8992/audio_platform_info.xml:system/etc/audio_platform_info.xml

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8992/listen_platform_info.xml:system/etc/listen_platform_info.xml

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/qcom/msm8992/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/qcom/msm8992/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8992/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PACKAGES += \
    wpa_supplicant \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8992/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk0p28
PRODUCT_AAPT_CONFIG += xlarge large
