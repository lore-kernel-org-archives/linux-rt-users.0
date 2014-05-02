From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 02 May 2014 13:43:43 +0200
Message-ID: <1399031023.5233.145.camel@marge.simpson.net>
References: <1399029159.5233.124.camel@marge.simpson.net>
	 <5363840B.6020402@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:50310 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbaEBLnq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 07:43:46 -0400
Received: by mail-ee0-f52.google.com with SMTP id e53so3062699eek.39
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 04:43:45 -0700 (PDT)
In-Reply-To: <5363840B.6020402@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2014-05-02 at 15:39 +0400, Pavel Vasilyev wrote:=20
> 02.05.2014 15:12, Mike Galbraith =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > The following patches are fixes that fell out of testing rt1.  Patc=
hes
> > 1-4 are intended to be folded into existing patches, 5-6 are
> > replacements.
> >
> > fold:
> > 1/6 - preempt-lazy-support.patch
> > 2/6 - x86-preempt-lazy.patch
> > 3/6 - hotplug-light-get-online-cpus.patch
> > 4/6 - stomp-machine-raw-lock.patch
> >
> > replace:
> > 5/6 - (prep)
> > 6/6 - stomp-machine-deal-clever-with-stopper-lock.patch
> >
> > drop: (buggy - calls migrate_disable() _after_ maybe blocking)
> > migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch
>=20
>=20
> Cool, but you can the same, but for 3.14.2 ?

They'll apply fine.  You'll just have to comment out the two patches in
the rt1 tree which are no longer needed.  I added those on top of
14.2-rt1 with those two commented out.

-Mike


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
