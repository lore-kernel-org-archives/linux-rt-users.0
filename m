From: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Mon, 5 Feb 2007 14:47:08 +0100
Message-ID: <20070205134708.GA6318@elte.hu>
References: <20070205065636.GA1652@elte.hu> <6bffcb0e0702050459y692359ai67cbd4f93e11d06e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47431 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbXBENtI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Feb 2007 08:49:08 -0500
Content-Disposition: inline
In-Reply-To: <6bffcb0e0702050459y692359ai67cbd4f93e11d06e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> It looks like a bug to me
> 
> BUG: MAX_LOCKDEP_ENTRIES too low!
> turning off the locking correctness validator.

hm, the patch below should solve this.

	Ingo

Index: linux/kernel/lockdep_internals.h
===================================================================
--- linux.orig/kernel/lockdep_internals.h
+++ linux/kernel/lockdep_internals.h
@@ -15,7 +15,7 @@
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
-#define MAX_LOCKDEP_ENTRIES	8192UL
+#define MAX_LOCKDEP_ENTRIES	16384UL
 
 #define MAX_LOCKDEP_KEYS_BITS	11
 #define MAX_LOCKDEP_KEYS	(1UL << MAX_LOCKDEP_KEYS_BITS)
