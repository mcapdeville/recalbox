################################################################################
#
# BEETLE_PSX
#
################################################################################
LIBRETRO_BEETLE_PSX_VERSION = 7616e0125984bc07deb6a0526c30c3cac7e4e388
LIBRETRO_BEETLE_PSX_SITE = $(call github,libretro,beetle-psx-libretro,$(LIBRETRO_BEETLE_PSX_VERSION))


define LIBRETRO_BEETLE_PSX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_BEETLE_PSX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mednafen_psx_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mednafen_psx_libretro.so
endef

define LIBRETRO_BEETLE_PSX_CROSS_FIXUP
	$(SED) 's|-I/usr/local/include|-I$(STAGING_DIR)/usr/include|g' $(@D)/Makefile.common
endef

LIBRETRO_BEETLE_PSX_PRE_CONFIGURE_HOOKS += LIBRETRO_BEETLE_PSX_CROSS_FIXUP

$(eval $(generic-package))
