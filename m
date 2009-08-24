From: Meha Mehta <mehtameha@gmail.com>
Subject: mod_timer() with interrupt disabled (RT patch)
Date: Mon, 24 Aug 2009 13:12:55 -0400
Message-ID: <af81d2bf0908241012j41144f9i3b10e9f466fdafa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f183.google.com ([209.85.211.183]:50098 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbZHXRMy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Aug 2009 13:12:54 -0400
Received: by ywh13 with SMTP id 13so2938378ywh.15
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2009 10:12:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am doing few modification in kernel with RT patch enabled. I am
calling mod_timer  with interrupt disabled ( I can not avoid this with
my code design).  mod_timer() has rt_spin_lock (mutex that block) for
locking timer base. So I am getting kernel following bug

BUG: sleeping function called from invalid context at
kernel/rtmutex.c:685 in_atomic(): 1, irqs_disabled(): 1


My question is it alright to convert timer lock type into
raw_spinlock_t from spinlock_t? I tried to do it and solves problem
with mod_timer() bug. But it run into another bug listed as follows.


BUG: sleeping function called from invalid context at kernel/rtmutex.c:685
in_atomic(): 1, irqs_disabled(): 1, pid: 5, name: sirq-timer/0
Pid: 5, comm: sirq-timer/0 Not tainted 2.6.29.6-rt23 #92
Call Trace:
 [<ffffffff804d4502>] ? rt_spin_lock+0x27/0x66
 [<ffffffff8023ad76>] ? __wake_up+0x1c/0x42
 [<ffffffff802471a4>] ? run_timer_softirq+0x23f/0x252
 [<ffffffff802435b0>] ? ksoftirqd+0x14b/0x241
 [<ffffffff80243465>] ? ksoftirqd+0x0/0x241
 [<ffffffff80243465>] ? ksoftirqd+0x0/0x241
 [<ffffffff80250fb9>] ? kthread+0x47/0x76
 [<ffffffff8023910c>] ? schedule_tail+0x3f/0xab
 [<ffffffff8020caca>] ? child_rip+0xa/0x20
 [<ffffffff80250f72>] ? kthread+0x0/0x76
 [<ffffffff8020cac0>] ? child_rip+0x0/0x20

I think solving problem with raw_spinlock_t will not work. Are there
any other suggestions so that I can call mod_timer routine with
interrupt disabled?

Thank you in advance.

Thanks,
Meha
