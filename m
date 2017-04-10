From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Kernel ISR Latency
Date: Mon, 10 Apr 2017 15:12:28 -0400
Message-ID: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33873 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdDJTM3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Apr 2017 15:12:29 -0400
Received: by mail-io0-f173.google.com with SMTP id a103so44028033ioj.1
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Apr 2017 12:12:29 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, I'm trying to track down the source of some ISR latency that I'm
observing on a logic analyzer.

Just for some background, my setup is the following.  I'm running
Linaro 4.4.9 with PREEMPT RT Patch 17 on a Variscite SD410 SOM devkit.
My kernel has the following PREEMPT RT options.

CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT__LL is not set
# CONFIG_PREEMPT_RTB is not set
CONFIG_PREEMPT_RT_FULL=y
CONFIG_PREEMPT_COUNT=y
# CONFIG_DEBUG_PREEMPT is not set

I have a micro-controller attached to a GPIO pin and two separate SPI
ports.  Every 10 milliseconds the micro-controller writes 18 Kbytes of
data to each of 2 SPI ports (total of 36 Kbytes between the two) and
issues an interrupt on the GPIO.  A kernel module has an ISR
registered to the GPIO pin.  When the ISR executes, it copies 18
Kbytes of data from each SPI.  There are two RT threads executing in
user space as SCHED_RR with identical priorities less than (i.e. lower
than) 50, where as I understand the kernel runs at priority 50.  Each
of those user space threads copies data from some shared memory within
the kernel module and performs some basic data integrity checks, i.e.
a SHA1.  A third thread runs non-RT.  It doesn't do anything other
than spawn the two user space RT threads and waits for them to
complete.

The vast majority of interrupts incur a delay in range of tens of
MICROseconds, meaning the ISR executes within such amount of time of
the micro-controller raising the GPIO pin of the ISR.  However,
occasionally, more than six MILLIseconds passes between the time of
the micro-controller issuing the GPIO interrupt and the ISR beginning
to execute.

I'm trying to track down the cause of the 6+ MILLIsecond latency,
which I would not expect to happen.  Are there any well practiced
techniques for determining what factor(s) may be introducing this
latency?  I looked at the description for RT Watchdog, but I don't
think it would help me much because the only two RT threads other than
the kernel have a lower priority.

Thanks for any guidance.
