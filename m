From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.14.66-rt40] [report][cpuhotplug] BUG: sleeping function
 called from invalid context at kernel/locking/rtmutex.c:974
Date: Thu, 6 Sep 2018 09:39:20 +0200
Message-ID: <20180906073920.mgqunl4sfcsore35@linutronix.de>
References: <4277080d-fbd1-282c-164d-c07796260c36@ti.com>
 <20180829140817.7pr5g2aonbp55fjr@linutronix.de>
 <3aaebda9-a956-55d6-0b04-f84daa6e4866@ti.com>
 <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
 <c744c81c-752e-499e-ffe1-32df30a7831b@ti.com>
 <20180831193053.e3wvssdrxxnw2qah@linutronix.de>
 <1bb777d4-7d72-ecdf-4b78-7d60ec49b815@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1bb777d4-7d72-ecdf-4b78-7d60ec49b815@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-08-31 14:42:25 [-0500], Grygorii Strashko wrote:
> 
> 
> On 08/31/2018 02:30 PM, Sebastian Andrzej Siewior wrote:
> > On 2018-08-31 14:19:53 [-0500], Grygorii Strashko wrote:
> >>
> >> I've tried this and do not see warnings. I'm sending 4.14-rt patches i have as
> >> I could miss smth while cherry-picking.
> > 
> > perfect. Thanks for the confirmation.
> > I saw your three patches. Could you please instead just backport the two
> > patches I have in v4.16 so that it applies on v4.14?
> > 
> 
> Do you mean these two:
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=c7a3334c762a9b1dd2e39cb2ded00ce66e8a06d1
Yes,

> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt&id=e083f14dc2e98ced872bf077b4d1cccf95b7e4f8
no, just 
	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.16.y-rt-rebase&id=d6914631a84f47eaf5647da3bb09d58eca156b3f

Sebastian
