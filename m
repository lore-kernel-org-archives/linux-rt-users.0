From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [4.1.7-rt8][report] Very high cyclictest latency during glmark2
 on i915 gpu
Date: Sat, 17 Oct 2015 12:59:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510171258170.4212@nanos>
References: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com> <CALqGcGo_CBrQynU1TeymxQJbL_LJgN9d5ADho_jM-DRB6c312w@mail.gmail.com> <20151016203629.GE12756@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christoph Mathys <eraserix@gmail.com>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40456 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbJQLAT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Oct 2015 07:00:19 -0400
In-Reply-To: <20151016203629.GE12756@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 16 Oct 2015, Josh Cartwright wrote:
> On Wed, Oct 14, 2015 at 11:08:38AM +0200, Christoph Mathys wrote:
> > On Tue, Oct 13, 2015 at 5:35 PM, Christoph Mathys <eraserix@gmail.com> wrote:
> > > Can anyone reproduce this? Any ideas? dmesg does not contain any funny
> > > reports...
> >
> > It is actually not true that there are no funny reports. After
> > enabling more debug options I now get the BUG below once per second.
> > There are other callpaths than the one below that trigger this
> > message, but they all go through the function
> > intel_pipe_update_start().
> >
> > [   17.694307] BUG: sleeping function called from invalid context at
> > kernel/locking/rtmutex.c:917
> > [   17.694308] in_atomic(): 0, irqs_disabled(): 1, pid: 102, name: kworker/3:1
> [..]
> > [   17.694347] hardirqs last disabled at (21082): [<ffffffffa02fabf3>] intel_pipe_update_start+0x113/0x640 [i915]
> [..]
> > [   17.694367] Call Trace:
> > [   17.694370]  [<ffffffff817f961d>] dump_stack+0x4a/0x61
> > [   17.694372]  [<ffffffff8108785a>] ___might_sleep+0x13a/0x200
> > [   17.694373]  [<ffffffff81800f24>] rt_spin_lock+0x24/0x60
> > [   17.694374]  [<ffffffff8108bbac>] ? migrate_disable+0x6c/0xe0
> > [   17.694375]  [<ffffffff810a9bab>] prepare_to_wait+0x2b/0xa0
> > [   17.694386]  [<ffffffffa02faca8>] intel_pipe_update_start+0x1c8/0x640 [i915]
> 
> Looks like intel_pipe_update_start() is trying to queue the caller up on
> the drm_crtc_vblank_waitqueue() from an local_irq_disable()'d region,
> which doesn't fly on -rt, as the internal waitqueue lock is a converted
> rt_mutex w/ PREEMPT_RT (and thus can sleep if contended).
> 
> Perhaps this driver is a candidate for a simple waitqueue conversion.

It can, but it calls some more functions with interrupts disabled
which are taking regular spinlocks. So that does not cure it.

Thanks,

	tglx
