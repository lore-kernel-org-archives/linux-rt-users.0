From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH RT] Fix RT balancing tasks pulling
Date: Mon, 30 Jul 2007 14:50:34 -0700
Message-ID: <1185832234.3334.35.camel@josh-work.beaverton.ibm.com>
References: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:40753 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967923AbXG3VuJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 17:50:09 -0400
In-Reply-To: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-07-24 at 15:42 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
>   this one-liner fixes a bug in balance_rt_tasks() which sometimes ma=
nifests by
> having a lower prio task being scheduled while a higher prio task is =
sitting
> waiting on another runqueue.
>=20
>   This is pretty hard to reproduce on low cpu count machines, for exa=
mple, I
> had to have sched_football run in a loop for ~38h before it failed on=
 a dual HT
> Xeon box.

Very impressive find, and this does seem to improve things in some
cases.

However, with 2.6.22.1-rt8, which includes this patch, I still managed
to get some failures after a few hours on an 8-way (quad dual-core) box=
=2E
Preliminary results so far:
    420 Final ball position: 0
      2 Final ball position: 1

- Josh Triplett
