From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 10/10] [ARM] enable generic time and generic clock events for arm
Date: Fri, 15 Dec 2006 23:37:08 +0100
Message-ID: <20061215224329.875791000@metis.extern.pengutronix.de>
References: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51229 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349AbWLOXIG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:08:06 -0500
To: linux-rt-users@vger.kernel.org
Content-Disposition: inline; filename=high-res-timers-dynticks-enable-arm-support.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Luotao Fu <lfu@pengutronix.de>

Turns hrt config options on for arm. It does this unconditionally
so it currently breaks platforms that don't support a clocksource.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>

Index: arch/arm/Kconfig
===================================================================
--- arch/arm/Kconfig.orig
+++ arch/arm/Kconfig
@@ -21,6 +21,11 @@ config GENERIC_TIME
 	bool
 	default n
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default y
+
+
 config MMU
 	bool
 	default y
@@ -179,6 +184,7 @@ config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARM_AMBA
 	select ARM_VIC
+	select GENERIC_TIME
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
@@ -192,6 +198,7 @@ config ARCH_FOOTBRIDGE
 config ARCH_NETX
 	bool "Hilscher NetX based"
 	select ARM_VIC
+	select GENERIC_TIME
 	help
 	  This enables support for systems based on the Hilscher NetX Soc
 
@@ -203,6 +210,7 @@ config ARCH_H720X
 
 config ARCH_IMX
 	bool "IMX"
+	select GENERIC_TIME
 	help
 	  Support for Motorola's i.MX family of processors (MX1, MXL).
 
@@ -265,6 +273,7 @@ config ARCH_PNX4008
 config ARCH_PXA
 	bool "PXA2xx-based"
 	depends on MMU
+	select GENERIC_TIME
 	select ARCH_MTD_XIP
 	help
 	  Support for Intel's PXA2XX processor line.
@@ -443,6 +452,8 @@ endmenu
 
 menu "Kernel Features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && REALVIEW_MPCORE

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
