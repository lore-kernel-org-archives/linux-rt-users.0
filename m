From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] rtc-tegra: properly initialize spinlock
Date: Fri, 22 Jul 2011 10:35:56 +0200
Message-ID: <1311323756-18013-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, jkastner@redhat.com
To: Andrew Chew <achew@nvidia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36684 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1GVIgd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 04:36:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Using __SPIN_LOCK_UNLOCKED for a dynamically allocated lock is wrong an=
d
breaks with PREEMPT_RT_FULL.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/rtc/rtc-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 2fc31aa..75259fe 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -343,7 +343,7 @@ static int __devinit tegra_rtc_probe(struct platfor=
m_device *pdev)
=20
 	/* set context info. */
 	info->pdev =3D pdev;
-	info->tegra_rtc_lock =3D __SPIN_LOCK_UNLOCKED(info->tegra_rtc_lock);
+	spin_lock_init(&info->tegra_rtc_lock);
=20
 	platform_set_drvdata(pdev, info);
=20
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
