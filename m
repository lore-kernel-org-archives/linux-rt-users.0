From: linuxball <linuxball@gmail.com>
Subject: [PATCH 1/1] 3.18.17-rt14 locktorture: Do NOT include rwlock.h directly
Date: Mon, 20 Jul 2015 11:33:12 +0200
Message-ID: <55ACC058.2040407@gmail.com>
References: <20150702152543.61bbb6eb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:34389 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbGTJdQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 05:33:16 -0400
Received: by wibuw6 with SMTP id uw6so3881934wib.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2015 02:33:15 -0700 (PDT)
In-Reply-To: <20150702152543.61bbb6eb@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Including rwlock.h directly will cause kernel builds to fail
if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
is included by locktorture.c anyway.
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


On 02.07.2015 21:25, Steven Rostedt wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.18.17-rt14 stable release.
>
>
> This release is just an update to the new stable 3.18.17 version
> and no RT specific changes have been made.
>
>
> You can get this release via the git tree at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>    branch: v3.18-rt
>    Head SHA1: bba903c2bb20dbb6c57a8ba3889f9b8f09dcc6e0
>
>
> Or to build 3.18.17-rt14 directly, the following patches should be applied:
>
>    http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz
>
>    http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.17.xz
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.17-rt14.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

