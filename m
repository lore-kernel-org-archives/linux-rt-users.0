From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 26 Mar 2015 09:53:02 -0400
Message-ID: <20150326095302.2998cbe4@gandalf.local.home>
References: <20150317163541.080310081@goodmis.org>
	<20150317163617.218582800@goodmis.org>
	<20150317163551.3093b6c2@gandalf.local.home>
	<1426753029.4168.80.camel@gmail.com>
	<20150319122611.0d002d48@gandalf.local.home>
	<550AFC6A.4050901@hp.com>
	<1426960943.4677.34.camel@gmail.com>
	<1427085774.3151.7.camel@gmail.com>
	<55136C2A.60508@hp.com>
	<1427347391.3497.25.camel@gmail.com>
	<1427351250.3497.49.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:34139 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752400AbbCZNxF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Mar 2015 09:53:05 -0400
In-Reply-To: <1427351250.3497.49.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 26 Mar 2015 07:27:30 +0100
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:

> On Thu, 2015-03-26 at 06:23 +0100, Mike Galbraith wrote:
> 
> > I plan on taking a poke at getting "don't raise timer unconditionally"
> > working again when I get myself unburied, and see if I can come up with
> > a somewhat less icky way to work around take rtmutex in irq naughtiness.
> 
> Hm.. like maybe only do a fasttrylock with the wait lock already held
> via trylock, and don't bother turning it loose until we're done, to keep
> the sane people away.  That might work.. but may not be considered less
> icky by people equipped with that mysterious "taste" thingy ;-)

You would still need to add some ownership so that all will fail the
fast path.

You mean create a spin_trylock_in_hirq() which would just lock
the waitlock and not even do the fast path with the rt_mutex.

	if (!raw_spin_trylock(waitlock))
		goto failed_lock;

	if (!try_to_take_rt_mutex()) {
		raw_spin_unlock(waitlock);
		goto failed_lock;
	}

	return success;


With the waitlock held, no slow path will get to the pi code. Then you
have a spin_unlock_in_hirq() that would go right into the slow path
assuming the waitlock is already held.

Sounds reasonable to me.

-- Steve


	
