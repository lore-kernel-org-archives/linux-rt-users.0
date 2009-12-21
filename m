From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: Latency Problems with 2.6.31/PREEMPT_RT on a 1.2GHz Celeron
Date: Mon, 21 Dec 2009 12:16:19 +0300
Message-ID: <200912211216.20588@zigzag.lvk.cs.msu.su>
References: <abe060d60912171537j10fe194r5f0cd1aca85475df@mail.gmail.com> <4B2BB45A.9040909@mantatest.com> <4B2CBA28.1030405@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vladimir Cotfas <vladc@mantatest.com>,
	linux-rt-users@vger.kernel.org,
	Scott Gilbertson <scottg@mantatest.com>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:51507 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbZLUJQY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 04:16:24 -0500
In-Reply-To: <4B2CBA28.1030405@cfl.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On 12/18/2009 11:56 AM, Vladimir Cotfas wrote:
> > All,
> >
> > I have a a driver that must process an interrupt every 100 uS without
> > missing any. I am having latency issues and I am looking for some help
> > debugging my problem.
>
> You'll probably never get this working reliably with the RT kernel.
> Latencies are more deterministic with the RT kernel but slightly higher.
> You'll have better luck with a vanilla kernel running your app in run
> level 4. And then even better luck running on an SMP machine isolating
> your process and IRQ to a single processor. And stay away from the VGA
> console. You have better luck with faster hardware too.

We have seen <20us avg latencies on RT kernel on slower powerpc-based SoC.

The only problem is that sometimes we got single-shot latency >150 us - 
that happened when sched tick was running for >100 us with interrupts 
disabled.
