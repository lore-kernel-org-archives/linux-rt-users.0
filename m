From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [BUG] 2.6.23-rc1-rt2
Date: Wed, 25 Jul 2007 12:38:18 -0700
Message-ID: <1185392298.5146.80.camel@sven.thebigcorporation.com>
References: <20070725175925.GA2992@ittc.ku.edu>
	 <1185389357.2573.229.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Noah Watkins <nwatkins@ittc.ku.edu>, mingo@elte.hu,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alnrmhc16.comcast.net ([204.127.225.96]:61889 "EHLO
	alnrmhc16.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758415AbXGYTiX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 15:38:23 -0400
In-Reply-To: <1185389357.2573.229.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-07-25 at 11:49 -0700, Daniel Walker wrote:
> 
> > Also, this kernel boots up EXTREMELY slow. once it is booted, the
> timer
> > soft-irqs on both cpus run (according to top) at about 4% of the CPU
> > constantly. X is very jerky, I assume because of the soft-irqs
> running
> > so much...?
> 


On my 8 core, I consistently get a watchdog after applying the following
patch:

After the watchdog pops, things go back to normal speed.

Date:	Tue, 17 Jul 2007 17:49:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org, Greg KH <greg@kroah.com>, Chris Wright <chrisw@sous-sol.org>
Subject: [patch] fix the softlockup watchdog to actually work
Message-ID: <20070717154934.GA24231@elte.hu>
References: <20070717114453.GA8212@elte.hu> <469CCF8F.4010107@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469CCF8F.4010107@goop.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Received-SPF: softfail (mx3: transitioning domain of elte.hu does not
	designate 157.181.1.14 as permitted sender) client-ip=157.181.1.14;
	envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00
	autolearn=no SpamAssassin version=3.0.3 -1.0 BAYES_00               BODY:
	Bayesian spam probability is 0 to 1% [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Evolution-Source: imap://sven@sx.thebigcorporation.com/
Content-Transfer-Encoding: 8bit


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> > Subject: softlockup: fix Xen bogosity
> > From: Ingo Molnar <mingo@elte.hu>
> >
> > this Xen related commit:
> >   
> 
> Well, not just Xen.  It relates to any virtual environment: kvm, 
> lguest, vmi, xen...  (Not that they all implement a measure of 
> unstolen time.)
> 
> How about a more descriptive patch title, along the lines of 
> "softlockup watchdog: fix rate limiting"?

uhm, the problem was that it did not work _at all_, not something about 
'rate limiting'. Yes, i got quite a bit grumpy when i found this, 
because you completely broke the softlockup watchdog via a pretty 
intrusive commit and you apparently didnt even do a minimal check 
whether its functionality was preserved! Updated patch for Andrew/Linus 
and for -stable attached.

	Ingo

----------------------------->
Subject: fix the softlockup watchdog to actually work
From: Ingo Molnar <mingo@elte.hu>

this Xen related commit:

   commit 966812dc98e6a7fcdf759cbfa0efab77500a8868
   Author: Jeremy Fitzhardinge <jeremy@goop.org>
   Date:   Tue May 8 00:28:02 2007 -0700

       Ignore stolen time in the softlockup watchdog

broke the softlockup watchdog to never report any lockups. (!)

print_timestamp defaults to 0, this makes the following condition
always true:

	if (print_timestamp < (touch_timestamp + 1) ||

and we'll in essence never report soft lockups.

apparently the functionality of the soft lockup watchdog was never
actually tested with that patch applied ...

[this is -stable material too.]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/softlockup.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux/kernel/softlockup.c
===================================================================
--- linux.orig/kernel/softlockup.c
+++ linux/kernel/softlockup.c
@@ -79,10 +79,11 @@ void softlockup_tick(void)
 	print_timestamp = per_cpu(print_timestamp, this_cpu);
 
 	/* report at most once a second */
-	if (print_timestamp < (touch_timestamp + 1) ||
-		did_panic ||
-			!per_cpu(watchdog_task, this_cpu))
+	if ((print_timestamp >= touch_timestamp &&
+			print_timestamp < (touch_timestamp + 1)) ||
+			did_panic || !per_cpu(watchdog_task, this_cpu)) {
 		return;
+	}
 
 	/* do not print during early bootup: */
 	if (unlikely(system_state != SYSTEM_RUNNING)) {
-
