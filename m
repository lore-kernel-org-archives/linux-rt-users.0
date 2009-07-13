From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Mon, 13 Jul 2009 12:14:40 +0200
Message-ID: <1247480080.7529.66.camel@twins>
References: <200907102350.47124.henrik@austad.us>
	 <1247336891.9978.32.camel@laptop>  <1247478955.8107.24.camel@Palantir>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Henrik Austad <henrik@austad.us>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	"James H. Anderson" <anderson@cs.unc.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
	Ted Baker <baker@cs.fsu.edu>,
	Dhaval Giani <dhaval.giani@gmail.com>
To: Raistlin <raistlin@linux.it>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755370AbZGMKOt@vger.kernel.org>
In-Reply-To: <1247478955.8107.24.camel@Palantir>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2009-07-13 at 11:55 +0200, Raistlin wrote:
> > Thing is, both BWI and PEP seems to work brilliantly on Uni-Processor
> > but SMP leaves things to be desired. Dhaval is currently working on a
> > PEP implementation that will migrate all the blocked tasks to the
> > owner's cpu, basically reducing it to the UP problem.
> > 
> Nice... Only one question, doesn't this impact with task affinity
> related issues?

No :-), well maybe.

Since the task is blocked and will this not actually run, we can place
it on any CPU, only once it becomes runnable again should we take care
to place it on a CPU that's part of its affinity mask.

Of course, underlying this is the question of what to do for
'partitioned' tasks sharing a resource. I think we've talked about this
a few times.

Since these 'partitioned' tasks do share a resource, they're not really
all that partitioned, and I think the best way to keep the system going
is to simply Inherit/Donate/Proxy right through the partition.

~ Peter
