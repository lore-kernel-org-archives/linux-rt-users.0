From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/5] rtmutex: use task->oncpu to save a call
Date: Tue, 20 May 2008 10:49:26 -0400
Message-ID: <20080520144925.15992.56716.stgit@novell1.haskins.net>
References: <20080520143954.15992.85900.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com, ghaskins@novell.com
To: mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 66-189-124-104.dhcp.oxfr.ma.charter.com ([66.189.124.104]:57745
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933687AbYETPVz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 11:21:55 -0400
In-Reply-To: <20080520143954.15992.85900.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/rtmutex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 8ae9de3..b6ff1eb 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -738,7 +738,7 @@ static int adaptive_wait(struct rt_mutex_waiter *waiter,
 		}
 
 		/* Owner went to bed, so should we */
-		if (!task_is_current(orig_owner)) {
+		if (!orig_owner->oncpu) {
 			sleep = 1;
 			rcu_read_unlock();
 			break;

