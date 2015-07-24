From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/1] cyclictest: Fix long priority help text option
Date: Fri, 24 Jul 2015 09:14:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1507240913200.7283@riemann.gateway.2wire.net>
References: <1437569099-2965-1-git-send-email-alexander.stein@systec-electronic.com> <20150722102127.12ee911e@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38591 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbGXNOm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2015 09:14:42 -0400
Received: by iggf3 with SMTP id f3so16231799igg.1
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2015 06:14:41 -0700 (PDT)
In-Reply-To: <20150722102127.12ee911e@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 22 Jul 2015, Clark Williams wrote:

> On Wed, 22 Jul 2015 14:44:59 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > The help text shows prio as the long option name for the process priority.
> > But it is actually priority.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> >  src/cyclictest/cyclictest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 34053c5..c178a74 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1062,7 +1062,7 @@ static void display_help(int error)
> >  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
> >  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
> >  	       "-O TOPT  --traceopt=TOPT   trace option\n"
> > -	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
> > +	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
> >  	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
> >  	       "-q       --quiet           print only a summary on exit\n"
> >  	       "	 --priospread       spread priority levels starting at specified value\n"
> > -- 
> > 2.3.6
> 
> Thanks, I've pulled this into my tree for the next release.


Ack:

I've also added it to branch v0.93-devel with Clark's SOB here
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Thanks!
