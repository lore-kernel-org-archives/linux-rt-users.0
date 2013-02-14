From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] 3.4.28-rt40 tglx fix imx.c spinlock
Date: Thu, 14 Feb 2013 23:35:03 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302142334120.22263@ionos>
References: <6003615.pRQnIgKCSn@dabox> <3970144.HqS49ZSYWh@dabox> <alpine.LFD.2.02.1302131828050.22263@ionos> <16398840.IK9i4U2q2d@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16398840.IK9i4U2q2d@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Feb 2013, Tim Sander wrote:
> > That's true, but w/o seing the OOM output I can't tell what's
> > exhausting the memory.
> When fuzzing the serial port one probably should switch of sysreq. It seems 
> as if there is a break send somehow and then it selects the OOM option.
> So when switching of MAGIC_SYSRQ the OOMs are gone. So its a non issue.

Amazing that you get the break+oom combo out of that fuzzer!
