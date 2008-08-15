From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH RT RFC v2 6/8] rtmutex: use runtime init for rtmutexes
Date: Fri, 15 Aug 2008 08:08:41 -0400
Message-ID: <20080815120841.24722.13234.stgit@dev.haskins.net>
References: <20080815120722.24722.66516.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	gregory.haskins@gmail.com, David.Holmes@sun.com
To: mingo@elte.hu, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
	tglx@linutronix.de, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-108-43.dhcp.oxfr.ma.charter.com ([75.130.108.43]:43033
	"EHLO dev.haskins.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbYHOM2x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Aug 2008 08:28:53 -0400
In-Reply-To: <20080815120722.24722.66516.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The system already has facilities to perform late/run-time init for
rtmutexes.  We want to add more advanced initialization later in the
series so we force all rtmutexes through the init path in preparation
for the later patches.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 include/linux/rtmutex.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index b263bac..14774ce 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -64,8 +64,6 @@ struct hrtimer_sleeper;
 
 #define __RT_MUTEX_INITIALIZER(mutexname) \
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED(mutexname) \
-	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list, &mutexname.wait_lock) \
-	, .owner = NULL \
 	__DEBUG_RT_MUTEX_INITIALIZER(mutexname)}
 
 #define DEFINE_RT_MUTEX(mutexname) \

