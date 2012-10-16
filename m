From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.1-rt2
Date: Tue, 16 Oct 2012 23:12:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210162311490.2811@ionos>
References: <alpine.LFD.2.02.1210162037380.2811@ionos> <CAP=VYLoHhtth2+BwQAsd7uyW8N+rJj6zznP9sNjczTj_0Uqk9w@mail.gmail.com> <CAOLSsAyV3XdJvNvFF_6d_oLnApyQVs4UoAJ0rPpABxkaGGxX1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOLSsAyV3XdJvNvFF_6d_oLnApyQVs4UoAJ0rPpABxkaGGxX1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 16 Oct 2012, Javier Sanz wrote:

> Hello,
> 
> Testing, and FYI
> 
> $uname -a
> Linux darkstar 3.6.1-rt2 #1 SMP PREEMPT RT Tue Oct 16 22:47:06 CEST 2012
> i686 i686 i386 GNU/Linux
> 
> >>shows all time  ...
> 
> [   30.543233] fuse init (API version 7.20)
> [   33.262077] Crap, ksoftirqd/0 looping forever in softirq
> [   33.344865] Crap, ksoftirqd/2 looping forever in softirq
> [   33.401736] Crap, ksoftirqd/0 looping forever in softirq
> [   33.409743] Crap, ksoftirqd/0 looping forever in softirq
> [   33.421658] Crap, ksoftirqd/0 looping forever in softirq
> [   33.428628] Crap, ksoftirqd/0 looping forever in softirq
> [   33.496468] Crap, ksoftirqd/2 looping forever in softirq

Grrr. Forgot to remove that printk. Will do in the next spin.
