From: "Sunil Naidu" <akula2.shark@gmail.com>
Subject: Re: v2.6.20-rt1, yum/rpm
Date: Tue, 6 Feb 2007 16:00:57 +0530
Message-ID: <8355959a0702060230y2ca161f8seff65d2791d64c87@mail.gmail.com>
References: <20070205065636.GA1652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:23067 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbXBFKa7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Feb 2007 05:30:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1563791uga
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Feb 2007 02:30:57 -0800 (PST)
In-Reply-To: <20070205065636.GA1652@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2/5/07, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the v2.6.20-rt1 kernel, which can be downloaded from the

This is about 2.6.20-rt2, no issues here.

PID TTY      STAT   TIME COMMAND
    1 ?        Ss     0:00 init [5]
    2 ?        S      0:00 [migration/0]
    3 ?        S      0:00 [posix_cpu_timer]
    4 ?        S      0:00 [softirq-high/0]
    5 ?        S      0:00 [softirq-timer/0]
    6 ?        S      0:00 [softirq-net-tx/]
    7 ?        S      0:00 [softirq-net-rx/]
    8 ?        S      0:00 [softirq-block/0]
    9 ?        S      0:00 [softirq-tasklet]
   10 ?        S      0:00 [softirq-sched/0]
   11 ?        S      0:00 [softirq-hrtimer]
   12 ?        S      0:00 [softirq-rcu/0]
   13 ?        S<     0:00 [desched/0]
   14 ?        S      0:00 [migration/1]
   15 ?        S      0:00 [posix_cpu_timer]
   16 ?        S      0:00 [softirq-high/1]
   17 ?        S      0:00 [softirq-timer/1]
   18 ?        S      0:00 [softirq-net-tx/]
   19 ?        S      0:00 [softirq-net-rx/]
   20 ?        S      0:00 [softirq-block/1]
   21 ?        S      0:00 [softirq-tasklet]
   22 ?        S      0:00 [softirq-sched/1]
   23 ?        S      0:00 [softirq-hrtimer]
   24 ?        S      0:00 [softirq-rcu/1]
   25 ?        S<     0:00 [desched/1]
   26 ?        S<     0:00 [events/0]
   27 ?        S<     0:00 [events/1]
   28 ?        S<     0:00 [khelper]
   29 ?        S      0:00 [RCU Prio Booste]
   30 ?        S<     0:00 [kthread]
   63 ?        S<     0:00 [kblockd/0]
   64 ?        S<     0:00 [kblockd/1]
   65 ?        S<     0:00 [kacpid]
   66 ?        S<     0:00 [IRQ-9]
  157 ?        S<     0:00 [cqueue/0]
  158 ?        S<     0:00 [cqueue/1]
  159 ?        S<     0:00 [ksuspend_usbd]
  162 ?        S<     0:00 [khubd]
  164 ?        S<     0:00 [kseriod]
  189 ?        S      0:00 [pdflush]
  190 ?        S      0:00 [pdflush]
  191 ?        S<     0:00 [kswapd0]
  192 ?        S<     0:00 [flush_filesd/0]
  193 ?        S<     0:00 [flush_filesd/1]
  194 ?        S<     0:00 [aio/0]
  195 ?        S<     0:00 [aio/1]
  285 ?        S<     0:00 [IRQ-8]
  317 ?        S<     0:00 [IRQ-14]
  332 ?        S<     0:00 [IRQ-12]
  333 ?        S<     0:00 [IRQ-1]
  339 ?        S<     0:00 [kpsmoused]
  343 ?        S      0:00 [kirqd]
  351 ?        S<     0:00 [IRQ-20]
  352 ?        S<     0:00 [IRQ-19]
  353 ?        S<     0:00 [IRQ-18]
  354 ?        S<     0:00 [IRQ-16]
  376 ?        S<     0:00 [ata/0]
  377 ?        S<     0:00 [ata/1]
  378 ?        S<     0:00 [ata_aux]
  382 ?        S<     0:00 [scsi_eh_0]
  383 ?        S<     0:00 [scsi_eh_1]
  384 ?        S<     0:00 [kjournald]
  412 ?        S<     0:00 [kauditd]
  449 ?        S<s    0:00 /sbin/udevd -d
 1153 ?        S<     0:00 [hda_codec]
 1552 ?        S<     0:00 [kmpathd/0]
 1553 ?        S<     0:00 [kmpathd/1]
 1561 ?        S<     0:00 [kmirrord]
 1582 ?        S<     0:00 [kjournald]
................
.................
................

Wanted to ask, is there any (performance) problem with multi-sessions
(on the same box) with these kernels? I read some time back about Real
Time sound (exact terminology I don't remember), how to test this
using Intel hda? Any pointers?


Thanks,

Akula2
