Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730764AbeGZTKF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jul 2018 15:10:05 -0400
Message-ID: <1532627521.6124.13.camel@gmx.de>
Subject: Re: [rfc 4.16-rt patch] arm64: efi,fpsimd: use a local_lock() in
 efi_virtmap_load()
From: Mike Galbraith <efault@gmx.de>
Date: Thu, 26 Jul 2018 19:52:01 +0200
In-Reply-To: <20180726150934.tsrk6kgc2nmhbxq2@linutronix.de>
References: <1531321642.12761.30.camel@gmx.de>
         <20180726150934.tsrk6kgc2nmhbxq2@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Thu, 2018-07-26 at 17:09 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-11 17:07:22 [+0200], Mike Galbraith wrote:
> > Greetings,
> > 
> > With the patch below, there's still one neon splat to figure out what
> > to do with should this patch not die a gruesome death.  Cavium box
> > boots and seemingly works fine modulo kvm, which is utterly deadly in
> > 4.16-rt due to..
> > 
> > 972             if (!vgic_initialized(vcpu->kvm))
> > 973                     return false;
> > 974
> > 975             irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
> > 976             spin_lock_irqsave(&irq->irq_lock, flags);
> > 
> > ..that lock apparently having wandered into a minefield post v4.14.
> > 
> > Remaining neon splat:
> 
> I don't have this with preempt-disable patch for kernel_neon_begin()
> (posted seconds ago).

Oh, forget you _ever saw_ that patch.  It later demonstrated it's
"correctness" quite convincingly.  I didn't explicitly recall it due to
the patch it tried to build upon proving in the end to be a bit south
of wonderful itself, making the whole exercise a "let's make a bad
situation even worse" kinda thing :)

	-Mike
