From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 09:43:12 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107230942540.2702@ionos>
References: <alpine.LFD.2.02.1107222203400.2702@ionos> <201107221923.17455.edt@aei.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ed Tomlinson <edt@aei.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107221923.17455.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 22 Jul 2011, Ed Tomlinson wrote:

> On Friday 22 July 2011 16:37:24 Thomas Gleixner wrote:
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 3.0-rt1 release.
> 
> Thomas,
> 
> It does not build here with CONFIG_RCU_TORTURE_TEST=m

Fix queued for -rt2.

Thanks,

	tglx
