From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Question on RCU_BOOST option
Date: Wed, 27 Mar 2013 12:38:35 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303271227410.22263@ionos>
References: <F9467A784CC48947B1D879F07370839E0EBE9EC3@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34671 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3C0Lii (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Mar 2013 07:38:38 -0400
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBE9EC3@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 27 Mar 2013, Koehrer Mathias (ETAS/ESS2) wrote:
> > 
> > Perhaps you might want to have a look at this thread, about RCU stalls
> > and a possible common root cause for some of them.
> > 
> > http://marc.info/?l=linux-rt-users&m=136258510132233&w=2
> 
> Thanks for the information. However the application is intended to
> run with 100% CPU (real time) load on one core.  That's why the CPU
> core is isolated for. They are reserved for this application.

Sure, but it's not possible today to run 100% CPU in user space. RCU
is one of the issues, which has a solution in 3.8. See
https://lwn.net/Articles/522262/

There is work in progress to solve the other issues as well, but
that's not going to happen before 3.10.

> The one option is to raise the prioriy of ksoftirq (which contains
> the RCU stuff (if I know right...)) or I was playing with the
> RCU_BOOST feature which I expected to have the same effect.

RCU_BOOST does not solve that. It's about starvation of readside
critical sections.  See https://lwn.net/Articles/220677/

> However, the RCU_BOOST feature is not clear to me as I still saw the
> kernel messages about RCU stalls that I did not want to see
> anymore...

Sure, RCU_BOOST is tackling a different problem. The callback free
CPUs implementation is what you are looking for.

Thanks,

	tglx
