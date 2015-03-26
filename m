From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 26 Mar 2015 07:01:04 +0100
Message-ID: <1427349664.3497.37.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
	 <1426753029.4168.80.camel@gmail.com>
	 <20150319122611.0d002d48@gandalf.local.home> <550AFC6A.4050901@hp.com>
	 <1426960943.4677.34.camel@gmail.com> <1427085774.3151.7.camel@gmail.com>
	 <55136C2A.60508@hp.com> <1427347391.3497.25.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36837 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbCZGBH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Mar 2015 02:01:07 -0400
In-Reply-To: <1427347391.3497.25.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-03-26 at 06:23 +0100, Mike Galbraith wrote:
> On Wed, 2015-03-25 at 20:17 -0600, Thavatchai Makphaibulchoke wrote:
> > 
> > On 03/22/2015 10:42 PM, Mike Galbraith wrote:
> > >> Why can't we just Let swapper be the owner when in irq with no dummy?
> > >>
> > 
> > Thanks Mike for the suggestion.  That may also work. Unfortunately
> > somehow I'm still having a hung problem, which may be related to the
> > priority of the interrupt handler task.
> > 
> > >> I have "don't raise timer unconditionally" re-applied, the check for a
> > >> running callback bits of my nohz_full fixlet, and the below on top of
> > >> that, and all _seems_ well.
> > > 
> > > But not so well on 64 core box.  That has nothing to do with hacklet
> > > though, re-applying timers-do-not-raise-softirq-unconditionally.patch
> > > without thta hangs the 64 core box during boot with no help from me
> > > other than to patchlet to let nohz work at all, seems there's another
> > > issue lurking there.  Hohum.  Without 'don't raise..", big box is fine.
> > > 
> > 
> > If you get your patch to work, I could try my test that was able to
> > reproduce the problem consistently.
> 
> If you had "don't raise timer unconditionally" applied, no surprise, my
> big box hangs too with or without hacklet.  If didn't have it applied,
> you don't need the hack.  If you had both and rtmutex debugging turned
> on, posted version _should_ explode, as it didn't bother to side-step
> that bit (et al).

Oh, and if you didn't have the below enabled, you'll certainly hang.

rt-nohz_full-fix-nohz_full-for-PREEMPT_RT_FULL.patch

	-Mike

