################################################################################
#
# fcctui
#
################################################################################

FCCTUI_VERSION = chip/stable
FCCTUI_SITE = https://github.com/NextThingCo/fcctui
FCCTUI_SITE_METHOD = git
FCCTUI_DEPENDENCIES = stress
FCCTUI_MAKE_ENV = PKG_CONFIG="$(HOST_DIR)/usr/bin/pkg-config"
FCCTUI_MAKE_OPTS = CC="$(TARGET_CC)" LD="$(TARGET_LD)" LDFLAGS="$(TARGET_LDFLAGS)"

define FCCTUI_BUILD_TARGET_CMDS
	$(FCCTUI_MAKE_ENV) $(MAKE) $(FCCTUI_MAKE_OPTS) -C $(@D)
endef

define FCCTUI_INSTALL_TARGET_CMDS
	$(FCCTUI_MAKE_ENV) $(MAKE) $(FCCTUI_MAKE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

define FCCTUI_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/fcctui/S99_em_compliance $(TARGET_DIR)/etc/init.d/S99_em_compliance
endef

$(eval $(generic-package))
