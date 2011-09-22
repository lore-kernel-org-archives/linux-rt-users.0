From: Mike Galbraith <efault@gmx.de>
Subject: Re: rt14: strace ->  migrate_disable_atomic imbalance
Date: Thu, 22 Sep 2011 16:46:10 +0200
Message-ID: <1316702770.6064.1.camel@marge.simson.net>
References: <alpine.LFD.2.02.1109101052340.2723@ionos>
	 <1315737307.6544.1.camel@marge.simson.net>
	 <1315817948.26517.16.camel@twins>
	 <1315835562.6758.3.camel@marge.simson.net>
	 <1315839187.6758.8.camel@marge.simson.net> <1315926499.5977.19.camel@twins>
	 <1315927699.6445.6.camel@marge.simson.net> <1315930430.5977.21.camel@twins>
	 <1316600230.6628.6.camel@marge.simson.net> <1316685640.31429.2.camel@twins>
	 <1316692534.6284.46.camel@marge.simson.net>
	 <1316693391.31429.12.camel@twins>
	 <1316698943.6348.8.camel@marge.simson.net>
	 <1316702080.31429.13.camel@twins>
	 <1316702297.5455.1.camel@marge.simson.net>
	 <1316702515.31429.15.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>, mingo <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36706 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752811Ab1IVOqP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Sep 2011 10:46:15 -0400
In-Reply-To: <1316702515.31429.15.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-09-22 at 16:41 +0200, Peter Zijlstra wrote:
> On Thu, 2011-09-22 at 16:38 +0200, Mike Galbraith wrote:
> > On Thu, 2011-09-22 at 16:34 +0200, Peter Zijlstra wrote:
> > > On Thu, 2011-09-22 at 15:42 +0200, Mike Galbraith wrote:
> > > > #include <cpuset.h>
> > >=20
> > > I don't seem to have that, where does that come from?
> >=20
> > libcpuset-devel.
>=20
> Not in any distro near me. I'm assuming its this stuff:

(move closer to N=C3=BCrnberg;)

>   ftp://oss.sgi.com/projects/cpusets/download/libcpuset.html

Yeah, that should be it.

	-Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
