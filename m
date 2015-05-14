From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
Date: Thu, 14 May 2015 18:24:09 +0100
Message-ID: <20150514172409.GG19345@e104818-lin.cambridge.arm.com>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
 <20150514153937.GB13442@linutronix.de>
 <20150514154215.GE18984@arm.com>
 <CAMAWPa_UA3GgHGkcYkgUJUB8Y6KJS38z-2-=E6PKmGT=tGWh3A@mail.gmail.com>
 <20150514171056.GH18984@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Hilman <khilman@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	"ayyappa.ch.linux@gmail.com" <ayyappa.ch.linux@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"kevin.hilman@linaro.org" <kevin.hilman@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40091 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235AbbENRYO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 13:24:14 -0400
Content-Disposition: inline
In-Reply-To: <20150514171056.GH18984@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 14, 2015 at 06:10:56PM +0100, Will Deacon wrote:
> On Thu, May 14, 2015 at 06:09:23PM +0100, Kevin Hilman wrote:
> > On Thu, May 14, 2015 at 8:42 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, May 14, 2015 at 04:39:37PM +0100, Sebastian Andrzej Siewior wrote:
> > >> * Anders Roxell | 2015-04-27 22:53:08 [+0200]:
> > >>
> > >> >Mark the PMU interrupts as non-threadable, as is the case with
> > >> >arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD
> > >> >
> > >> >Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >> >Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > >> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >>
> > >> Could this please go via the arm64 tree?
> > >
> > > I already acked it:
> > >
> > >   https://lkml.org/lkml/2015/4/23/161
> > >
> > > so it will be picked up for 4.2.
> > 
> > Which tree is at applied to?  I'm not seeing it in -next, and couldn't
> > find it in any branches of the arm64 tree[1].  Sorry to pester, I'm
> > just looking to cherry-pick it from it's proper upstream for testing
> > with a stable/3.18 based kernel.
> 
> I don't think Catalin has started putting together our for-next/core branch
> yet, but I'd expect it to appear there when he picks it up.

I'll push it out after -rc4 (i.e. next week).

-- 
Catalin
