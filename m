From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 11/15] periodic_cpuload_single needs support libs
Date: Tue, 24 Jul 2007 11:25:28 +0200
Message-ID: <20070724092610.124184533@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60035 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764184AbXGXKAO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:00:14 -0400
Content-Disposition: inline; filename=periodic_cpuload_single_needs_supportlibs.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This file needs the support libraries, so link against them.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 func/periodic_cpu_load/GNUmakefile.am |    5 +++++
 1 file changed, 5 insertions(+)

Index: func/periodic_cpu_load/GNUmakefile.am
===================================================================
--- func/periodic_cpu_load/GNUmakefile.am.orig
+++ func/periodic_cpu_load/GNUmakefile.am
@@ -21,6 +21,11 @@ periodic_cpu_load_LDADD = \
          ${top_builddir}/include/librt.a \
          ${top_builddir}/include/libstats.a
 
+periodic_cpu_load_single_LDADD = \
+	$(top_builddir)/include/libjvmsim.a \
+	$(top_builddir)/include/librt.a \
+	$(top_builddir)/include/libstats.a
+
 MAINTAINERCLEANFILES = \
         GNUmakefile.in
 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
