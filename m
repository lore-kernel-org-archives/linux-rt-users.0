From: Steven Rostedt <rostedt@goodmis.org>
Subject: 2.6.23.9-rt12
Date: Wed, 28 Nov 2007 09:29:44 -0500
Message-ID: <1196260184.4778.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759632AbXK1Oah@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the 2.6.23.9-rt12 tree, which can be
downloaded from the location:

 http://www.kernel.org/pub/linux/kernel/projects/rt/

Changes since 2.6.23.1-rt11

  - Ported to 2.6.23.9

  - Backported the RT balance code from our submissions to upstream

  - Now missing Gregory's CPU Prio patch (those that are interested
                in testing that, should contact Gregory (email above)
                and come back with numbers to convince us that this
                is worth it).

to build a 2.6.23.9-rt12 tree, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.9.tar.bz2 
  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.23.9-rt12.bz2

And like always, my RT version of Matt Mackall's ketchup will get this
for you nicely:

  http://people.redhat.com/srostedt/rt/tools/ketchup-0.9.8-rt2

  Note: the "-rt2".  Michal Schmidt help point out and fix the fact
    that "ketchup -s 2.6-rt" and "ketchup 2.6-rt" were broken.
    I never used that feature, but now I will.

The broken out patches are also available.

-- Steve
