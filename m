From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] Fix RT balancing tasks pulling
Date: Wed, 25 Jul 2007 09:27:00 +0200
Message-ID: <20070725072700.GC26955@elte.hu>
References: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Josh Triplett <josht@linux.vnet.ibm.com>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:39221 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123AbXGYH1w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 03:27:52 -0400
Content-Disposition: inline
In-Reply-To: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* S=E9bastien Dugu=E9 <sebastien.dugue@bull.net> wrote:

>   Hi Ingo, Thomas,
>=20
>   this one-liner fixes a bug in balance_rt_tasks() which sometimes=20
> manifests by having a lower prio task being scheduled while a higher=20
> prio task is sitting waiting on another runqueue.
>=20
>   This is pretty hard to reproduce on low cpu count machines, for=20
> example, I had to have sched_football run in a loop for ~38h before i=
t=20
> failed on a dual HT Xeon box.

really nice catch! Applied.

	Ingo
