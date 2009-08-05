From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] linux-2.6.31-rc5-rt1.1
Date: Wed, 5 Aug 2009 19:25:38 +0200
Message-ID: <20090805172538.GA3577@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752183AbZHER0b@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

While Thomas Gleixner is away at summer camp, Clark Williams and myself
decided to release an unofficial preempt-rt kernel to prevent the -rt code from
developing bit rot. Unofficial until Thomas either blesses it with some Weizen
or slaps us with a large stinkin' trout.

We are pleased to present

-linux-2.6.31-rc5-rt1.1

This kernel is an incremental release.
It rebases linux-2.6.31-rc4-rt1 to linux-2.6.31-rc5
In-addition we added the following patches

- stacktrace-dump_out_last_preempt_disable_locations.patch
- futex_wait_requeue_pi_commentary_corrections.patch
- hw_lat-simple-solution-001.patch

stacktrace-dump_out_last_preempt_disable_locations.patch
is a rewrite by Steven Rostedt of an Ingo Molnar patch. It is useful for
tracing, since it shows the last location that preemption was disabled.

futex_wait_requeue_pi_commentary_corrections.patch
Was posted to the rt-users list by Darren Hart to fix some of the comments in
his futex code.

hw_lat-simple-solution-001.patch
Is a fix from Luis Claudio R.Goncalves for the hardware latency detector.
It fixes a problem where wake_up was called with irqs disabled.
Jon Masters will be pushing some form of it upstream.

Information on the RT patch can be found at:
http://rt.wiki.kernel.org/index.php/Main_Page

Download location
git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-linux.git

Branch Name
linux-2.6.31-rc5-rt1.1

Enjoy!

John Kacur
Clark Williams
