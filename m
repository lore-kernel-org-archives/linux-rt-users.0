From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH][rt-tests] cyclictest: Make the tracemark option imply
 notrace
Date: Thu, 24 Mar 2016 12:07:03 -0400
Message-ID: <20160324120703.02225e61@redhat.com>
References: <alpine.LFD.2.20.1603241543150.8641@riemann>
	<20160324105255.48459b11@redhat.com>
	<alpine.LFD.2.20.1603241608370.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222AbcCXQHG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 12:07:06 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id EF74B20CF5
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 16:07:05 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603241608370.8641@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 24 Mar 2016 16:24:47 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Thu, 24 Mar 2016, Luiz Capitulino wrote:
> 
> > On Thu, 24 Mar 2016 15:44:39 +0100 (CET)
> > John Kacur <jkacur@redhat.com> wrote:
> > 
> > > From 6b663b39fc5dc7c4e9c78ab22012f07490e53145 Mon Sep 17 00:00:00 2001
> > > From: John Kacur <jkacur@redhat.com>
> > > Date: Thu, 24 Mar 2016 15:40:03 +0100
> > > Subject: [PATCH] cyclictest: Make the tracemark option imply notrace
> > > 
> > > The new --tracemark option can be used to run cyclictest under
> > > trace-cmd.
> > > 
> > > This means we don't want cyclictest's built-in tracing to be used, so
> > > this option is only compatible with --notrace.
> > > 
> > > Therefore turn --notrace on if --tracemark is invoked even if the user
> > > doesn't explicitly request this.
> > 
> > I'm not necessarily against this, but at the same time I think
> > I prefer options doing only one thing.
> 
> Maybe think about it a little differently. The option implies a certain 
> consistent state. So, the option really only does do one thing, it puts 
> cyclictest in the correct state as required. If we don't do this, someone 
> is sure to use the --tracemark option without --notrace, and some 
> unexpected things are going to occur.

I agree with your reasoning, and I again, I'm not against the change.

But my thinking is that, as a good practice, command-line options should
generally do one thing only. If we go too far in doing "one option
implies other" very soon we'll get unexpected behavior with long
command-lines.

> 
> By the way, I like your new option, we've been thinking about doing 
> something like that for awhile.
> 
> Cheers!
> 
> > 
> > > 
> > > Signed-off-by: John Kacur <jkacur@redhat.com>
> > > ---
> > >  src/cyclictest/cyclictest.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > > index 4844dfaf33a6..158bceda1204 100644
> > > --- a/src/cyclictest/cyclictest.c
> > > +++ b/src/cyclictest/cyclictest.c
> > > @@ -1765,6 +1765,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
> > >  #endif
> > >  			break;
> > >  		case OPT_TRACEMARK:
> > > +			notrace = 1; /* using --tracemark implies --notrace */
> > >  			trace_marker = 1; break;
> > >  		}
> > >  	}
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 

