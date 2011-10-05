From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [ANNOUNCE] 3.0.6-rt16
Date: Tue, 4 Oct 2011 19:44:38 -0700
Message-ID: <4E8BC496.3040605@am.sony.com>
References: <alpine.LFD.2.02.1110042139350.18778@ionos>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:51829
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757450Ab1JECqU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 22:46:20 -0400
In-Reply-To: <alpine.LFD.2.02.1110042139350.18778@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/11 13:19, Thomas Gleixner wrote:
> Dear RT Folks,
> 
> I'm pleased to announce the 3.0.6-rt16 release.


Fix compile error for non-SMP.

Can be folded into rt-sched-postpone-actual-migration-disalbe-to-schedule.patch

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 kernel/sched.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/kernel/sched.c
===================================================================
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4207,7 +4207,7 @@ static inline void schedule_debug(struct
 	schedstat_inc(this_rq(), sched_count);
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_SMP)
 #define MIGRATE_DISABLE_SET_AFFIN	(1<<30) /* Can't make a negative */
 #define migrate_disabled_updated(p)	((p)->migrate_disable & MIGRATE_DISABLE_SET_AFFIN)
 #define migrate_disable_count(p)	((p)->migrate_disable & ~MIGRATE_DISABLE_SET_AFFIN)

