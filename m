From: Julia Cartwright <julia@ni.com>
Subject: Re: [ANNOUNCE] 4.1.46-rt52
Date: Mon, 11 Dec 2017 15:23:33 -0600
Message-ID: <20171211212333.GB19068@jcartwri.amer.corp.natinst.com>
References: <20171129231317.GB1361@jcartwri.amer.corp.natinst.com>
 <7b0d39d5-91ab-c8f0-bfec-7e26e71395bd@mvista.com>
 <20171211202017.GA19068@jcartwri.amer.corp.natinst.com>
 <ac092a6e-baaa-9f2f-3655-fc6942d676af@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        <tom.zanussi@linux.intel.com>, Alex Shi <alex.shi@linaro.org>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42368 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751274AbdLKVYX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 16:24:23 -0500
Content-Disposition: inline
In-Reply-To: <ac092a6e-baaa-9f2f-3655-fc6942d676af@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Dec 11, 2017 at 03:01:39PM -0600, Corey Minyard wrote:
> On 12/11/2017 02:20 PM, Julia Cartwright wrote:
> > On Mon, Dec 11, 2017 at 01:04:58PM -0600, Corey Minyard wrote:
[..]
> > > > 
> > > > Sebastian Andrzej Siewior (2):
> > > >         PM / CPU: replace raw_notifier with atomic_notifier (fixup)
> > > This change breaks the compile of 4.1 on ARM (and other things using
> > > kernel/cpu_pm.c).
> > > 
> > > rcu_irq_enter_irqson() and friends doesn't exist in 4.1.  In fact,
> > > rcu_irq_enter() doesn't even exist.
> > > 
> > > Sorry I didn't get to testing this earlier, I've been focused on other things.
> > Thanks!  My current builds apparently don't currently cover CPU_PM
> > builds, so I didn't see this :(.  Thanks for the report.
> > 
> > v4.1 does contain rcu_irq_enter(), and it looks like what we should be
> > using in 4.1 instead.
> 
> Ah, it does, I looked in the wrong place.
> 
> > I'm thinking the below should be okay; I'll be standing up a proper cpu
> > hotplugging test to give it some runtime.
> 
> The below should work.  You'll need an ARM64, ARM or MIPS system with
> the proper config settings to exercise this code, though.

Shouldn't be a problem, I've got an ARM64 board that I've been meaning
to integrate into my testing anyway.

Thanks,
   Julia
