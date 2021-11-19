Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AEC61260
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 10:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhKSKme (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhKSKmd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 05:42:33 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E0C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 02:39:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id q74so27121502ybq.11
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 02:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=DmESKrYOML6LtaLyzc/oH0iqVoxI37j1TTOxDS42klc=;
        b=gkDkKWjb/QolOB0l7J0zbbK+AaHpfqkdw3dNWAAzSpmUEwmiDPUmkCzFUzPHQtumeX
         EcXZAltvaKsTDKmrgrBW/W9RVF5Ffe/99JvqgOKYUUJZhALvTLKSh4i581hcs939+6lX
         oij+lkzfDVsvqLyKztFGssSelx0QgqmnD0neoDKRTDLbZ9oRXMOnT1Mpk+3WGPtUL3fD
         RBqIOJ3KBOFIbaIs76V4G+Qb4DvXniGfT+K+Fr4TemwZ9IN26aGFphjZ051whTpbjqur
         csBaKaacfM2Mlgl8Pac8euJLBC3qeTroLOryPrJ03ZKJiDjERkKRpOgpseKPjW+xMrFl
         AIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DmESKrYOML6LtaLyzc/oH0iqVoxI37j1TTOxDS42klc=;
        b=t7+ei4F2truXCZjv0iqezm7GuLz3U0KcOii59xOfas8UqzDBeduGv5g8C2Eq5LGfFY
         xbyr90SdNZtzOWCQmajje8URcOyQBPNOruRbt2ddoi8PKkUU2ATOOjKKyc2FQMD66Ewb
         4xgwXIDSh4UMuJzrENV+FdYWF3k4T4pelKTKAGnG4Sd1HYGGE/DFT6xtlhZ7X1K1edXs
         QqKyEgzTpykxLG24Otq9wrcFPyJtCjJ3kZV9wMaXXdHDSFXldXLUYBui2zxNM8ywaVj1
         xP4l9YewEPcEv2GAQJhgW9QokROaBL3SGt2UWJ2JEhlXX3kGCy9w0dkIdH1BGB5JrPHQ
         lXkA==
X-Gm-Message-State: AOAM531DzJVVOO9Eo3ApYWXutMf/RULFiBH/4FjnIkrsU0DU07AjEqQp
        bbF0a9IWJsIy7+XhPW3H+/7tx+yShWaTr/JWSyx3/lIB7l8=
X-Google-Smtp-Source: ABdhPJzqyrmb/XP4tPQ0+rkM0HteaOWwP3Ro4H2483ku0p6GtiBK1QHOMfrJU39tiXYUnh0Lukxzq7CKpZgfvph5qic=
X-Received: by 2002:a25:d386:: with SMTP id e128mr33571118ybf.176.1637318370926;
 Fri, 19 Nov 2021 02:39:30 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Glatz <andi.glatz@gmail.com>
Date:   Fri, 19 Nov 2021 10:39:20 +0000
Message-ID: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
Subject: Q: Possible reason(s) for BUG in rt_spin_lock_slowlock_locked()
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

I patched 4.19.100 with rt41 patch set and we ported the Micrel
ksz8462_h Ethernet driver. The driver has one threaded IRQ triggered
by the interrupt from the ksz8462 chip and two workers, one for
gathering MIBs and one for checking the link status. Everything
seemingly ran ok for quite some time. However, yesterday I noticed
that the IRQ thread died in rt_spin_lock_slowlock_locked() as per
stacktrace below at:

0xc0af82f8 is in rt_spin_lock_slowlock_locked
(/usr/src/kernel/kernel/locking/rtmutex.c:1105).
1100 * unconditionally. We might have to fix that up:
1101 */
1102 fixup_rt_mutex_waiters(lock);
1103
1104 BUG_ON(rt_mutex_has_waiters(lock) && waiter == rt_mutex_top_waiter(lock));
1105 BUG_ON(!RB_EMPTY_NODE(&waiter->tree_entry));
1106 }
1107
1108 static void noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
1109 {

In the jtag debugger I see that at the same time the other two
kthreads are waiting on the spinlock that's held by the IRQ thread
that died on two of the four CPU cores of the i.MX6q.

Any ideas what might cause this and how to fix it?

Many thanks and regards,

Andreas

--

[11041.177723] Internal error: Oops - undefined instruction: 0 [#1]
PREEMPT SMP ARM
[11041.177730] Modules linked in: ksz8462_h(O) iptable_nat nf_nat_ipv4
nf_nat xt_conntrack iptable_filter unix [last unloaded: ksz8462_h]
[11041.177760] CPU: 0 PID: 1457 Comm: irq/77-ksz8462_ Tainted: G
 W  O      4.19.100-rt41 #1
[11041.177763] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[11041.177783] PC is at rt_spin_lock_slowlock_locked+0x308/0x330
[11041.177789] LR is at 0xea60be01
[11041.177794] pc : [<c0af82f8>]    lr : [<ea60be01>]    psr: 60070093
[11041.177798] sp : ebe47df0  ip : eae8e9d4  fp : ebe47e24
[11041.177802] r10: a0070013  r9 : 00000000  r8 : ffffe000
[11041.177807] r7 : ebe47e28  r6 : ea60be00  r5 : a0070013  r4 : eae8e9c8
[11041.177811] r3 : ea60be00  r2 : 00000000  r1 : ea60be00  r0 : 00000000
[11041.177816] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[11041.177821] Control: 10c5387d  Table: 3af8c04a  DAC: 00000051
[11041.177830] Process irq/77-ksz8462_ (pid: 1457, stack limit = 0x968e9d88)
[11041.177835] Stack: (0xebe47df0 to 0xebe48000)
[11041.177843] 7de0:                                     eae8e9c8
a0070013 ebe47e28 eae8e9c8
[11041.177852] 7e00: a0070013 ebe47e28 eb51da64 ffffe000 00000000
00000001 ebe47e7c ebe47e28
[11041.177861] 7e20: c0af8384 c0af7ffc ebe47e28 000003ff ebe47e5c
ebe47e34 c0159b64 c01881ec
[11041.177869] 7e40: 00000000 eae8e9c8 00000001 c015b3cc ebe47e7c
ebe47e60 c015b3cc c110d988
[11041.177876] 7e60: ffffe000 ebe46000 eae8e9c8 00000000 ebe47e94
ebe47e80 c0afab28 c0af832c
[11041.177884] 7e80: ea366500 eb51da40 ebe47f0c ebe47e98 bf1c4418
c0afaab8 eae8e000 0000004d
[11041.177891] 7ea0: ea60be00 eb51da40 00000000 eb51da64 ebe47edc
ebe47ec0 eae8e000 eae8e100
[11041.177899] 7ec0: ea366500 eb51da40 00000000 c015b3cc ebe47efc
ebe47ee0 c015b3cc c0159a10
[11041.177907] 7ee0: ea366500 eb51da40 00000000 eb51da64 ebe47f0c
ebe47f00 c0132908 c015b390
[11041.177915] 7f00: ebe47f2c ebe47f10 c01933f0 bf1c43dc ea366500
eb51da40 00000000 eb51da64
[11041.177922] 7f20: ebe47f74 ebe47f30 c01937dc c01933cc ebe47f4c
c01933c0 c0afa890 00000000
[11041.177930] 7f40: c01935d0 c110d988 c01501dc 00000000 eb155b80
eb51df40 ebe46000 eb51da40
[11041.177939] 7f60: c01936b8 ebbc36e4 ebe47fac ebe47f78 c01508ac
c01936c4 eb155b9c eb155b9c
[11041.177946] 7f80: ebe47fac eb51df40 c0150758 00000000 00000000
00000000 00000000 00000000
[11041.177953] 7fa0: 00000000 ebe47fb0 c01010f0 c0150764 00000000
00000000 00000000 00000000
[11041.177960] 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[11041.177967] 7fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[11041.177985] [<c0af82f8>] (rt_spin_lock_slowlock_locked) from
[<c0af8384>] (rt_spin_lock_slowlock+0x64/0x94)
[11041.177996] [<c0af8384>] (rt_spin_lock_slowlock) from [<c0afab28>]
(rt_spin_lock+0x7c/0x84)
[11041.178087] [<c0afab28>] (rt_spin_lock) from [<bf1c4418>]
(ks_irq+0x48/0x540 [ksz8462_h])
[11041.178159] [<bf1c4418>] (ks_irq [ksz8462_h]) from [<c01933f0>]
(irq_forced_thread_fn+0x30/0xa8)
[11041.178173] [<c01933f0>] (irq_forced_thread_fn) from [<c01937dc>]
(irq_thread+0x124/0x224)
[11041.178187] [<c01937dc>] (irq_thread) from [<c01508ac>] (kthread+0x154/0x16c)
[11041.178199] [<c01508ac>] (kthread) from [<c01010f0>]
(ret_from_fork+0x14/0x24)
[11041.178203] Exception stack(0xebe47fb0 to 0xebe47ff8)
[11041.178209] 7fa0:                                     00000000
00000000 00000000 00000000
[11041.178216] 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[11041.178222] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[11041.178232] Code: e24bd028 e89daff0 ebdac992 eaffff8a (e7f001f2)
[11041.508511] ---[ end trace 0000000000000004 ]---
[11041.508565] note: irq/77-ksz8462_[1457] exited with preempt_count 1
