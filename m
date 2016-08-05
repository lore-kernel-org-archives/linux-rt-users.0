From: yunhong jiang <yunhong.jiang@linux.intel.com>
Subject: Re: The timer softirq on the RT kernel
Date: Fri, 5 Aug 2016 13:17:41 -0700
Message-ID: <20160805131741.63473d41@jnakajim-build>
References: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
	<DDCAE26804250545B9934A2056554AA021106A54@ORSMSX112.amr.corp.intel.com>
	<20160804173641.4defb00b@jnakajim-build>
	<1470364583.3998.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10348 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2995705AbcHEUYc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Aug 2016 16:24:32 -0400
In-Reply-To: <1470364583.3998.4.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 05 Aug 2016 04:36:23 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> On Thu, 2016-08-04 at 17:36 -0700, yunhong jiang wrote:
> > Hi,Mike & Steven
> > 	On https://lkml.org/lkml/2015/3/24/1178, the patch of
> > "timers: do not raise softirq unconditionally" is reverted. Thanks
> > for Steven's
> > detailed comments, it's quite clear explained.
> > 	I remember Mike has a patch trying to fix it but late
> > abandoned. Do you still have any plan to work on this? Otherwise, I
> > will have a try.
> 
> Sebastian converted the lock to raw in -rt, so nohz_full now works
> without any extra hackery.

Hi, Mike, thanks for reply and the update. I still noticed timer softirq
on my isolated CPUs, possibly something wrong on my environment. I will
re-check it.

Thanks
--jyh

> 
> 	-Mike

