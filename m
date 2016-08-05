From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: The timer softirq on the RT kernel
Date: Fri, 05 Aug 2016 04:36:23 +0200
Message-ID: <1470364583.3998.4.camel@gmail.com>
References: <CAC6yHM4kTvXiJwsyFqmi3p_4U8a54wwUJz9QFHAGsO+aM6G6Wg@mail.gmail.com>
	 <DDCAE26804250545B9934A2056554AA021106A54@ORSMSX112.amr.corp.intel.com>
	 <20160804173641.4defb00b@jnakajim-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	rostedt@goodmis.org
To: yunhong jiang <yunhong.jiang@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804173641.4defb00b@jnakajim-build>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2016-08-04 at 17:36 -0700, yunhong jiang wrote:
> Hi,Mike & Steven
> 	On https://lkml.org/lkml/2015/3/24/1178, the patch of "timers:
> do not raise softirq unconditionally" is reverted. Thanks for
> Steven's
> detailed comments, it's quite clear explained.
> 	I remember Mike has a patch trying to fix it but late
> abandoned. Do you still have any plan to work on this? Otherwise, I
> will have a try.

Sebastian converted the lock to raw in -rt, so nohz_full now works
without any extra hackery.

	-Mike
