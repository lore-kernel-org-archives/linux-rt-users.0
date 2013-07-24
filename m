From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3.8-rt] trivial: fix typo in description of PREEMPT_RTB
Date: Wed, 24 Jul 2013 17:35:23 +0200
Message-ID: <1374680123-14367-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48628 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab3GXPff (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Jul 2013 11:35:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 kernel/Kconfig.preempt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 38cecfe..11dbe26 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -70,7 +70,7 @@ config PREEMPT_RTB
 	select PREEMPT_RT_BASE
 	help
 	  This option is basically the same as (Low-Latency Desktop) but
-	  enables changes which are preliminary for the full preemptiple
+	  enables changes which are preliminary for the full preemptible
 	  RT kernel.
=20
 config PREEMPT_RT_FULL
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
