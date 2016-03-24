From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH][rt-tests] cyclictest: Make the tracemark option imply
 notrace
Date: Thu, 24 Mar 2016 16:24:47 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603241608370.8641@riemann>
References: <alpine.LFD.2.20.1603241543150.8641@riemann> <20160324105255.48459b11@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33979 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcCXPYu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 11:24:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id p65so13544217wmp.1
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 08:24:49 -0700 (PDT)
In-Reply-To: <20160324105255.48459b11@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 24 Mar 2016, Luiz Capitulino wrote:

> On Thu, 24 Mar 2016 15:44:39 +0100 (CET)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > From 6b663b39fc5dc7c4e9c78ab22012f07490e53145 Mon Sep 17 00:00:00 2001
> > From: John Kacur <jkacur@redhat.com>
> > Date: Thu, 24 Mar 2016 15:40:03 +0100
> > Subject: [PATCH] cyclictest: Make the tracemark option imply notrace
> > 
> > The new --tracemark option can be used to run cyclictest under
> > trace-cmd.
> > 
> > This means we don't want cyclictest's built-in tracing to be used, so
> > this option is only compatible with --notrace.
> > 
> > Therefore turn --notrace on if --tracemark is invoked even if the user
> > doesn't explicitly request this.
> 
> I'm not necessarily against this, but at the same time I think
> I prefer options doing only one thing.

Maybe think about it a little differently. The option implies a certain 
consistent state. So, the option really only does do one thing, it puts 
cyclictest in the correct state as required. If we don't do this, someone 
is sure to use the --tracemark option without --notrace, and some 
unexpected things are going to occur.

By the way, I like your new option, we've been thinking about doing 
something like that for awhile.

Cheers!

> 
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 4844dfaf33a6..158bceda1204 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1765,6 +1765,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
> >  #endif
> >  			break;
> >  		case OPT_TRACEMARK:
> > +			notrace = 1; /* using --tracemark implies --notrace */
> >  			trace_marker = 1; break;
> >  		}
> >  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
