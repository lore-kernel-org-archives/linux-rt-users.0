From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/4] cyclictest: improve running under trace-cmd
Date: Wed, 16 Mar 2016 23:37:21 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603162336430.16977@riemann>
References: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com> <20160316172321.7fbc829e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33672 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbcCPWhg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 18:37:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id x188so3541646wmg.0
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Mar 2016 15:37:23 -0700 (PDT)
In-Reply-To: <20160316172321.7fbc829e@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 16 Mar 2016, Luiz Capitulino wrote:

> On Thu, 25 Feb 2016 11:29:13 -0500
> Luiz Capitulino <lcapitulino@redhat.com> wrote:
> 
> > 
> > This is just a repost of my RFC posting with no changes.
> > I have tested it a bit more and I think it's good
> > for inclusion.
> 
> ping?
> 
> > 
> > Original intro:
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
> 
> --

I'll have a closer look tomorrow, but these look okay.

John
