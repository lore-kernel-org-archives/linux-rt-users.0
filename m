From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] all programs that are linked with -lrttest must depend
 on librttest.a
Date: Mon, 23 Feb 2015 17:02:53 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1502231702140.7063@riemann>
References: <1424375949-9334-1-git-send-email-r.schwebel@pengutronix.de> <20150219164400.67d39390@sluggy>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@gmail.com>
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41800 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbBWQDG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2015 11:03:06 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so18435378wid.5
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2015 08:03:05 -0800 (PST)
In-Reply-To: <20150219164400.67d39390@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 19 Feb 2015, Clark Williams wrote:

> On Thu, 19 Feb 2015 20:59:09 +0100
> Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> 
> > From: Michael Olbrich <m.olbrich@pengutronix.de>
> > 
> > Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> > ---
> >  Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 9e479d3c0dca..4ee553849cce 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -73,14 +73,14 @@ cyclictest: cyclictest.o librttest.a
> >  signaltest: signaltest.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> > 
> > -pi_stress: pi_stress.o
> > +pi_stress: pi_stress.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> > 
> >  hwlatdetect:  src/hwlatdetect/hwlatdetect.py
> >  	chmod +x src/hwlatdetect/hwlatdetect.py
> >  	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
> > 
> > -rt-migrate-test: rt-migrate-test.o
> > +rt-migrate-test: rt-migrate-test.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> > 
> >  ptsematest: ptsematest.o librttest.a
> > @@ -101,7 +101,7 @@ sendme: sendme.o librttest.a
> >  pip_stress: pip_stress.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> > 
> > -hackbench: hackbench.o
> > +hackbench: hackbench.o librttest.a
> >  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
> > 
> >  librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Makes sense to me. John is working on the next spin of rt-tests so I
> CC'd him to pull in this change.
> 
> Clark
> 

(resend with a sane emailer)
I think we have to NAK this one.
I saw this problem too, if you try to do an individual build, hackbench 
and rt-migrate fail unless the lib rttest has already been built.
The thing is, neither hackbench nor rt-migrate use any of the functions in 
that lib rttest, so I'd rather not put a false dependency on the lib where 
it isn't needed.

If you'd like to come up with a patch that separates it out of the default 
libs to solve the problem, I'd accept that.

Thanks!
