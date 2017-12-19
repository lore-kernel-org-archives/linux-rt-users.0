From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 16:33:10 +0100
Message-ID: <20171219153310.aq2rxw6umgyyku3p@linutronix.de>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
 <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
 <20171219100202.3017a79f@gandalf.local.home>
 <20171219150418.vz6hkpf4uuangb4q@linutronix.de>
 <20171219102839.367fa92d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49186 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbdLSPdN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Dec 2017 10:33:13 -0500
Content-Disposition: inline
In-Reply-To: <20171219102839.367fa92d@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-19 10:28:39 [-0500], Steven Rostedt wrote:
> On Tue, 19 Dec 2017 16:04:18 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > 
> > > The above just seems wrong. local_irq_disable() should imply
> > > local_bh_disable(), as it doesn't let softirqs run either.  
> > 
> > Where does local_irq_disable() imply this?
> 
> If it doesn't explicitly do so, it probably should. How can we have a
> softirq execute when irqs are disabled?

There are not. With local_bh_disable() the softirq will run on
local_bh_enable(). Without it (and with or without local_irq_disable())
the softirq won't run but wakeup the ksoftirq thread. We can't do the
wake while holding the hrtimer lock. This is not RT specific.

> -- Steve

Sebastian
