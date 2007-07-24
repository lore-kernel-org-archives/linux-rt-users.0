From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 09/15] add a makefile for stress/pi-tests
Date: Tue, 24 Jul 2007 11:25:26 +0200
Message-ID: <20070724092605.592242611@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45926 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765531AbXGXKHJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:07:09 -0400
Content-Disposition: inline; filename=add_makefile_stress_pi_tests.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This directory should have a GNUmakefile.am.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 stress/pi-tests/GNUmakefile.am |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: stress/pi-tests/GNUmakefile.am
===================================================================
--- /dev/null
+++ stress/pi-tests/GNUmakefile.am
@@ -0,0 +1,22 @@
+bin_PROGRAMS = \
+	testpi-3 \
+	lookup_pi_state
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl \
+	-D_GNU_SOURCE
+
+AM_CFLAGS = \
+	-O2
+
+LDADD = \
+	$(top_builddir)/include/libjvmsim.a \
+	$(top_builddir)/include/librt.a \
+	$(top_builddir)/include/libstats.a \
+	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
