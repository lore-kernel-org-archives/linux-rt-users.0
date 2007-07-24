From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 12/15] fix version and contact information
Date: Tue, 24 Jul 2007 11:25:29 +0200
Message-ID: <20070724092612.384609187@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60034 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764184AbXGXKAM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:00:12 -0400
Content-Disposition: inline; filename=fix_version_and_contact.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Make sure that the packet is named correctly and bugs are reported to
the right address.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: configure.ac
===================================================================
--- configure.ac.orig
+++ configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 AC_PREREQ(2.61)
 
-AC_INIT([rttests],[0.0.0],[bugs@pengutronix.de])
+AC_INIT([rt-test],[0.3],[linux-rt-users@vger.kernel.org])
 AC_CONFIG_HEADERS([include/rttests_config.h])
 #AC_CONFIG_SRCDIR([internal/examples/libstats_test.c])
 AC_CONFIG_MACRO_DIR([config/m4])

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
