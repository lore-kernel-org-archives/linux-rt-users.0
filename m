From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] oops in 4.1.3-rt3
Date: Tue, 4 Aug 2015 14:05:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508041403550.3983@nanos>
References: <20150803142700.1de720e4@sluggy> <20150804080829.GB9956@opentech.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150804080829.GB9956@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 4 Aug 2015, Nicholas Mc Guire wrote:
> <snip>
>     3 root      -2   0       0      0      0 R  60.3  0.0   5756:16 ksoftirqd/0 
>    23 root      -2   0       0      0      0 R  50.8  0.0   4948:08 ksoftirqd/2
>    17 root      -2   0       0      0      0 S  50.6  0.0   4897:13 ksoftirqd/1
>    29 root      -2   0       0      0      0 S  50.4  0.0   4953:24 ksoftirqd/3

So ksoftirqd eats 50+% CPU on each core. On an idle system!?! Any
chance that you can get a function trace snapshot out of it?

Thanks,

	tglx
