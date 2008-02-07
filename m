From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: IBM test question
Date: Thu, 7 Feb 2008 16:34:40 +0100
Message-ID: <20080207163440.174181f2@frecb000686.frec.bull.fr>
References: <47AB0C53.3050703@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43263 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbYBGPee (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Feb 2008 10:34:34 -0500
In-Reply-To: <47AB0C53.3050703@parrot.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


  Hello Matthieu,

On Thu, 07 Feb 2008 14:49:07 +0100 Matthieu CASTET <matthieu.castet@parrot.com> wrote:

> hi,
> 
> I am trying to use some IBM rt test on arm.
> 
> 
> I define atomic_add to
> assert(i==1);
> return ++(v->counter);
> 
> That's a bit ugly, but that should work for my need.

  That would be the poor man's atomic_inc() and not sure it really does
what you think it does ;). Just for the record, pre-armv6 cores have no support
for userland atomic operations (aside from swapping).

> 
> But I have a problem with the sched_latency test.
> On my platform the thread creation is quite slow (25ms), so with the 
> default value, I got a PERIOD MISSED.

  The IBM RT tests have been integrated into the LTP and I recently
sent some updates to those testcases. Notably one the patches did improve
the thread starting time. Other patches did touch this particular test too.

  Could you try the latest release (from LTP) and tell me if things
have improved for you.

  Also, the PASS/FAIL criteria are quite arbitrary. They happen to be fine
for most recent PC-class hardware but surely not for embedded systems and
should be tuned according to your RT requirements.

> 
> I wonder why the test account thread creation time and not compute start 
> at the beginning of the thread ?

  Yes, maybe this should be fixed.

> 
> Also my cpu is quite slow (compared to last intel core or powerpc). For 
> example a sched_jitter run take 6s.

  Ouch! What's your CPU (core type, clock speed)?

> Couldn't be some static or runtime configuration to configure the test 
> according to the cpu speed ?
> 

  Well, that's not the goal here. The objective is to tune the criteria
according to what kind of latencies your RT application can tolerate, not
the other way around.

  Hope this helps,

  Sebastien.
