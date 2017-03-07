From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 8 Mar 2017 00:21:51 +0100
Message-ID: <20170307232151.7macprg6qnl3exbh@linutronix.de>
References: <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
 <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
 <3c9395f9c6b944978c1f420276bde0ee@FE-MBX1012.de.bosch.com>
 <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
 <20170302175155.rymagis536dnw5nh@linutronix.de>
 <d831bc9a2939474f8b8290905f393088@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW3)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756588AbdCGXna (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Mar 2017 18:43:30 -0500
Content-Disposition: inline
In-Reply-To: <d831bc9a2939474f8b8290905f393088@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-07 13:39:36 [+0000], Koehrer Mathias (ETAS/ESW3) wrote:
> Hi Sebastian,
Hi Mathias,

> > and 8144 blocks in wait for 8424 which is never completes without additional help
> > (like a manual SIGCONT). Right now it looks like the PTRACE_DETACH (syscall
> > 101, 11) which should remove the task from ptrace and wakeup did not work but I
> > see a wakeup… The wakeup worked (most likely) but since it is stuck I guess that
> > there was a second signal it is processing and waiting for gdb.
> I do not understand, what that means.
> When I run the very same test on a non-rt kernel (or even on a RT kernel with a 
> preemption model that is not configured as "Fully Preemptible Kernel"), I never see 
> this issue.

I can reproduce the issue on a -RT kernel. I don't really know what the
root issue is but it is a problem. We had a ptrace issue if you look
into the queue for
  "ptrace: fix ptrace vs tasklist_lock race"

> Also - as mentioned - previously, with older RT preempted kernel versions it is working fine
> as well. For me it looks as if the RT preempting on newer kernels somehow has impact 
> on the way the debugging with gdb works
> My expectation (and so far I had the experience) is that a code that is running fine 
> with a non RT kernel should also run fine with the fully preempted kernel (of course 
> the timing behavior is different). 

That is correct - it should work. I've been tracing it for a while now
and have no real clue what goes wrong. There a few different ways how it
seems to go wrong and the outcome is always that the kernel puts the
task in "stop" mode while gdb expects it to run and waits for it.

> Regards
> 
> Mathias

Sebastian
