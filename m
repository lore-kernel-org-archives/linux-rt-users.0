From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Wed, 23 Sep 2015 19:33:40 +0200
Message-ID: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:56692 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbIWRt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Sep 2015 13:49:57 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Since the HWLAT_DETECTOR driver supposedly shouldn't be builtin, but a
module when used at all, it would make sense to limit the configuration
choices:

Signed-off-by: Joakim Hernberg <jhernberg@alchemy.lu>
Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

---
 drivers/misc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 453a616..94756c3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -124,8 +124,7 @@ config IBM_ASM
=20
 config HWLAT_DETECTOR
 	tristate "Testing module to detect hardware-induced latencies"
-	depends on DEBUG_FS
-	depends on RING_BUFFER
+	depends on DEBUG_FS && RING_BUFFER && m
 	default m
 	---help---
 	  A simple hardware latency detector. Use this module to detect
--=20
2.5.3

--=20

   Joakim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
