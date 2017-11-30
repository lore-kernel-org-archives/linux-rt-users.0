From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Warning: tree_plugin.h:310 rcu_note_context_switch
Date: Thu, 30 Nov 2017 17:23:42 +0100
Message-ID: <20171130162342.GF11362@linutronix.de>
References: <ec8b4367-ef5b-5446-2cd0-9f8f7fd6954f@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdK3QXo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 11:23:44 -0500
Content-Disposition: inline
In-Reply-To: <ec8b4367-ef5b-5446-2cd0-9f8f7fd6954f@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-29 17:29:59 [+0100], Daniel Wagner wrote:
> Hi,
Hi.

> I was playing with cyclictest and pi_stress on x86_64 with v4.14-rt1 and got 
> a greeting.
> 
> Unfortunately, I can't remember the exact the cyclictest arguments but it was either
> 
> "cyclictest -S -p 80" or "cyclictest -t -p 80"
> 
> [  142.205742] ------------[ cut here ]------------
> [  142.205754] WARNING: CPU: 0 PID: 1552 at /home/wagi/work/rt/linux-rt/kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x2c7/0x560
> [  142.205790] Call Trace:
> [  142.205798]  __schedule+0x72/0x550
> [  142.205803]  schedule+0x38/0xd0
> [  142.205807]  hrtimer_wait_for_timer+0x44/0x80
> [  142.205812]  ? wait_woken+0x80/0x80
> [  142.205816]  SyS_timer_delete+0xb1/0x160
> [  142.205821]  entry_SYSCALL_64_fastpath+0x13/0x94

This isn't "new". Paul added a warning recently to check if we schedule
out within a rcu_read() section. We do this here while waiting for the
timer to complete…

> Thanks,
> Daniel

Sebastian
