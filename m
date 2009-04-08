From: Thomas Gleixner <tglx@linutronix.de>
Subject: [Announce] 2.6.29.1-rt5
Date: Wed, 8 Apr 2009 19:49:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904081937191.21577@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain> <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain> <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain> <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
 <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain> <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain> <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain> <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:37088 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbZDHRvO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Apr 2009 13:51:14 -0400
In-Reply-To: <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are pleased to announce the next update to our new preempt-rt
series.
   
 	- include the futex rework + requeue_pi support (Darren Hart)

The futex changes need profound testing. As we know from prior futex
work the best stress tests for the futex interface are RT-Java-VMs
especially with enterprise work loads on larger machines. Can the
folks who have access to such monstrosities please unleash the beasts
and give the futex code a good work out ? Please tell your sysadmin
upfront that he should be stand by to fix up the resulting wreckage
which might vary from harmless to system replacement.

Unfortunately I was not able to track down the weird 32bit PAE
shutdown crash, so the affected users need to stick to the
nosmp-alternatives work around for now.

Download locations:
  
     http://rt.et.redhat.com/download/
     http://www.kernel.org/pub/linux/kernel/projects/rt/
   
Information on the RT patch can be found at:
 
     http://rt.wiki.kernel.org/index.php/Main_Page
 
to build the 2.6.29.1-rt5 tree, the following patches should be
applied:
 
     http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.1.tar.bz2
     http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29.1-rt5.bz2
 
The broken out patches are also available at the same download
locations.
 
Enjoy !

       tglx
