From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Fri, 24 Jul 2015 15:21:59 -0400
Message-ID: <20150724152159.79543722@gandalf.local.home>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
	<alpine.DEB.2.11.1507091605410.5134@nanos>
	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
	<20150710132318.GA27402@linutronix.de>
	<e1b9f04b95504df78cab1eb4e6946238@FE-MBX1012.de.bosch.com>
	<55A36EF0.7020404@linutronix.de>
	<15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
	<55A37DC9.6050604@linutronix.de>
	<55A607CC.3030808@etas.com>
	<12C1B74BDFD05D40B2356A9B12DFA3396C276FDBA2@KEBMXSPMB01.keba.co.at>
	<20150720145648.GA9559@linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA3396C27797F4A@KEBMXSPMB01.keba.co.at>
	<b4572ce5932444febd055f1403c58d9e@FE-MBX1012.de.bosch.com>
	<20150722092635.0766400e@gandalf.local.home>
	<alpine.DEB.2.11.1507242054570.18576@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	eg Engleder Gerhard <eg@keba.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:54398 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753197AbbGXTWD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2015 15:22:03 -0400
In-Reply-To: <alpine.DEB.2.11.1507242054570.18576@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 24 Jul 2015 21:02:26 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 22 Jul 2015, Steven Rostedt wrote:
> > It's still there. Note, that when I pull -rt into stable, I do a
> >  git quiltimport, which renames the patch set. It's now called:
> > 
> >  0089-slub-delay-ctor-until-the-object-is-requested.patch
> 
> >From the 4.0.8-rt6 announce:
> 
> - The delayed kmem_cache constructor caused problems. Steven Rostedt
>   reported problems versus the signal handling code and Koehrer
>   Mathias reported the same. The patch in question has been reverted
>   and a patch currently sitting in -mm has been added which provides
>   the same functionality (running the constructor with enabled
>   interrupts). Patch provided by Thomas Gleixner. 
> 
> The stable trees which carry the delay-ctor patches should be updated
> to this.
> 
> Reverting the patch at least prevents the BUG. Latencywise the slub patch
> 
>    mm-slub-move-slab-initialization-into-irq-enabled-re.patch
> 
> is the one which wants to be ported back.
> 

OK, thanks.

Just to let people know. I'm going to be traveling next week and when I
get back in August, my top priority is to work on the stable patches.
For 3.18, I'll be looking at the patches that have been emailed to the
list, and I want to fix NO_HZ for 3.10-3.14.

I'll be also looking at the patches in the latest development RT
release that needs to be backported.

-- Steve
