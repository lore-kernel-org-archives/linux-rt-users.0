Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A61C388F7
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545912074F
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/pU7P2C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="feGpigVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgKIP7p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:59:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIP7o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 10:59:44 -0500
Date:   Mon, 9 Nov 2020 16:59:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604937583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aj0ns5W/he7xOoxv13aYmUJ+aPqtqgN0U6c1kq1hcfo=;
        b=R/pU7P2C4qc7xtXIkd3drEnWwH0vO70z8uGU8bZ5HZtTm2AMM2rjIShApNUWnUdyY7Zn8E
        M2AtB49eWK+p4g9Q7IASV7F/gtASdLTg8Y698gE1KP51i512031Llccor5AkAOrcyydfXM
        yQ/DpvL8rUYEFfCQD2VldbDCAy8ZVrBKBM3KXnAyOK/1rf/DwgVD3SKHg3/Nw7rTDeXsUw
        Bq7ukRzGjO6V0hr3cifAUSGNrKLW061IPUC1Uvi4qGE0iEh7A5bUttBekdR3Dvxq6cHu6J
        sHO/1s46IKLMey/pykhdBJIh8ZMt8MeOpNGtOmK3qwWTJpgOfd6k4VWkCuJu0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604937583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aj0ns5W/he7xOoxv13aYmUJ+aPqtqgN0U6c1kq1hcfo=;
        b=feGpigVAuY9keLNaMMTI0QYG6uTWpKXP8jq8Gp5x7bKshJ/vuiZ3MUeCNZRb7T7tSHV54z
        iRg+mRlOMBVkZmCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc3-rt6
Message-ID: <20201109155941.r7umomidvq7pgzsi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc3-rt6 patch set. 

Changes since v5.10-rc3-rt5:

  - The new migrate-disable didn't release a lock in an error path.
    Reported by Joe Korty.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc3-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc3-rt5-rt6.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc3-rt6

The RT patch against v5.10-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc3-rt6.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc3-rt6.tar.xz

Sebastian

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3fce6bbbeb5b7..1218f3ce1713a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2281,8 +2281,10 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	 *
 	 * Either way, we really should have a @pending here.
 	 */
-	if (WARN_ON_ONCE(!pending))
+	if (WARN_ON_ONCE(!pending)) {
+		task_rq_unlock(rq, p, rf);
 		return -EINVAL;
+	}
 
 	if (flags & SCA_MIGRATE_ENABLE) {
 
diff --git a/localversion-rt b/localversion-rt
index 0efe7ba1930e1..8fc605d806670 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
