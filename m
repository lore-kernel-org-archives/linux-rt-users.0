From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/5] sched: make double-lock-balance fair
Date: Mon, 25 Aug 2008 16:15:34 -0400
Message-ID: <20080825201534.23217.14936.stgit@dev.haskins.net>
References: <20080825200852.23217.13842.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: srostedt@redhat.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	npiggin@suse.de, gregory.haskins@gmail.com
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-108-43.dhcp.oxfr.ma.charter.com ([75.130.108.43]:36243
	"EHLO dev.haskins.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754060AbYHYURv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Aug 2008 16:17:51 -0400
In-Reply-To: <20080825200852.23217.13842.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

double_lock balance() currently favors logically lower cpus since they
often do not have to release their own lock to acquire a second lock.
The result is that logically higher cpus can get starved when there is
a lot of pressure on the RQs.  This can result in higher latencies on
higher cpu-ids.

This patch makes the algorithm more fair by forcing all paths to have
to release both locks before acquiring them again.  Since callsites to
double_lock_balance already consider it a potential preemption/reschedule
point, they have the proper logic to recheck for atomicity violations.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 6e0bde6..b7326cd 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2790,23 +2790,16 @@ static int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	int ret = 0;
