Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E4C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 18:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbhKXSGk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:06:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350232AbhKXSGh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487906101A;
        Wed, 24 Nov 2021 18:03:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcA-0027r1-Do;
        Wed, 24 Nov 2021 13:03:26 -0500
Message-ID: <20211124180326.265403840@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT 01/13] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

local_lock_t becoming a synonym of spinlock_t had consequences for the RT
mods to zsmalloc, which were taking a mutex while holding a local_lock,
inspiring a lockdep "BUG: Invalid wait context" gripe.

Converting zsmalloc_handle.lock to a spinlock_t restored lockdep silence.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/zsmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 277d426c881f..3595c1644135 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -82,7 +82,7 @@
 
 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };
 
 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -370,7 +370,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -930,7 +930,7 @@ static inline int testpin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -941,7 +941,7 @@ static inline int trypin_tag(unsigned long handle)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -952,7 +952,7 @@ static void pin_tag(unsigned long handle) __acquires(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -963,7 +963,7 @@ static void unpin_tag(unsigned long handle) __releases(bitlock)
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
-- 
2.33.0
