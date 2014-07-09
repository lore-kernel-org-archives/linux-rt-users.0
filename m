From: Henrik Austad <henrik@austad.us>
Subject: Re: [ANNOUNCE] 3.14.10-rt7
Date: Wed, 9 Jul 2014 13:34:36 +0200
Message-ID: <20140709113436.GB26330@austad.us>
References: <alpine.DEB.2.10.1407071027170.22031@nanos>
 <alpine.DEB.2.10.1407071633460.22031@nanos>
 <53BD1316.5090901@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Carsten Emde <cbe@osadl.org>
To: Pavel Vasilyev <pavel@pavlinux.ru>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:61129 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaGILew (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jul 2014 07:34:52 -0400
Received: by mail-la0-f49.google.com with SMTP id gf5so4933930lab.36
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Jul 2014 04:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53BD1316.5090901@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 09, 2014 at 02:01:58PM +0400, Pavel Vasilyev wrote:
> 07.07.2014 18:34, Thomas Gleixner =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >This time with proper Subject line :)
> >
> >Dear RT Folks,
> >
> >I'm pleased to announce the 3.14.10-rt7 release. 3.14.10-rt6 is a no=
t
> >announced update to 3.14.10 without any RT changes aside of resolvin=
g
> >the patch conflicts.
> >
> >Changes since 3.14.10-rt6:
> >
> >    * Do not clear PF_NO_SETAFFINITY flag in select_fallback_rq() -
> >      from Steven
> >
> >    * Prevent workqueue deadlock/stall observed with XFS
> >
> >
> >A few words on the status and the future of RT:
> >-----------------------------------------------
> >
> >The situation since last years RTLWS (https://lwn.net/Articles/57274=
0/)
> >has not improved at all, it's worse than before.
> >
> >While shortly after RTLWS quite some people promised to whip up prop=
er
> >funding, nothing has materialized and my personal situation is worse
> >than before.
>=20
> Create site, add PayPal [DOANTE] button.

But.. where would they donate money?

Jokes aside, setting up an easy way to support the project wouldn't be =
such=20
a bad idea. Is this something we (tglx) could talk (convince)=20
linuxfoundation into hosting?

As said in the original mail, the kernel has benefited greatly from thi=
s=20
effort over the last few years, making the effort more formal could hel=
p=20
secure funding and let tglx et al focus on the task at hand and not on=20
silly money issues.

Just my 0.1237 Norwegian krone.

--=20
Henrik Austad
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
