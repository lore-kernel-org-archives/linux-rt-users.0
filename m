From: Remy Bohmer <linux@bohmer.net>
Subject: [PATCH] get rid of [softirq-NULL]
Date: Thu, 24 Sep 2009 22:43:53 +0200
Message-ID: <1253825033-30094-1-git-send-email-linux@bohmer.net>
Cc: Remy Bohmer <linux@bohmer.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:34341 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZIXUnx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 16:43:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

if CONFIG_HIGH_RES_TIMERS is not configured, still the hrtimer-softirq
is started, so to prevent the name 'softirq-NULL' in 'ps' output we
should still define its name here.
Preventing the softirq from starting at all would touch much more code, so
I chose the easy way here, it is a cosmetic fix anyway.

Signed-off-by: Remy Bohmer <linux@bohmer.net>
---
 kernel/softirq.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index aae8d45..590049c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1139,9 +1139,7 @@ static const char *softirq_names [] =
   [NET_RX_SOFTIRQ]	= "net-rx",
   [BLOCK_SOFTIRQ]	= "block",
   [TASKLET_SOFTIRQ]	= "tasklet",
-#ifdef CONFIG_HIGH_RES_TIMERS
   [HRTIMER_SOFTIRQ]	= "hrtimer",
-#endif
   [RCU_SOFTIRQ]		= "rcu",
 };
 
-- 
1.6.0.4

