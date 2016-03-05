From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Fix preempt-rt on AT91
Date: Sat, 5 Mar 2016 12:35:53 +0100
Message-ID: <20160305113553.GB21216@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160118174259.GC12309@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

On 18/01/2016 at 18:42:59 +0100, Sebastian Andrzej Siewior wrote :
> > 3/ Finally, the kernel will crash when initializing the PMC driver. This is
> > solved by this series that will hopefully land in the mainline:
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390954.html
> 
> This is new, isn't it? So the series in currently in v3 and people seem
> happy with it. Please poke me once with the commit ids once it is merged
> on its way upstream and I will try cherry-pick them from next or so.
> 

The series landed in arm-soc and is making its way to v4.6. I guess you
can pull the original pull request. It is based on v4.5-rc1 but should
apply cleanly on v4.4:

The following changes since commit
92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
tags/at91-ab-4.6-drivers

for you to fetch changes up to 0002ca168f16e5b6ac67415a4e0198cc39af2b7f:

  clk: at91: remove useless includes (2016-02-17 17:53:04 +0100)




You may also stop at 99a81706526fb167029a940ef1f7bfbe882abd3e which
should solve the crash but it has not been tested as thoroughly.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
