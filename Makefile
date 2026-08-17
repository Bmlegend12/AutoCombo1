TARGET := iphoneos:clang:latest:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MUHelperPatch

MUHelperPatch_FILES = Tweak.x
MUHelperPatch_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
