From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Wed, 19 Aug 2015 22:58:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508192257300.3873@nanos>
References: <20150803142700.1de720e4@sluggy> <20150804080829.GB9956@opentech.at> <alpine.DEB.2.11.1508041403550.3983@nanos> <20150816115859.GD7004@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150816115859.GD7004@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 16 Aug 2015, Sebastian Andrzej Siewior wrote:
> * Thomas Gleixner | 2015-08-04 14:05:10 [+0200]:
> 
> >On Tue, 4 Aug 2015, Nicholas Mc Guire wrote:
> >> <snip>
> >>     3 root      -2   0       0      0      0 R  60.3  0.0   5756:16 ksoftirqd/0 
> >>    23 root      -2   0       0      0      0 R  50.8  0.0   4948:08 ksoftirqd/2
> >>    17 root      -2   0       0      0      0 S  50.6  0.0   4897:13 ksoftirqd/1
> >>    29 root      -2   0       0      0      0 S  50.4  0.0   4953:24 ksoftirqd/3
> >
> >So ksoftirqd eats 50+% CPU on each core. On an idle system!?! Any
> >chance that you can get a function trace snapshot out of it?
> 
> This might be a .config thing, device driver or user land behaviour.
> Usually ksoftirqd should remain (almost) idle because most of BH work
> remains in task-context and not in ksoftirqd. tasklets for instance
> should run in ksoftirqd. So a function trace or event tracing to figure
> out what is scheduling the softirq might give a pointer.
> I have here a AMD box with
> 
>  3 root      -2   0       0      0      0 S   1.3  0.0 126:16.31 ksoftirqd/0                                                                                          
> 18 root      -2   0       0      0      0 S   1.3  0.0 136:55.85 ksoftirqd/1                                                                                          
> 30 root      -2   0       0      0      0 S   1.3  0.0 138:50.52 ksoftirqd/3                                                                                          
> 24 root      -2   0       0      0      0 S   1.0  0.0 143:54.28 ksoftirqd/2                                                                                          
> 
> with a 15 days uptime. That one percent CPU usage on a idle system looks
> odd here, too.

Not really. If ksoftirqd takes 13us per invocation and you run with
HZ=1000 then this is reasonable.

Thanks,

	tglx
