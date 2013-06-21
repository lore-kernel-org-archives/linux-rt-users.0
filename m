From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] list_bl.h: make list head locking RT safe
Date: Fri, 21 Jun 2013 14:23:05 +0200
Message-ID: <20130621122305.GC21228@linutronix.de>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
 <1370900209-40769-2-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rostedt@goodmis.org, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38855 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161045Ab3FUMXO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 08:23:14 -0400
Content-Disposition: inline
In-Reply-To: <1370900209-40769-2-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-06-10 17:36:48 [-0400]:

>--- a/include/linux/list_bl.h
>+++ b/include/linux/list_bl.h
>@@ -17,7 +18,7 @@
>  * some fast and compact auxiliary data.
>  */
> 
>-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)
> #define LIST_BL_LOCKMASK	1UL
> #else
> #define LIST_BL_LOCKMASK	0UL

On RT we don't have the lock mask anymore and those LIST_BL_BUG_ON()
check don't do anything. It would be nice if you could check if the lock
in that given entry is taken or not.

All in all it looks good.

Sebastian
