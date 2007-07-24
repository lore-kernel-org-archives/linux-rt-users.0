From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 14/15] remove bogus characters from makefile
Date: Tue, 24 Jul 2007 11:25:31 +0200
Message-ID: <20070724092616.948018143@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45918 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762731AbXGXKGr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:06:47 -0400
Content-Disposition: inline; filename=remove_bogus_characters.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Subject says it all ...

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 func/periodic_cpu_load/GNUmakefile.am |    6 ------
 1 file changed, 6 deletions(-)

Index: func/periodic_cpu_load/GNUmakefile.am
===================================================================
--- func/periodic_cpu_load/GNUmakefile.am.orig
+++ func/periodic_cpu_load/GNUmakefile.am
@@ -29,9 +29,3 @@ periodic_cpu_load_single_LDADD = \
 MAINTAINERCLEANFILES = \
         GNUmakefile.in
 
-~
-~
-~
-~
-~
-

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
