From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [RFC 0/4] cyclictest: improve running under trace-cmd
Date: Wed, 24 Feb 2016 12:56:26 -0500
Message-ID: <20160224125626.116ebcc1@redhat.com>
References: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1602241802300.13215@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949AbcBXR41 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 12:56:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id B9F7190E44
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 17:56:27 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1602241802300.13215@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Feb 2016 18:08:58 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> On Tue, 23 Feb 2016, Luiz Capitulino wrote:
> 
> > 
> > In short, this series allows you to run cyclictest under
> > trace-cmd and still get trace marks when the latency
> > specified with -b is execeded. More details in patch 4/4.
> > 
> > This series is RFC because I'm not completely sure this
> > is the right thing to do. I'm wondering if we shouldn't
> > ditch all tracing support from cyclictest...
> > 
> > Luiz Capitulino (4):
> >   cyclictest: tracing(): check for notrace
> >   cyclictest: move debugfs init code to its own function
> >   cyclictest: move tracemark_fd handling to its own function
> >   cyclictest: add --tracemark option
> > 
> >  src/cyclictest/cyclictest.c | 62 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 47 insertions(+), 15 deletions(-)
> > 
> > -- 
> 
> Hi. First of all, although I didn't look closely at the details yet, I 
> like this set of patches. Just to let you and everyone else know where we 
> are, Clark and I are going to put rt-tests into maintainence mode very 
> shortly. We want to create a 1.0 version of it, which we will maintain 
> with fixes, but no new features. This last set of patches would be a nice 
> addition before we go into mainatinence mode so that the old code base 
> would have a way of using trace-cmd.

OK, that's good to know because I have more patches pending but I
don't want to disturb your plans and workflow.

Regarding this series, what I want to achieve is:

 1. Use trace-cmd for tracing
 2. Get cyclictest to write to the trace_marker file when it
    exceeds the -b latency treshold

By reading the code this seems to be impossible to achieve today,
as you need to pass --notrace to use trace-cmd for tracing and
--notrace will disable writing to the trace_maker.

If what I just described is correct, then we need this series.

> For the next development line of rt-tests, we would like to rip-out all of 
> the tracing code that we can, and leave the bare minimum in place to 
> interact with trace-cmd. With that in mind, could you go over your RFC 
> patches, and if you are satisfied that they don't break anything, but 
> allow tracing under trace-cmd, then this could be the last new feature we 
> let in. Let me know and I'll review at that point. I'll make and official 
> announcement about maintainence mode and a new development line in a 
> separate mail as well.

OK, I'll do a second pass on this series, test it more, and send
a non-RFC version for inclusion.

I also have a small series with very minor fixups. I don't know
if they are important, but I'll post it shortly.
