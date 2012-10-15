From: John Kacur <jkacur@redhat.com>
Subject: Re: Don't reference non-standard realtime group
Date: Tue, 16 Oct 2012 01:13:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210160107520.6335@tycho>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806542-1927108390-1350342817=:6335"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47987 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2JOXLs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 19:11:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2711496bkc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 16:11:47 -0700 (PDT)
In-Reply-To: <20120902194911.GT28643@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-1927108390-1350342817=:6335
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 2 Sep 2012, Uwe Kleine-König wrote:

> On Wed, Jul 13, 2011 at 10:48:31PM +0200, Uwe Kleine-König wrote:
> > There is no dedicated realtime group in most distributions. So make the
> > error message a bit more understandable for people not running Redhat
> > MRG.

I thought we rejected this (via irc) the first time you sent it. The idea 
of a realtime group is pretty generic, but sure, it isn't there by default 
if you don't create it. However, the worse thing about this patch is that 
your message is in no way clearer than the original. It's longer though.

Sorry, I don't like it, maybe Clark will overrule me if he's bored, or 
cares enough, but I'm not putting it in.

> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Closes: http://bugs.debian.org/619938
> ping?!
> 
> > ---
> >  src/lib/rt-utils.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- a/src/lib/rt-utils.c
> > +++ b/src/lib/rt-utils.c
> > @@ -72,7 +72,8 @@
> >  	param.sched_priority = 1;
> >  	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
> >  		fprintf(stderr, "Unable to change scheduling policy!\n");
> > -		fprintf(stderr, "either run as root or join realtime group\n");
> > +		fprintf(stderr, "Probably missing capabilities, either run as "
> > +				"root or increase RLIMIT_RTPRIO limits.\n");
> >  		return 1;
> >  	}
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
---1463806542-1927108390-1350342817=:6335--
