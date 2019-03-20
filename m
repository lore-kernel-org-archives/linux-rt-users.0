Return-Path: <SRS0=B6j+=RX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B96C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Mar 2019 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B62821873
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Mar 2019 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfCTRPP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:15:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCTRPP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 Mar 2019 13:15:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6eo4-0004oK-5u; Wed, 20 Mar 2019 18:15:12 +0100
Date:   Wed, 20 Mar 2019 18:15:12 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.0.3-rt1
Message-ID: <20190320171511.icjhdlulgal2yeho@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.0.3-rt1 patch set. 

Changes since v4.19.25-rt16:

  - rebase to v5.0

  - Several ARM architectures have a so called "boot_lock" in their SMP
    bring up code. In previous releases the boot_lock was converted to
    to a raw_spinlock in order to get in working on -RT. As of v5.0 only the
    bits for the `versatile' platform have been applied upstream and I
    dropped the patch entirely.
    The other platforms were rejected because they were doing it wrong by
    using such a lock. The omap2 and sti platform were converted to other
    mechanism as part of the discussion. Others (like i.MX) were never
    using such a lock.
    There are still a few platforms using such a lock. If you are
    affected you would to convince the platform maintainer to remove the
    lock from the SMP code.

  - Applied John Ogness' prinkt rework. One visible change is the
    output during boot. Under the hood and for RT: By default, output
    that is created at KERN_WARN[0] or higher is printed immediately if the
    console supports "atomic" print (currently the 8250 driver does).
    This output is printed immediately (and visible) even from IRQ-off
    or preempt-disabled regions which wasn't the case earlier. This will
    raise the latency at run-time *but* there should be no WARNING,
    ERROR or PANIC messages at run-time on a fully working system.
    Messages with lower severity are printed "later" by a kthread.

    [0] default message level, default_message_loglevel, second field in
	/proc/sys/kernel/printk

  - Applied "restore FPU on return to userland" series. This only
    applies to x86. This change makes repeated kernel_fpu_begin() +
    kernel_fpu_end() cheap.

  - I tried to include some BH related rework but it is not yet in
    reasonable shape. I will probably revisit this during the v5.0
    cycle.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.3-rt1

The RT patch against v5.0.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.3-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.3-rt1.tar.xz

Sebastian
