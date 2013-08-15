From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Thu, 15 Aug 2013 11:42:55 -0700
Message-ID: <520D212F.7030400@localhost>
References: <20130812163413.GI23040@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130812163413.GI23040@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/12/2013 09:34 AM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v3.10.6-rt3 patch set.

I'm getting this when trying to build:

drivers/md/bcache/request.c: In function 'cached_dev_write_complete':
drivers/md/bcache/request.c:1008:2: error: implicit declaration of=20
function 'up_read_non_owner' [-Werror=3Dimplicit-function-declaration]
   up_read_non_owner(&dc->writeback_lock);
   ^
drivers/md/bcache/request.c: In function 'request_write':
drivers/md/bcache/request.c:1034:2: error: implicit declaration of=20
function 'down_read_non_owner' [-Werror=3Dimplicit-function-declaration=
]
   down_read_non_owner(&dc->writeback_lock);
   ^
cc1: some warnings being treated as errors

Does not look like *_read_non_owner exist in rwsem_rt.h...
-- Fernando


> Changes since v3.10.6-rt2
> - the queue can be imported with git quiltimport
> - powerpc compiles again. Thanks to Paul Gortmaker for the patch.
> - added three patches from v3.8 which fall the wagon on their way to
>    3.10. One of them enables RT-FULL on ARM :)
> - removed all cpsw patches from the queue. They made it upstream. My
>    nfsboot setup seems not to work, lets look at this later.
> - make arm/spear compile. Thanks to Felipe Balbi for the patch.
> - Add a patch from Corey Minyard to no longer use deprecated
>    CONFIG_NO_HZ.
> - add the one patch which I added to the last 3.8-rt to get get list_=
bl
>    work again on !SMP && !DEBUG_SPINLOCK
> - Spell "preemptible" properly in "Preemptible Kernel (Basic RT)" men=
u
>    item. Thanks to Uwe Kleine-K=C3=B6nig for the patch.
> - a patch from John Kacur to avoid a warning in the hpsa.
> - a patch for the ppc5200 where the compiler thinks a variable isn't
>    initialized and stops compililing due to -Werror
>
> Known issues:
>
>        - SLAB support not working
>
>        - The cpsw network driver shows some issues.
>
>        - ARM & PPC don't fall apart once booted. More testing doesn't
>          hurt.
>
>        - bcache with CONFIG_DEBUG_LOCK_ALLOC enabled does not compile=
=2E
=2E..
