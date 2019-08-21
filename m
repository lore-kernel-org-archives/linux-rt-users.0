Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C2AC3A59E
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5122D6D
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfHUJYS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:24:18 -0400
Received: from foss.arm.com ([217.140.110.172]:55060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfHUJYS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 05:24:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2858B1570;
        Wed, 21 Aug 2019 02:24:17 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22AC63F706;
        Wed, 21 Aug 2019 02:24:16 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        Julien Grall <julien.grall@arm.com>
Subject: [RT PATCH 2/3] hrtimer: Don't grab the expiry lock for non-soft hrtimer
Date:   Wed, 21 Aug 2019 10:24:08 +0100
Message-Id: <20190821092409.13225-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190821092409.13225-1-julien.grall@arm.com>
References: <20190821092409.13225-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There are no guarantee the hrtimer_cancel() will be called on the same
CPU as the non-soft hrtimer is running on so the following scenario
can happen.

CPU0                                         |  CPU1
                                             |
                                             | hrtimer_interrupt()
                                             |   raw_spin_lock_irqsave(&cpu_save->lock)
hrtimer_cancel()                             |      __run_hrtimer_run_queues()
  hrtimer_try_to_cancel()                    |      __run_hrtimer()
    lock_hrtimer_base()                      |        base->running = timer;
                                             |        raw_spin_unlock_irqrestore(&cpu_save->lock)
      raw_spin_lock_irqsave(cpu_base->lock)  |        fn(timer);
    hrtimer_callback_running()               |

hrtimer_callback_running() will be returning true as the callback is
running somewhere else. This means hrtimer_try_to_cancel() would return -1.
Therefore hrtimer_grab_expiry_lock() would be called.

non-soft hrtimer may be used when the timer needs to be manipulated from
a non-preemptible context. This is for instance the case of KVM Arm
timers. The following splat can be seen in the log:

[  157.449545] 000: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
[  157.449569] 000: in_atomic(): 1, irqs_disabled(): 0, pid: 990, name: kvm-vcpu-1
[  157.449579] 000: 2 locks held by kvm-vcpu-1/990:
[  157.449592] 000:  #0: 00000000c2fc8217 (&vcpu->mutex){+.+.}, at: kvm_vcpu_ioctl+0x70/0xae0
[  157.449638] 000:  #1: 0000000096863801 (&cpu_base->softirq_expiry_lock){+.+.}, at: hrtimer_grab_expiry_lock+0x24/0x40
[  157.449677] 000: Preemption disabled at:
[  157.449679] 000: [<ffff0000111a4538>] schedule+0x30/0xd8
[  157.449702] 000: CPU: 0 PID: 990 Comm: kvm-vcpu-1 Tainted: G        W 5.2.0-rt1-00001-gd368139e892f #104
[  157.449712] 000: Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
[  157.449718] 000: Call trace:
[  157.449722] 000:  dump_backtrace+0x0/0x130
[  157.449730] 000:  show_stack+0x14/0x20
[  157.449738] 000:  dump_stack+0xbc/0x104
[  157.449747] 000:  ___might_sleep+0x198/0x238
[  157.449756] 000:  rt_spin_lock+0x5c/0x70
[  157.449765] 000:  hrtimer_grab_expiry_lock+0x24/0x40
[  157.449773] 000:  hrtimer_cancel+0x1c/0x38
[  157.449780] 000:  kvm_timer_vcpu_load+0x78/0x3e0

An hrtimer is always either running in softirq or not. This cannot be
changed after it is instantiated. So we can rely on timer->is_soft
for checking whether the lock can be grabbed.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b869e816e96a..119414a2f59c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (base && base->cpu_base) {
+	if (timer->is_soft && base && base->cpu_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.11.0

