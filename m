Return-Path: <SRS0=Z0ea=U4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB0C5B579
	for <linux-rt-users@archiver.kernel.org>; Sat, 29 Jun 2019 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46069214DA
	for <linux-rt-users@archiver.kernel.org>; Sat, 29 Jun 2019 01:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF2BtH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 21:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfF2BtG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 21:49:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5B12083B;
        Sat, 29 Jun 2019 01:49:05 +0000 (UTC)
Date:   Fri, 28 Jun 2019 21:49:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190628214903.6f92a9ea@oasis.local.home>
In-Reply-To: <20190510103318.6cieoifz27eph4n5@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
        <20190510103318.6cieoifz27eph4n5@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 10 May 2019 12:33:18 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2019-05-09 14:33:20 [-0500], minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > The function call do_wait_for_common() has a race condition that
> > can result in lockups waiting for completions.  Adding the thread
> > to (and removing the thread from) the wait queue for the completion
> > is done outside the do loop in that function.  However, if the thread
> > is woken up, the swake_up_locked() function will delete the entry
> > from the wait queue.  If that happens and another thread sneaks
> > in and decrements the done count in the completion to zero, the
> > loop will go around again, but the thread will no longer be in the
> > wait queue, so there is no way to wake it up.  
> 
> applied, thank you.
> 

When I applied this patch to 4.19-rt, I get the following lock up:

watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [sh:745]
Modules linked in: floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea iosf_mbi i2c_algo_bit video
CPU: 2 PID: 745 Comm: sh Not tainted 4.19.56-test-rt23+ #16
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
RIP: 0010:_raw_spin_unlock_irq+0x17/0x4d
Code: 48 8b 12 0f ba e2 12 73 07 e8 f1 4a 92 ff 31 c0 5b 5d c3 66 66 66 66 90 55 48 89 e5 c6 07 00 e8 de 3d a3 ff fb bf 01 00 00 00 <e8> a7 27 9a ff 65 8b 05 c8 7f 93 7e 85 c0 74 1f a9 ff ff
 ff 7f 75
RSP: 0018:ffffc90000c8bbb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffffc90000c8bd58 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffffffff8108ffab RDI: 0000000000000001
RBP: ffffc90000c8bbb8 R08: ffffffff816dcd76 R09: 0000000000020600
R10: 0000000000000400 R11: 0000001c0eef1808 R12: ffffc90000c8bbc8
R13: ffffc90000f13ca0 R14: ffff888074b2d7d8 R15: ffff8880789efe10
FS:  0000000000000000(0000) GS:ffff88807b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000030662001b8 CR3: 00000000376ac000 CR4: 00000000000006e0
Call Trace:
 swake_up_all+0xa6/0xde
 __d_lookup_done+0x7c/0xc7
 __d_add+0x44/0xf7
 d_splice_alias+0x208/0x218
 ext4_lookup+0x1a6/0x1c5
 path_openat+0x63a/0xb15
 ? preempt_latency_stop+0x25/0x27
 do_filp_open+0x51/0xae
 ? trace_preempt_on+0xde/0xe7
 ? rt_spin_unlock+0x13/0x24
 ? __alloc_fd+0x145/0x155
 do_sys_open+0x81/0x125
 __x64_sys_open+0x21/0x23
 do_syscall_64+0x5c/0x6e
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

I haven't really looked too much into it though. I ran out of time :-/

-- Steve
