From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: PF_HARDIRQ used in preempt-realtime-core.patch
Date: Mon, 06 Oct 2008 14:22:48 -0700
Message-ID: <1223328168.17348.77.camel@sven.thebigcorporation.com>
References: <20081006194928.GA14183@windriver.com>
	 <1223324413.17348.47.camel@sven.thebigcorporation.com>
	 <48EA7F19.90908@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:64037 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbYJFVWx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Oct 2008 17:22:53 -0400
Received: by wx-out-0506.google.com with SMTP id h27so653781wxd.4
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Oct 2008 14:22:52 -0700 (PDT)
In-Reply-To: <48EA7F19.90908@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-10-06 at 17:11 -0400, Paul Gortmaker wrote:

>=20
> Thanks for the feedback, it helps me to know that I wasn't completely
> off base with my original thoughts of how to do something that might
> be useful in the end.
>=20

=EF=BB=BFI've pulled your patches into the preliminary openSUSE 11.1 RT=
 Kernel
so far.

=EF=BB=BFI have to admit, a couple of the build fixes I did late night =
have not
been pushed back; I'll sort through it asap, and I think Greg will have
some patches for you to add as well.

It was my understanding that Thomas wanted to break into several git
trees that had the different RT "features" broken out into several
branches, and that makes sense to me.

Sven

> Paul.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
