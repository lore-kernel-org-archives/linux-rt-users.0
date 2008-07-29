From: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.26-rt1
Date: Wed, 30 Jul 2008 00:21:10 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Carsten Emde <ce@ceag.ch>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:35325 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbYG2W3X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Jul 2008 18:29:23 -0400
In-Reply-To: <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the 2.6.26-rt1 tree, which can be
downloaded from the location:
  
   http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

   http://rt.wiki.kernel.org/index.php/Main_Page

The merge was mostly done by Steven Rostedt, I just fixed it up, added
the fixes from .24-rt17 and tested it on x86 32/64bit.

This is the first cut of .26-rt, so don't expect it to be perfect.

I run out of time, so I dropped Peter's cpu-hotplug patches
completely. The hotplug and rcupreempt code has changed radically, so
we need to redo that lot. Peter, Paul can you please look into that ?

I tried to address the non-x86 issues as far as I could, but I had no
chance to compile test them. So please check the wreckage.

to build a 2.6.26-rt1 tree, the following patches should be applied:
 
   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
   http://rt.et.redhat.com/download/patch-2.6.26-rt1.bz2
  
And like always, Steven's RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3

As usual the broken out patches are also available.

I'm going on vacation tomorrow so feel free to blame/curse/flame me,
but please work with Steven to get it into shape.

Thanks,

	tglx
