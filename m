Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5999C433ED
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Apr 2021 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ACC61248
	for <linux-rt-users@archiver.kernel.org>; Sat, 17 Apr 2021 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhDQTqX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 17 Apr 2021 15:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236779AbhDQTqX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Apr 2021 15:46:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A11E361210;
        Sat, 17 Apr 2021 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618688756;
        bh=a0o+xI/jt5YUa2zOA+NrJflltYG75aeI9ZlL2cFwZNU=;
        h=Subject:From:To:Date:From;
        b=IF6gvn27iVvCUbw6bRLzmIghat5nDcV9s5uK/Xw+bcX1/dnWsWvmb8eT1bfzwtVCq
         hewc/i55cZoOKK41/ze4dlRS9wGKG4vwQA1Z8wRrArhZr0xDcSKe6EjdCpriS3UGMA
         a0jqlkDxQvKy1kU+byQqcjg7nbLNWWd2jCyUV5G+sa3AGfHGn3gb0wq9a37iBmJu08
         sD6dMaXXcQkA7N6AhA4RTNrMm3AfCPXZ8B1Bcne5vmt9isC+XTrlkY27tGa0FLPnp8
         L6pK4EfXCxRNJMzmeXp31Z70Q1oolGDLWn/2Dx33ZP1c0DiQf7VT4aKkBPVv6XltI7
         FUt94gZMqJ1aA==
Message-ID: <86fbaceba90bb03ac58b4c7656d6dc09d4867909.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.109-rt56
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
Date:   Sat, 17 Apr 2021 14:45:54 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.109-rt56 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: a84a83ce44cafc96cb9cf419378a713dcdea00ac

Or to build 5.4.109-rt56 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.109.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.109-rt56.patch.xz


You can also build from 5.4.109-rt55 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.109-rt55-rt56.patch.xz

Enjoy!

   Tom

Changes from v5.4.109-rt55:
---

Sebastian Andrzej Siewior (1):
      mm: slub: Don't resize the location tracking cache on PREEMPT_RT

Tom Zanussi (1):
      Linux 5.4.109-rt56
---
localversion-rt | 2 +-
 mm/slub.c       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 51b05e9abe6f..fdb0f880c7e9 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt55
+-rt56
diff --git a/mm/slub.c b/mm/slub.c
index 1815e28852fe..0d78368d149a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4647,6 +4647,9 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
 	struct location *l;
 	int order;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && flags == GFP_ATOMIC)
+		return 0;
+
 	order = get_order(sizeof(struct location) * max);
 
 	l = (void *)__get_free_pages(flags, order);

