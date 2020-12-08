Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F9AC433FE
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0026023B54
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Dec 2020 23:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgLHX7N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:59:13 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53041 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgLHX7M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Dec 2020 18:59:12 -0500
X-Originating-IP: 193.27.14.10
Received: from orivej.orivej.org (unknown [193.27.14.10])
        (Authenticated sender: orivej@orivej.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 38A451C0003;
        Tue,  8 Dec 2020 23:58:28 +0000 (UTC)
Date:   Tue, 8 Dec 2020 23:58:27 +0000
From:   Orivej Desh <c@orivej.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201208212841.694b3022@orivej.orivej.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 3.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings!

(If you are receiving this again, that's because I'm sending from
another domain since my message from @gmx.fr was not forwarded to the
lists.)

With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [1]
linux-rt defines functions migrate_disable and migrate_enable.
They are used in linux headers in various macros and static inline
functions, and in particular in kmap_atomic and kunmap_atomic.
The latter are needed by ZFS which currently fails to build against
5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL.
Could you export them with EXPORT_SYMBOL instead?

I have checked that ZFS 2.0.0 builds and works with 5.9.1-rt20 (with
an additional fix [3]) with this patch:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1812 +1812 @@ void migrate_disable(void)
-EXPORT_SYMBOL_GPL(migrate_disable);
+EXPORT_SYMBOL(migrate_disable);
@@ -1843 +1843 @@ void migrate_enable(void)
-EXPORT_SYMBOL_GPL(migrate_enable);
+EXPORT_SYMBOL(migrate_enable);

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/patches/0009-sched-Add-migrate_disable.patch?h=v5.9-rc8-rt14-patches&id=9a89bfdb3bc77aecdd0ff8cc69b595541c7b50c4
[2] https://github.com/openzfs/zfs/issues/11097#issuecomment-740682245
[3] https://github.com/openzfs/zfs/pull/11309
