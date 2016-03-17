From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 0/4] cyclictest: improve running under trace-cmd
Date: Thu, 17 Mar 2016 09:48:43 -0400
Message-ID: <20160317094843.5e1f4b49@redhat.com>
References: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
	<20160316172321.7fbc829e@redhat.com>
	<alpine.LFD.2.20.1603162336430.16977@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983AbcCQNsr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 09:48:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id B98D33B72B
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 13:48:46 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603162336430.16977@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Mar 2016 23:37:21 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

> 
> 
> On Wed, 16 Mar 2016, Luiz Capitulino wrote:
> 
> > On Thu, 25 Feb 2016 11:29:13 -0500
> > Luiz Capitulino <lcapitulino@redhat.com> wrote:
> > 
> > > 
> > > This is just a repost of my RFC posting with no changes.
> > > I have tested it a bit more and I think it's good
> > > for inclusion.
> > 
> > ping?
> > 
> > > 
> > > Original intro:
> > > 
> > > In short, this series allows you to run cyclictest under
> > > trace-cmd and still get trace marks when the latency
> > > specified with -b is execeded. More details in patch 4/4.
> > > 
> > > This series is RFC because I'm not completely sure this
> > > is the right thing to do. I'm wondering if we shouldn't
> > > ditch all tracing support from cyclictest...
> > > 
> > > Luiz Capitulino (4):
> > >   cyclictest: tracing(): check for notrace
> > >   cyclictest: move debugfs init code to its own function
> > >   cyclictest: move tracemark_fd handling to its own function
> > >   cyclictest: add --tracemark option
> > > 
> > >  src/cyclictest/cyclictest.c | 62 ++++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 47 insertions(+), 15 deletions(-)
> > > 
> > 
> > --
> 
> I'll have a closer look tomorrow, but these look okay.

There's a small conflict due to the older repo I was using. I'll
rebase it, re-test and re-post.
