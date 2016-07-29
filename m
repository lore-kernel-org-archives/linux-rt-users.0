From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v4.4.12-rt20 build: 0 failures 5 warnings (v4.4.12-rt20)
Date: Fri, 29 Jul 2016 17:23:58 +0200
Message-ID: <20160729152358.GC21715@linutronix.de>
References: <E1bNugf-00064t-KA@optimist>
 <2319169.Jp9upmpu5F@wuerfel>
 <20160715132305.GD11606@linutronix.de>
 <77528485.4aTSS092zh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77528485.4aTSS092zh@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Arnd Bergmann | 2016-07-15 21:48:55 [+0200]:

>I also notice that your "tty: serial: 8250: don't take the trylock
>during oops" patch would apply on the pl011 driver as well.

That one. That is something I am not really sure about in the long run. On
-RT we can't try_lock() with IRQs off and that is why I removed it.
You could do the same with pl011 but you are screwed anyway because
clk_enable() will take a sleeping lock and that is a no no.

So you could stay with the try_lock because it does not solve anything.
In the long run I though about a console flag which denotes the console
as RT-IRQ save which is the case for 8250 but not for pl011 (due to
clk_enable()) so should not get on -RT into this case where it matters.

On the other hand if you oops on !RT+UP in your uart driver while
holding the lock then the try_lock will fail resulting in a lockdep
splat (because try_lock should not fail on UP). So might want take it as
a procation in that case :)

>Sure, that always works, it's just a bit ugly since the flags word
>should never be zero when it gets written back to the hardware irq
>state, at least in portable code.

yes :)

>Maybe something like the version below?

sure.

Sebastian
