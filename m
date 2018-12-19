From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT-Kernel boot stalls because of change in fs/dcache.c
Date: Wed, 19 Dec 2018 12:36:51 +0100
Message-ID: <20181219113650.ak3wj3h3oapfy3tj@linutronix.de>
References: <cfff1645-aab1-7b39-5f75-31b94f3365d1@kontron.de>
 <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4aa4a0f1-373f-4978-42b1-6b676d6f1950@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-19 07:50:17 [+0000], Schrempf Frieder wrote:
> + linux-rt-users
> 
> On 17.12.18 11:42, Frieder Schrempf wrote:
> > Hi,
> > 
> > I have tried to boot a 4.14-Kernel with the RT-patches and 
> > PREEMPT_RT_FULL on an i.MX6UL board. Unfortunately the boot stalls at 
> > some point and never finishes.
> > 
> > I did some bisecting and found out, that reverting this change: [1], 
> > makes the board boot correctly.
> > 
> > Can anyone help to come up with a proper fix for this?

can you check if the hashtable is initialized twice?

> > Thanks,
> > Frieder
> > 
> > [1]: 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.14-rt&id=56684d21f7f8341f7a5ed1433714112f49294590 

Sebastian
