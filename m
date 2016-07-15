From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v3.14.73-rt77 build: 6 failures 10 warnings (v3.14.73-rt77)
Date: Fri, 15 Jul 2016 22:58:43 +0200
Message-ID: <2832430.yoY9mz5Why@wuerfel>
References: <E1bNvA3-0006oU-Ex@optimist> <20160715120837.GC11606@linutronix.de> <20160715143410.7da7d02c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linaro-kernel@lists.linaro.org,
	Build bot for Mark Brown <broonie@kernel.org>,
	kernel-build-reports@lists.linaro.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160715143410.7da7d02c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday, July 15, 2016 2:34:10 PM CEST Steven Rostedt wrote:
> > * Arnd Bergmann | 2016-07-15 09:42:40 [+0200]:
> > 
> > >On Friday, July 15, 2016 5:55:39 AM CEST Build bot for Mark Brown wrote:  
> > >> 
> > >>         arm64-allnoconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> > >> 
> > >>         arm64-allmodconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> > >> 
> > >>         arm-multi_v7_defconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> > >> 
> > >>         arm-allmodconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> > >> 
> > >>         arm-allnoconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]
> > >> 
> > >>         arm64-defconfig
> > >> /home/broonie/build/linux-stable-rt/include/asm-generic/preempt.h:10:9: error: implicit declaration of function 'READ_ONCE' [-Werror=implicit-function-declaration]  
> > >
> > >These all started failing yesterday with v3.14.72-rt76, before it was
> > >
> > >     v3.14.72-rt75 build: 0 failures 113 warnings (v3.14.72-rt75)
> > >
> > >     Arnd  
> > 
> 
> Arnd,
> 
> Does this fix the issue?
> 

>From looking at it I'm fairly sure it addresses the build problem,
and semantically it looks correct as well, but I haven't had a
chance to test it on my machine yet.

The build results above come from Mark Brown's automated build setup,
so your testing is as good as mine in reproducing it.

	Arnd
