From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 07/15] distribute all necessary files
Date: Tue, 24 Jul 2007 11:25:24 +0200
Message-ID: <20070724092601.047964714@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60037 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765384AbXGXKAR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:00:17 -0400
Content-Disposition: inline; filename=distribute_all_necessary_files.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Some files are missing in the distro kit, add them. We also add config
to the list of subdirs.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 GNUmakefile.am               |    3 +++
 func/pi-tests/GNUmakefile.am |    3 +++
 2 files changed, 6 insertions(+)

Index: func/pi-tests/GNUmakefile.am
===================================================================
--- func/pi-tests/GNUmakefile.am.orig
+++ func/pi-tests/GNUmakefile.am
@@ -40,6 +40,9 @@ testpi_7_CPPFLAGS = \
 	$(AM_CPPFLAGS) \
 	-I$(srcdir)
 
+EXTRA_DIST = \
+	test-skeleton.c
+
 MAINTAINERCLEANFILES = \
 	GNUmakefile.in
 
Index: GNUmakefile.am
===================================================================
--- GNUmakefile.am.orig
+++ GNUmakefile.am
@@ -1,9 +1,12 @@
 SUBDIRS = \
+	config \
         include \
         func \
         perf \
         stress
 
+EXTRA_DIST = \
+	autogen.sh
 
 MAINTAINERCLEANFILES = \
         GNUmakefile.in 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
