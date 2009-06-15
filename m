From: John Kacur <jkacur@redhat.com>
Subject: Uwe Kleine-Koenig's mangled name
Date: Mon, 15 Jun 2009 13:11:29 +0200
Message-ID: <20090615111129.GA10716@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: tglx@linutronix.de, u.kleine-koenig@pengutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:51950 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbZFOLLr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2009 07:11:47 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-Koenig's name with an umlaut got mangled in the "From" line.=
 (but not the signed-off:)
This breaks my build scripts. He says this convention is correct, and i=
t's my problem. So pls apply this patch of the patch
to fix my problem!

Thanks

--- include-linux-delay-h-in-hwlat_detector.old.patch	2009-06-15 12:46:=
52.974099929 +0200
+++ include-linux-delay-h-in-hwlat_detector.patch	2009-06-15 12:47:57.5=
05099460 +0200
@@ -1,6 +1,5 @@
 Subject: include linux/delay.h in hwlat_detector
-From: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D=20
-	<u.kleine-koenig@pengutronix.de>
+From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
 Date: Sun, 14 Jun 2009 23:31:42 +0200
=20
 This broke when compiling on i386 without X86_LOCAL_APIC because then

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
