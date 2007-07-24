From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 10/15] fixup maintainerclean
Date: Tue, 24 Jul 2007 11:25:27 +0200
Message-ID: <20070724092607.856146831@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60036 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764184AbXGXKAP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:00:15 -0400
Content-Disposition: inline; filename=complete_maintainerclean.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add some more things which have to be cleaned on maintainer-clean; this
does also remove directories in the case that something went wrong
during development, leaving the tree in a non-clean state.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 GNUmakefile.am |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: GNUmakefile.am
===================================================================
--- GNUmakefile.am.orig
+++ GNUmakefile.am
@@ -9,5 +9,10 @@ EXTRA_DIST = \
 	autogen.sh
 
 MAINTAINERCLEANFILES = \
-        GNUmakefile.in 
+	GNUmakefile.in \
+	$(DIST_ARCHIVES)
+
+maintainer-clean-local:
+	-chmod -R a+rw $(distdir)
+	-rm -fr $(distdir)
 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
