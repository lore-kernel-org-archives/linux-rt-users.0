From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.6.3-rt7
Date: Sat, 27 Oct 2012 00:08:00 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210270006130.2756@ionos>
References: <alpine.LFD.2.02.1210262036270.2756@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1210262036270.2756@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 Oct 2012, Thomas Gleixner wrote:

> Dear RT Folks,
> 
> I'm pleased to announce the 3.6.3-rt7 release.
> 
> Changes since 3.6.3-rt6:
> 
>    * Enable SLUB for RT
> 
>      Last time I looked at SLUB for RT (some years ago) it was just
>      way more painful than dealing with SLAB, but Christoph Lameter
>      has done major surgery on the SLUB code since then and it turns
>      out that making SLUB usable for RT has become very simple. Thanks
>      Christoph!
> 
>       slab.c: 172 insertions(+), 58 deletions(-)
>       slub.c:  17 insertions(+), 13 deletions(-)
> 
>      I did some quick comparisons and even a simple hackbench run
>      shows a significant speedup with SLUB vs. SLAB on RT. I'm not too
>      surprised as SLUBs fastpath does not have the RT induced
>      contention problems which we can observe with SLAB.
> 
>      As usual, give it a good testing and report whatever explodes :)

Looks like CONFIG_NUMA=y exposes explosions. I just noticed that none
of the machines which are in my basic set of test systems have that
enabled.

/me goes to do some homework
