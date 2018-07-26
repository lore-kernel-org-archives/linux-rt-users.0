Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:49882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731445AbeGZQ0z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jul 2018 12:26:55 -0400
Date: Thu, 26 Jul 2018 17:09:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc 4.16-rt patch] arm64: efi,fpsimd: use a local_lock() in
 efi_virtmap_load()
Message-ID: <20180726150934.tsrk6kgc2nmhbxq2@linutronix.de>
References: <1531321642.12761.30.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531321642.12761.30.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On 2018-07-11 17:07:22 [+0200], Mike Galbraith wrote:
> Greetings,
> 
> With the patch below, there's still one neon splat to figure out what
> to do with should this patch not die a gruesome death.  Cavium box
> boots and seemingly works fine modulo kvm, which is utterly deadly in
> 4.16-rt due to..
> 
> 972             if (!vgic_initialized(vcpu->kvm))
> 973                     return false;
> 974
> 975             irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
> 976             spin_lock_irqsave(&irq->irq_lock, flags);
> 
> ..that lock apparently having wandered into a minefield post v4.14.
> 
> Remaining neon splat:

I don't have this with preempt-disable patch for kernel_neon_begin()
(posted seconds ago).

Sebastian
