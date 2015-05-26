From: anna-maria@glx-um.de
Subject: [patch 2/3] cyclictest: Convert the offset of the alignment option to
 microseconds
Date: Tue, 26 May 2015 19:07:03 -0000
Message-ID: <20150526190443.640221319@glx-um.de>
References: <20150526190333.510838769@glx-um.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39450 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbEZTv3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 15:51:29 -0400
Content-Disposition: inline; filename=align-use-microseconds.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The offset is specified in microseconds according to the
documentation, but, the microseconds to nanoseconds conversion is
missing so the effective offset has the unit of nanoseconds.

Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -1289,7 +1289,7 @@ static void process_options (int argc, c
 		case OPT_ALIGNED:
 			aligned=1;
 			if (optarg != NULL)
-				offset = atoi(optarg);
+				offset = atoi(optarg) * 1000;
 			else if (optind<argc && atoi(argv[optind]))
 				offset = atoi(argv[optind]);
 			else


