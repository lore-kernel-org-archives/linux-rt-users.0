Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:38439 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLAEGY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:24 -0500
Date: Fri, 30 Nov 2018 17:56:27 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: complete_all() with 5 waiters in swake_up_all_locked
Message-ID: <20181130165626.h7fzrvkxtcqjgnx4@linutronix.de>
References: <CAGZ+4_+DRKxKWC4zMu_xTUoy6ogPpjwVOVtXyAmbj4XXAnpUXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAGZ+4_+DRKxKWC4zMu_xTUoy6ogPpjwVOVtXyAmbj4XXAnpUXw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Philipp K <philipp97kl@gmail.com>
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de

On 2018-10-10 11:15:46 [+0200], Philipp K wrote:
> Hi,
Hi,

sorry for being late.

> I've been fuzzing linux-rt with syzkaller and found a way to trigger
> $title warning.
> 
> The reproducer works with a defconfig + CONFIG_NET_KEY=y on 4.18.12-rt6 kernel.

I didn't manage to reproduce this on v4.19-RT. Also that backtrace is
from v4.9. With that test case I didn't manage to end up in
cryptomgr_probe() which would be a requirement.

So. The warning says that the system managed to wake up 5 tasks in one
go, that is without re-enabling the interrupts. It has been agreed that
two wakes are okay and more should be avoided. The problem is that it
may cause latency spikes if for some reason the system wakes say 100
tasks like that.
We have one exception for the PM case because nobody does (or should do)
suspend-to-ram and run a RT task which has to meet a deadline.

So for this case, we should figure out why it managed to wake 5 tasks
and how bad can it get and can we limit it somehow.

> Philipp
> 
> PS: Liebe Grüße von Lukas Bulwahn
Ah. Greetings!

Sebastian
