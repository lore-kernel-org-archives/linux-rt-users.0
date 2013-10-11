From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: CONFIG_NO_HZ_FULL in x86 (32bit)?
Date: Fri, 11 Oct 2013 15:58:40 +0200
Message-ID: <20131011135838.GA14694@localhost.localdomain>
References: <F9467A784CC48947B1D879F07370839E1E0364DC@fe20099s.ecn.etasgroup.com>
 <20131011123249.GG6983@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:59288 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3JKN6n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 09:58:43 -0400
Received: by mail-we0-f181.google.com with SMTP id t60so4073034wes.26
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Oct 2013 06:58:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131011123249.GG6983@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 11, 2013 at 02:32:49PM +0200, Sebastian Andrzej Siewior wrote:
> * Koehrer Mathias (ETAS/ESS2) | 2013-10-11 08:32:50 [+0000]:
> 
> >Hi all,
> Hi Mathias,
> 
> >I found out that with the RT_PREEMPT patch for kernel 3.10 there is the cool feature rcu_nocbs (offload RCU callback processing) available which allows to free cores to run single real time user space applications on it.
> >This feature depends on CONFIG_NO_HZ_FULL, however this is not available for x86 (32 bit).
> >My question is now: Is there a way to get the rcu_nocbs running together with NO_HZ_FULL on a 32bit x86?
> 
> I *think* this is because VIRT_CPU_ACCOUNTING_GEN accounts everything in
> nsec instead of jiffies and this could be very expensive on 32bit archs
> doing 64bit math.
> Frederic, is this everything or is there more to it?

So there are two things required for NO_HZ_FULL support on an arch (as of current
tip:master tree):

* Support CONFIG_CONTEXT_TRACKING. Namely this is about setting hooks on user/kernel
boundaries: syscall and exceptions (irq are automatically handled).

On x86-32 there should be few work to do to enable that. In fact it might already work as is
because x86-64 support is there and they mostly share the same functions, syscall slow path
and exception handler.

* Support CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN. This only requires a bit of audit to make
sure that cputime_t as 64 bits is not racy on the arch code. This config is quite unusual as
it doesn't involve any functional ability, it's just about checking that the arch doesn't do
things with tsk->[usg]time that are unsafe between writer/readers in 32 bits.
This should be fine in x86-32.

One of you want to enable that support? I'll happily review the patches.

Thanks.

> 
> >Thanks for any feedback
> >
> >Best regards
> >
> >Mathias
> 
> Sebastian
