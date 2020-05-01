Return-Path: <SRS0=ptk9=6P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B5C35280
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 May 2020 20:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3656D21775
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 May 2020 20:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588364628;
	bh=/dHFbz4XUvc7T+sHCzu8/JNWek84PAQ8FrCpPRTN8Ks=;
	h=Subject:From:To:Date:List-ID:From;
	b=xuydHCwMDNdnn3XVh1v/R/CiZI7FIJ8BZkbv9OEnQovM83wL8G3uuCDB3WqpC8q6d
	 U/Y3rKEqaP5qTnGAVyRQIrLABkydUzhSstIVIc6u84lLEvt3fXET40kYtM4an6C5Na
	 sV98Co5zEpQfkRs3r0jKpX1dZGQsKstHoaksMt0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgEAUXo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 May 2020 16:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgEAUXo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 May 2020 16:23:44 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077792137B;
        Fri,  1 May 2020 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588364624;
        bh=/dHFbz4XUvc7T+sHCzu8/JNWek84PAQ8FrCpPRTN8Ks=;
        h=Subject:From:To:Date:From;
        b=wVaTe+X4L+5n/7FJuwiJ+NelsdNp44UY//3GK3lqHL0w557KoTZ0uI0oYtWxePlSa
         geyHPS4JeAJIZ1WwO93PqoqNzPCwkQNbmLbWKxBrR7pRtNYf/ID9tV+2KAQ/y3cGfl
         73dapyqcYqUTYLAbRJHp4Q3ZoNsQshKIa3MT8VA4=
Message-ID: <ddccef996326de46d1e17ef162ec3da1b296a283.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.115-rt50
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
        Tom Zanussi <zanussi@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Fri, 01 May 2020 15:23:40 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.115-rt50 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: c117d44bd1278104a9783d8431b96b48515b5f47

Or to build 4.19.115-rt50 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.115-rt50.patch.xz

You can also build from 4.19.115-rt49 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.115-rt49-rt50.patch.xz

Enjoy!

   Tom

Changes from v4.19.115-rt49:
---

Rasmus Villemoes (1):
      hrtimer: fix logic for when grabbing softirq_expiry_lock can be elided

Tom Zanussi (1):
      Linux 4.19.115-rt50
---
kernel/time/hrtimer.c | 2 +-
 localversion-rt       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e54a95de8b79..c3966c090246 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && is_migration_base(base)) {
+	if (timer->is_soft && !is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
diff --git a/localversion-rt b/localversion-rt
index 4b7dca68a5b4..42c384668389 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt49
+-rt50

