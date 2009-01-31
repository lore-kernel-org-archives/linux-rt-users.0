From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.26.8-rt15
Date: Sat, 31 Jan 2009 02:34:10 -0500
Message-ID: <1233387250.922.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <srostedt@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752921AbZAaHeY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.26.8-rt15 tree which can be
downloaded from the following location:

  http://rt.et.redhat.com/download/

Information on the RT patch can be found at:

  http://rt.wiki.kernel.org/index.php/Main_Page

Changes since 2.6.26.6-rt14

 - x86, mm: fix pte_free()  (Peter Zijlstra)

 - hrtimer: prevent negative expiry value after clack_was_set
 		(Thomas Gleixner)

 - Fixed confusing Kconfig label of WAKEUP_LATENCY_HIST
	 	(Carsten Emde)

 - x86: remove redundant local_irq_enable in handle_singal
		(Carsten Emde)

 - trace: warn if irqs already enabled in irqs_off latency check
		(Carsten Emde)

to build the 2.6.26.8-rt15 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.26.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.26.8.bz2
  http://rt.et.redhat.com/download/patch-2.6.26.8-rt15.bz2


And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt3


The broken out patches are also available.

***************************************************************
***************************************************************
******  COMING SOON !!! COMING SOON !!! COMING SOON !!! *******
******  COMING SOON !!! COMING SOON !!! COMING SOON !!! *******
***************************************************************
***************************************************************

The RT git tree is almost ready!  It is currently based off of 2.6.28,
until it becomes a little more stable. You can down load it now from the
git repo:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git

It boots on x86_64. A few more patches still need to be applied, but the
majority of them have been incorporated. Work on the non x86 archs also
needs to be done.

Once the git tree is pretty stable I will release a 2.6.28-rt1 patch,
make a v2.6.28-rt branch and then go right in sync with the mainline
tree.

Feel free to download it now and give it a try. And you can send me any
crashes that you see.


-- Steve
