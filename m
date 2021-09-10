Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E18C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 20:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE72611F2
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhIJUWc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhIJUW1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 16:22:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02A636101A;
        Fri, 10 Sep 2021 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631305275;
        bh=HU4SPFJd6YbqdG5bV+eoahm8kyolTJUMByR509YWOZo=;
        h=Subject:From:To:Cc:Date:From;
        b=lUh/q4iGt6FChVdeOrV/wZeKctvcza4jxM7i8VCa45RGDsVtFjcvqNeJ6OLM65ut0
         0yT8FnNhgXR9LAwoiaU7UkH/WcbC6Sizhevkjb8ViPH0DOEJSL4+t9E8KsikUnUC0b
         Um0Et8kgO4WGb+vXtcp1ZGpJtU8srPZl2CprKStOxHsUlTBkQCvqZxTAxbJlsM0mHm
         64pdSsJKSszHUzcL9EmY+2GMaGyqVh/pq6p/StNb+ukbePXjQvurcTGJg42ei97sZu
         soXGedBmyTMCj/hB2m92lCF3a7uq+IyaoCV7ynACnVhYpiAyQErRlxNMXGuxjzr9VS
         S5jDQrDGM5NaQ==
Message-ID: <7e9645dfc7f53fed859c543d77e63a36db204b78.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.143-rt64
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Gregor Beck <gregor.beck@gmail.com>
Date:   Fri, 10 Sep 2021 15:21:13 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.143-rt64 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: f30e118c1cde0ba5319bd707b88bd9106284f6be

Or to build 5.4.143-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.143.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.143-rt64.patch.xz


You can also build from 5.4.143-rt63 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.143-rt63-rt64.patch.xz

Enjoy!

   Tom

Changes from v5.4.143-rt63:
---

Andrew Halaney (1):
      locking/rwsem-rt: Remove might_sleep() in __up_read()

Gregor Beck (1):
      fscache: fix initialisation of cookie hash table raw spinlocks

Tom Zanussi (1):
      Linux 5.4.143-rt64
---
fs/fscache/cookie.c       | 2 +-
 kernel/locking/rwsem-rt.c | 1 -
 localversion-rt           | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
---
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 5508d92e3f8f..cba2a226897f 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -963,6 +963,6 @@ void __init fscache_cookie_init(void)
 {
 	int i;
 
-	for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
+	for (i = 0; i < ARRAY_SIZE(fscache_cookie_hash); i++)
 		INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
 }
diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 19ea20be3fd7..966946454ced 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -200,7 +200,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
diff --git a/localversion-rt b/localversion-rt
index b0e8dd7bd707..10474042df49 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt63
+-rt64

