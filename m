From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.10.4-rt1
Date: Fri, 02 Aug 2013 14:45:00 +0200
Message-ID: <51FBA9CC.2090206@linutronix.de>
References: <alpine.DEB.2.02.1308011215160.4089@ionos.tec.linutronix.de>  <CAP=VYLp1ERhS4cFtgXGHL2DfCGoJ9VbPvShH5ZOWCpPuSzQY6w@mail.gmail.com> <1375419917.3743.93.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375419917.3743.93.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/02/2013 07:05 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-01 at 20:03 -0400, Paul Gortmaker wrote:
>> I've added Ben to the CC in case he has a suggestion on
>> how best to fix this, even though it is not yet mainline.
> 
> Can you exchange with a TIF_ that isn't used in asm ? For example
> TIF_PERFMON_* ? Keep all the asm ones below 16 and move up the ones
> that are used in C only ?

I going to look later at this. I think I swapped one of the TIF_
defines in v3.8 so it should work.

> 
> Cheers,
> Ben.
> 

Sebastian
