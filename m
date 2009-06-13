From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH -rt] disable building all staging drivers
Date: Sat, 13 Jun 2009 23:38:38 +0200
Message-ID: <1244929118-23326-1-git-send-email-u.kleine-koenig__24480.5129398175$1244931729$gmane$org@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	Frank Mori Hess <fmhess@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51326 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZFMWV5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 13 Jun 2009 18:21:57 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MFbbr-00082e-C3
	for linux-rt-users@vger.kernel.org; Sun, 14 Jun 2009 00:21:59 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MFbbr-00086Y-97
	for linux-rt-users@vger.kernel.org; Sun, 14 Jun 2009 00:21:59 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I know that at least COMEDI and RT2870 are broken with -rt, but Thomas
requested disabling all of staging.  He's the maintainer.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: Frank Mori Hess <fmhess@users.sourceforge.net>
---
 drivers/staging/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 211af86..3d1a966 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -1,6 +1,7 @@
 menuconfig STAGING
 	bool "Staging drivers"
 	default n
+	depends on BROKEN
 	---help---
 	  This option allows you to select a number of drivers that are
 	  not of the "normal" Linux kernel quality level.  These drivers
--=20
1.6.3.1


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
