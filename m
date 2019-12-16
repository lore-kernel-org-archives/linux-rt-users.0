Return-Path: <SRS0=nOM3=2G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3BC43603
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64D206E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfLPPVo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:21:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfLPPVn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Dec 2019 10:21:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1igsBo-0003JH-Qr; Mon, 16 Dec 2019 16:21:40 +0100
Date:   Mon, 16 Dec 2019 16:21:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] lib: Check for migrate_disable only on SMP systems
Message-ID: <20191216152140.bjaohifj43gn22sz@linutronix.de>
References: <20191206142103.29647-1-dwagner@suse.de>
 <4513f4a584586a4c17ef14f7365f6275042c3071.camel@redhat.com>
 <20191206193954.yi5hac366agt7k3o@beryllium.lan>
 <3ce4699f987e784e84b2030aa3a1c529b274b498.camel@redhat.com>
 <20191209100447.codml4nop4ibbjkz@beryllium.lan>
 <1db9c7c960570e975ac0d684d6313ca35a3b1450.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1db9c7c960570e975ac0d684d6313ca35a3b1450.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-09 18:40:37 [-0600], Scott Wood wrote:
> Actually it looks like we're saved from the false positives by the
> following check for nr_cpus_allowed == 1, which should always be true on
> UP.

we currently don't.

> If we want this check to be effective on UP we'd need some way to keep
> track of whether a thread is forced by the kernel to be bound to one CPU,
> rather than whether it just happens to have only one CPU in the mask. 
> Barring that, we should just stub out check_preemption_disabled() as a
> whole on UP.
> 
> > I didn't realize that smp_processor_id.c is only build with
> > CONFIG_DEBUG_PREEMPT. It should be enough to add
> > 
> > 	#if defined(CONFIG_SCHED_DEBUG)
> > 
> > Did I get it finally correct? :)
> 
> No, then we *would* get those false positives on SMP without
> CONFIG_SCHED_DEBUG, and it wouldn't build without CONFIG_PREEMPT_RT_BASE.

this should be enough -> 

From: Daniel Wagner <dwagner@suse.de>
Date: Mon, 16 Dec 2019 16:15:57 +0100
Subject: [PATCH] lib/smp_processor_id: Adjust check_preemption_disabled()

The current->migrate_disable counter is not always defined leading to
build failures with DEBUG_PREEMPT && !PREEMPT_RT_BASE.

Restrict the access to ->migrate_disable to same set where
->migrate_disable is modified.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[bigeasy: adjust condition + description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/smp_processor_id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 5f2618d346c42..c2f5b0f8cacd0 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,8 +23,10 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+#if defined(CONFIG_PREEMPT_RT_BASE) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
 	if (current->migrate_disable)
 		goto out;
+#endif
 
 	if (current->nr_cpus_allowed == 1)
 		goto out;
-- 
2.24.0
