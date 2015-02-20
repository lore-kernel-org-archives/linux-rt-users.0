From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT v2] kernel/res_counter.c: Change lock of struct res_counter
 to raw_spinlock_t
Date: Fri, 20 Feb 2015 13:53:24 -0500
Message-ID: <54E782A4.3030502@windriver.com>
References: <1420745917-50747-1-git-send-email-tmac@hp.com> <1422644389-33074-1-git-send-email-tmac@hp.com> <20150213191909.GA8299@windriver.com> <54DE6AD5.9070000@hp.com> <20150213213016.GC7102@windriver.com> <20150218110552.GE28763@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	<rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218110552.GE28763@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2015-02-18 06:05 AM, Sebastian Andrzej Siewior wrote:
> * Paul Gortmaker | 2015-02-13 16:30:17 [-0500]:
>
> there is the thread "[v3.10-rt / v3.12-rt] scheduling while atomic in
> cgroup code" where I applied Mike's patch. This should fix the problem
> reported and be part of the next release.
> Could please double check (either by grabing the patch or waiting for
> the next release).

I've applied Mike's patch from here:

     https://lkml.org/lkml/2014/6/21/11

and tested it on the old dell core2 that reliably showed the splat
at boot, and it is now gone.  This is on vanilla 3.14-rt plus isci
fix + simpleworkqueue + aio-swq fix (all pending for 3.18-rt next).

I also tested it on the 20 core canoe pass where the rawlock
conversion patch from Thavatchai caused strange and unpredictable 
failure modes and that box seems fine with this smaller footprint 
cpulight change.

Paul.
--

>
> Sebastian
>
