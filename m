From: linuxball <linuxball@gmail.com>
Subject: Re: [PATCH 1/1] 3.18.17-rt14 locktorture: Do NOT include rwlock.h
 directly
Date: Tue, 21 Jul 2015 16:20:07 +0200
Message-ID: <55AE5517.9040403@gmail.com>
References: <20150702152543.61bbb6eb@gandalf.local.home> <55ACC058.2040407@gmail.com> <20150720154753.GC9559@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33034 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbbGUOUM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Jul 2015 10:20:12 -0400
Received: by wicmv11 with SMTP id mv11so43088969wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2015 07:20:11 -0700 (PDT)
In-Reply-To: <20150720154753.GC9559@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Including rwlock.h directly will cause kernel builds to fail
if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
is included by locktorture.c anyway.

Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
---
  kernel/locking/locktorture.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ec8cce2..aa60d91 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -24,7 +24,6 @@
  #include <linux/module.h>
  #include <linux/kthread.h>
  #include <linux/spinlock.h>
-#include <linux/rwlock.h>
  #include <linux/mutex.h>
  #include <linux/rwsem.h>
  #include <linux/smp.h>
-- 
1.9.1

On 20.07.2015 17:47, Sebastian Andrzej Siewior wrote:
> * linuxball | 2015-07-20 11:33:12 [+0200]:
>
>> Including rwlock.h directly will cause kernel builds to fail
>> if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
>> (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
>> is included by locktorture.c anyway.
> Documentation/SubmittingPatches:
>      11) Sign your work
>
> Sebastian

