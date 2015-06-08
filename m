From: Anna-Maria Gleixner <anna-maria@glx-um.de>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Mon, 8 Jun 2015 15:18:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506081513220.2399@tomtetummetott>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de> <alpine.LFD.2.10.1505272324180.13094@riemann> <47e6a4612898bdcbcf3073f27ab93708@tglx.de> <alpine.LFD.2.10.1506021458180.13306@riemann> <alpine.DEB.2.11.1506022247320.20347@nanos>
 <alpine.LFD.2.10.1506022307210.13306@riemann> <alpine.DEB.2.11.1506022332290.20347@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33871 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbbFHNR5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jun 2015 09:17:57 -0400
In-Reply-To: <alpine.DEB.2.11.1506022332290.20347@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2 Jun 2015, Thomas Gleixner wrote:
> Fair enough. Let her resend then.

I'm sorry. Now it applies.
    Anna-Maria


cyclictest: Convert the offset of the alignment option to microseconds

The offset is specified in microseconds according to the
documentation, but, the microseconds to nanoseconds conversion is
missing so the effective offset has the unit of nanoseconds.

Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
---
 src/cyclictest/cyclictest.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -1289,9 +1289,9 @@ static void process_options (int argc, c
 		case OPT_ALIGNED:
 			aligned=1;
 			if (optarg != NULL)
-				offset = atoi(optarg);
+				offset = atoi(optarg) * 1000;
 			else if (optind<argc && atoi(argv[optind]))
-				offset = atoi(argv[optind]);
+				offset = atoi(argv[optind]) * 1000;
 			else
 				offset = 0;
 			break;
