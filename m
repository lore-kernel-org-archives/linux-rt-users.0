From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 2.6.33.7-rt29
Date: Tue, 3 Aug 2010 11:23:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008031118270.3225@localhost.localdomain>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain> <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain> <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain> <alpine.LFD.2.00.1003211158130.3147@localhost.localdomain>
 <alpine.LFD.2.00.1004071619490.32352@localhost.localdomain> <alpine.LFD.2.00.1004271744280.2951@localhost.localdomain> <alpine.LFD.2.00.1004301156590.2951@localhost.localdomain> <alpine.LFD.2.00.1005022109150.25342@localhost.localdomain>
 <alpine.LFD.2.00.1006091837410.2933@localhost.localdomain> <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain> <alpine.LFD.2.00.1007311530510.2471@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1007311530510.2471@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We are pleased to announce the next update to our new preempt-rt
series.
  
Changes from 2.6.33.6-rt28 to 2.6.33.7-rt29:
 c88417f: Merge stable update

Changes from 2.6.33.6-rt27 to 2.6.33.6-rt28:
 8a990ab: printk: Restore irqs before calling release_console_mutex()

Download locations:
   
   http://www.kernel.org/pub/linux/kernel/projects/rt/

Git release branch:
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git rt/2.6.33

Gitweb:
   http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=shortlog;h=rt/2.6.33

Information on the RT patch can be found at:

   http://rt.wiki.kernel.org/index.php/Main_Page

To build the 2.6.33.7-rt29 tree, the following patches should be
applied:

   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.7.tar.bz2
   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.7-rt29.bz2

Enjoy !

      tglx
