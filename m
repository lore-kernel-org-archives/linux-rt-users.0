From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after
 console_init
Date: Thu, 20 May 2010 11:47:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005201142360.3368@localhost.localdomain>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>  <AANLkTinClrTDoXH4NPP2-SgSYH24ZTnqsop88aocdg4R@mail.gmail.com>  <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>  <201005201233.56877@zigzag.lvk.cs.msu.su>
 <AANLkTilEbFndi-rPczi6OBxeU8p87gOz4yfveEsyHqcE@mail.gmail.com> <AANLkTil18TnOR9D-dSFsSFA74Q4UFnldrGLhG1H4jwhf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sujit K M <sjt.kar@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTil18TnOR9D-dSFsSFA74Q4UFnldrGLhG1H4jwhf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Please stop top posting !

On Thu, 20 May 2010, Sujit K M wrote:

> >>> Well, obviously it's unsafe if you remove safety checks. And if you
> >>> care to look at the changelog of kernel/printk.c you'll find out why.
> >>
> >> Hmm... did a quick look and could not find anything related there.
> >> Could you please give a pointer?

Gah, yes. The changelog of the commit is not really helpful. Let me
explain:

The console drivers might take locks, which are converted to "sleeping
locks" in preempt-rt. As a result we cannot call into those drivers
from atomic contexts. And that's what the checks in the printk code
prevent.

Hope that helps.

Thanks,

	tglx
