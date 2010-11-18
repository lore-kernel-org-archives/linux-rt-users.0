From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Slub support with PREEMPT_RT ?
Date: Thu, 18 Nov 2010 09:40:01 +0100
Message-ID: <1290069601.2109.1295.camel@laptop>
References: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
	 <4CE4802D.6070903@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Jean-Michel Hautbois <jhautbois@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34901 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab0KRIjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Nov 2010 03:39:46 -0500
In-Reply-To: <4CE4802D.6070903@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-11-17 at 17:23 -0800, Darren Hart wrote:
> On 11/17/2010 08:18 AM, Jean-Michel Hautbois wrote:
> > Hi !
> >
> > I am wondering why SLUB isn't supported with PREEMPT_RT ?
> > I cannot find any info on that except the fact it is not working yet.
> > What do we have to do in order to support it ?
> 
> Peter can answer this better than I can, but it has something to do with 
> all the local_bh_disable() calls not being compatible with the goals of 
> PREEMPT_RT - if I remember correctly.

Nah, its slub doens't use the softirq crap. But its close, you have to
iron out the per-cpu assumptions in the thing. I did a few slub-rt ports
at various times but the thing kept changing too much and I gave up.

I should probably do a new port and hope the thing is more stable now
that the excitement is down or somesuch.
