From: Julia Cartwright <julia@ni.com>
Subject: Re: Kdump not working with rt patch, tested under
 4.4.32/4.4.79/4.9.40
Date: Wed, 9 Aug 2017 10:35:24 -0500
Message-ID: <20170809153524.GY8384@jcartwri.amer.corp.natinst.com>
References: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-rt-users@vger.kernel.org>
To: Journey Journey <journeywang123@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36672 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752608AbdHIPf1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2017 11:35:27 -0400
Content-Disposition: inline
In-Reply-To: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 09, 2017 at 05:05:42PM +0800, Journey Journey wrote:
> Test case: https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c
>

Please in the future provide more information as to what you are trying
to do, what it is you are trying, what you are seeing, and why you think
it's wrong.

Because otherwise, we're forced to reverse engineer your intent. :(

I'm _guessing_ that what you meant to say was:

   I have a testcase module that I use that attempts to trigger the
   kernels softlockup detection.  Here is a link:

      https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c

   I'm expecting it to fire the softlockup detector and panic the system
   (I use CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC in my test rig), however,
   when I load this module on an RT system, it doesn't appear to trigger
   the softlockup detector![1]

   What could be wrong?

If that's what you meant, then the answer is:

The way that you are "hogging" the CPU, on PREEMPT_RT, doesn't prevent
the kernel from scheduling other tasks in and out (including the
watchdog thread which pets the watchdog!).

Your test case, effectively is:

    spin_lock(&lock)
    while (1)
       printk("...");
    spin_unlock(&lock)

On RT, spin-lock protected regions are preemptible.  When the watchdog
hrtimer fires and wakes up the softlockup thread, that thread preempts
the thread stuck in this region and touches the watchdog.  This prevents
the watchdog threshold from being reached.

The good news for you is that it should be entirely possible for you to
trigger the softlockup detector on RT entirely in usermode.  All you'd
need to do is disable RT throttling, and set a thread SCHED_FIFO w/ prio
99 spinning.

   Julia

1: Note: this has nothing to do with Kdump whatsoever.
