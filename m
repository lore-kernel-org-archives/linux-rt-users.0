From: "Oleg Kechin" <okechin@gmail.com>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Fri, 8 Jun 2007 13:08:45 +0300
Message-ID: <ce87d8040706080308r12735e27ne56a88d3c99b045f@mail.gmail.com>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
	 <1181231910.3841.55.camel@bender>
	 <1181232783.10408.8.camel@localhost.localdomain>
	 <1181233286.11539.38.camel@imap.mvista.com>
	 <1181234037.11539.41.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:56847 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967034AbXFHKIq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Jun 2007 06:08:46 -0400
Received: by ik-out-1112.google.com with SMTP id b32so725050ika
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Jun 2007 03:08:45 -0700 (PDT)
In-Reply-To: <1181234037.11539.41.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 6/7/07, Daniel Walker <dwalker@mvista.com> wrote:
> On Thu, 2007-06-07 at 09:21 -0700, Daniel Walker wrote:
> > .
> >
> > + *
> > + * The new debugging code in __schedule() expects that interrupts
> > + * are disabled across a switch_to. Need to investigate which
> > + * consequences this has.
> >   */
> > -#if 0 // preempt_rt hack, because warn_on in shedule.c triggers
> > +#ifndef CONFIG_PREEMPT_RT
> >  #define __ARCH_WANT_INTERRUPTS_ON_CTXSW
> >  #endif
> >
>
> It is starting to look like a real fix now, thanks for updating it
> Thomas .
>
> Daniel
>
>
Sorry, OMAP5910 CPU is ARM 925 (v4).
Thank you, Daniel, it's disapear.
There is stil a bit unclearness for me. When I set config other than
PREEMPT_RT this bug occure again.
May be it's ok - if someone want -rt patch on ARM arch, he will want
only PREEMPT_RT or I am wrong?

Oleg Kechin.
