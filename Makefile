#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lowpan-tools
PKG_VERSION:=0.3.x
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee/linux-zigbee
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=bbb81d17775ac878f7d06bdd928ebaaf37421077

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

CONFIGURE_VARS += \
	NL_CFLAGS="-I$(STAGING_DIR)/usr/include/libnl-tiny -Dnl_handle=nl_sock -Dnl_handle_alloc=nl_socket_alloc -Dnl_handle_destroy=nl_socket_destroy" \
	NL_LIBS="-lnl -lnl-genl"

define Package/lowpan-tools
    TITLE:=a set of utils to manage the Linux LoWPAN stack
    SECTION:=network
    CATEGORY:=Network
    URL:=http://sourceforge.net/apps/trac/linux-zigbee/
    DEPENDS:=+libnl
endef

define Package/lowpan-tools/description
This is a set of utils to manage the Linux LoWPAN stack.
The LoWPAN stack aims for IEEE 802.15.4-2003 (and for lesser extent
IEEE 802.15.4-2006) compatibility.

If you want to learn more, please go to http://linux-zigbee.sf.net/
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/include/ieee802154.h $(1)/usr/include
endef

define Package/lowpan-tools/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/{iz,izattach,izchat,izcoordinator} $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,lowpan-tools))

