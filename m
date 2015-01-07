From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: RT is freezing
Date: Wed, 7 Jan 2015 11:24:23 +0100
Message-ID: <20150107112423.228e67f3@balder.valhalla.alchemy.lu>
References: <54AB147E.9060209@gmail.com>
	<54AB39D2.2090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [94.247.172.109] ([94.247.172.109]:33834 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbbAGKlD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jan 2015 05:41:03 -0500
Received: from skinbark.wpsintrax.se (unknown [83.145.49.220])
	by mailsafe.webbplatsen.se (Halon Mail Gateway) with ESMTP
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2015 11:24:25 +0100 (CET)
Received: from skinbark.wpsintrax.se (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id 7F8C4BC8201
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2015 11:24:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by skinbark.wpsintrax.se (Postfix) with ESMTP id 6BA71BC82EB
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2015 11:24:25 +0100 (CET)
Received: from skinbark.wpsintrax.se ([127.0.0.1])
	by localhost (skinbark.wpsintrax.se [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id put2RpHeiDeL for <linux-rt-users@vger.kernel.org>;
	Wed,  7 Jan 2015 11:24:25 +0100 (CET)
Received: from balder.valhalla.alchemy.lu (81.58-247-81.adsl-dyn.isp.belgacom.be [81.247.58.81])
	by skinbark.wpsintrax.se (Postfix) with ESMTPA id 024A2BC8201
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2015 11:24:24 +0100 (CET)
In-Reply-To: <54AB39D2.2090203@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 05 Jan 2015 23:26:42 -0200
Gustavo Bittencourt <gbitten@gmail.com> wrote:

> It seems that the problem is with the nouveau driver. When I boot in 
> failsafe graphic mode,  the system works well. Here is my video 
> configuration:
> $ lshw -c video
>    *-display
>         description: VGA compatible controller
>         product: GF108M [GeForce GT 540M]
>         vendor: NVIDIA Corporation
>         physical id: 0
>         bus info: pci@0000:01:00.0
>         version: a1
>         width: 64 bits
>         clock: 33MHz
>         capabilities: pm msi pciexpress vga_controller bus_master 
> cap_list rom
>         configuration: driver=nouveau latency=0
>         resources: irq:53 memory:f4000000-f4ffffff 
> memory:d0000000-dfffffff memory:e0000000-e1ffffff
> ioport:d000(size=128) memory:f5000000-f507ffff
> 
> 
> On 01/05/2015 08:47 PM, Gustavo Bittencourt wrote:  
> > Hi everybody
> >
> > I compiled the 3.14.25-rt22, but my system freezes when I start
> > Unity and some programs like Chrome or Thunderbird. The problem
> > happens only when PREEMPT_RT_FULL=y. No log is generated. I would
> > like to find the root of this problem, but I don't know how. Do you
> > have any suggestion?

I don't know if this is related, and I'm sorry for mentioning nvidia on
the mailinglist, but if it applies to nouveau too, I hope it's
alright :)

I have the same experience using the nvidia driver on a test system.
This patch was brought to my attention and I use it for Archlinux'
realtime kernel.  It appears to fix the X hangs on my nvidia test
machine (note that for me it's just X that hangs):

-NOTE: this patch is a rebase of John Blackwood's patch. On his kernel, he must be using 
-an older simple wait patch - as his applies to kernel/sched/core.c, while the simple wait
-completion code lives in kernel/sched/completion.c ... I have ported this to test with 
-nvidia, as i would like to see if it fixes the semaphore issues i have seen. 
 
-I've kept the original patch comment in tact;
 
I'm not 100% sure that the patch below will fix your problem, but we
saw something that sounds pretty familiar to your issue involving the
nvidia driver and the preempt-rt patch.  The nvidia driver uses the
completion support to create their own driver's notion of an internally
used semaphore.
 
Fix a race in the PRT wait for completion simple wait code. 
 
A wait_for_completion() waiter task can be awoken by a task calling
complete(), but fail to consume the 'done' completion resource if it
looses a race with another task calling wait_for_completion() just as
it is waking up.
 
In this case, the awoken task will call schedule_timeout() again
without being in the simple wait queue.
 
So if the awoken task is unable to claim the 'done' completion resource,
check to see if it needs to be re-inserted into the wait list before
waiting again in schedule_timeout().
 
Fix-by: John Blackwood <john.blackwood@ccur.com>
 
--- linux-3.14/kernel/sched/completion.c    2014-05-22 14:01:03.879734869 -0400
+++ linux-3.14/kernel/sched/completion.c    2014-05-22 14:13:59.181688658 -0400
@@ -61,11 +61,19 @@
 do_wait_for_common(struct completion *x,
           long (*action)(long), long timeout, int state)
 {
+        int again = 0;
+
    if (!x->done) {
        DEFINE_SWAITER(wait);
  
        swait_prepare_locked(&x->wait, &wait);
        do {
+                       /* Check to see if we lost race for 'done' and are
+                        * no longer in the wait list.
+                        */
+                       if (unlikely(again) && list_empty(&wait.node))
+                               swait_prepare_locked(&x->wait, &wait);
+
            if (signal_pending_state(state, current)) {
                timeout = -ERESTARTSYS;
                break;
@@ -74,6 +82,7 @@
            raw_spin_unlock_irq(&x->wait.lock);
            timeout = action(timeout);
            raw_spin_lock_irq(&x->wait.lock);
+                        again = 1;
        } while (!x->done && timeout);
        swait_finish_locked(&x->wait, &wait);
        if (!x->done)

-- 

   Joakim
