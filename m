From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Compile warning rtmutex code on 2.6.24.7-rt8 (CC:LKML added)
Date: Tue, 20 May 2008 17:20:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0805201718530.21440@gandalf.stny.rr.com>
References: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:39041 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759997AbYETVUV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2008 17:20:21 -0400
In-Reply-To: <3efb10970805201356x4552859bof5f3f4f56f2ba676@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 20 May 2008, Remy Bohmer wrote:

> Hello Steven,
>
>  Do you recognise these warnings? I do not know (yet) if these are ARM
>  specific...
>
>   CC      kernel/rtmutex.o
>  kernel/rtmutex.c: In function 'rt_write_fastlock':
>  kernel/rtmutex.c:1582: warning: initialization makes pointer from
>  integer without a cast
>  kernel/rtmutex.c: In function 'rt_write_fasttrylock':
>  kernel/rtmutex.c:1622: warning: initialization makes pointer from
>  integer without a cast
>
>  If so, do you have a fix for it?

Remy,

Can you see if this helps,

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

---
 kernel/rtmutex.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.24.7-rt9/kernel/rtmutex.c
===================================================================
--- linux-2.6.24.7-rt9.orig/kernel/rtmutex.c	2008-05-20 17:11:29.000000000 -0400
+++ linux-2.6.24.7-rt9/kernel/rtmutex.c	2008-05-20 17:13:18.000000000 -0400
@@ -1577,7 +1577,7 @@ rt_write_fastlock(struct rw_mutex *rwm,
 		  void fastcall (*slowfn)(struct rw_mutex *rwm, int mtx),
 		  int mtx)
 {
-	unsigned long val = (unsigned long)current | RT_RWLOCK_WRITER;
+	struct task_struct *val = (void *)((unsigned long)current | RT_RWLOCK_WRITER);

 	if (likely(rt_rwlock_cmpxchg(rwm, NULL, val)))
 		rt_mutex_deadlock_account_lock(&rwm->mutex, current);
@@ -1617,7 +1617,7 @@ static inline int
 rt_write_fasttrylock(struct rw_mutex *rwm,
 		     int fastcall (*slowfn)(struct rw_mutex *rwm, int mtx), int mtx)
 {
-	unsigned long val = (unsigned long)current | RT_RWLOCK_WRITER;
+	struct task_struct *val = (void *)((unsigned long)current | RT_RWLOCK_WRITER);

 	if (likely(rt_rwlock_cmpxchg(rwm, NULL, val))) {
 		rt_mutex_deadlock_account_lock(&rwm->mutex, current);
@@ -1902,7 +1902,7 @@ rt_write_fastunlock(struct rw_mutex *rwm
 					    int mtx),
 		    int mtx)
 {
-	unsigned long val = (unsigned long)current | RT_RWLOCK_WRITER;
+	struct task_struct *val = (void *)((unsigned long)current | RT_RWLOCK_WRITER);

 	WARN_ON(rt_rwlock_owner(rwm) != current);
 	if (likely(rt_rwlock_cmpxchg(rwm, (struct task_struct *)val, NULL)))
