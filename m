From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: arm: at91: do not disable/enable clocks in a row
Date: Thu, 17 Mar 2016 19:09:49 +0100
Message-ID: <20160317180949.GE2831@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
 <20160305113553.GB21216@piout.net>
 <20160308110639.GC21842@linutronix.de>
 <20160308183910.GD5845@piout.net>
 <20160309095824.GC10517@linutronix.de>
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
In-Reply-To: <20160309095824.GC10517@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/03/2016 at 10:58:24 +0100, Sebastian Andrzej Siewior wrote :
> * Alexandre Belloni | 2016-03-08 19:39:10 [+0100]:
> 
> >Hi,
> Hi,
> 
> >Both are things to work on. In the mean time, I'm using the following
> >patch:
> >https://github.com/alexandrebelloni/linux/commit/3a2eae463fce18ae815b887a5c9ca1a657b180ac
> >
> >I understood from
> >http://lkml.iu.edu/hypermail/linux/kernel/1601.2/00941.html that this
> >was not your preferred course of action.
> 
> That was one thing.  What about this:
> 
> ---
> 
> Currently the driver will disable the clock and enable it one line later
> if it is switching from periodic mode into one shot.
> This can be avoided and causes a needless warning on -RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'm fine with that if you don't want to rely on the clock event state
machine.

Can you submit it to the mainline with:
Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
