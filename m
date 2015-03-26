From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 26 Mar 2015 07:27:30 +0100
Message-ID: <1427351250.3497.49.camel@gmail.com>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427347391.3497.25.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2015-03-26 at 06:23 +0100, Mike Galbraith wrote:

> I plan on taking a poke at getting "don't raise timer unconditionally"
> working again when I get myself unburied, and see if I can come up with
> a somewhat less icky way to work around take rtmutex in irq naughtiness.

Hm.. like maybe only do a fasttrylock with the wait lock already held
via trylock, and don't bother turning it loose until we're done, to keep
the sane people away.  That might work.. but may not be considered less
icky by people equipped with that mysterious "taste" thingy ;-)

	-Mike
