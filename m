From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.24-rc7-rt1
Date: Sun, 13 Jan 2008 21:25:22 +0100
Message-ID: <20080113202522.GD27137@pengutronix.de>
References: <1200250801.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60766 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754783AbYAMUZZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Jan 2008 15:25:25 -0500
Content-Disposition: inline
In-Reply-To: <1200250801.9190.7.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jan 13, 2008 at 02:00:01PM -0500, Steven Rostedt wrote:
> We are pleased to announce the 2.6.24-rc7-rt1 tree

Works fine on phyCORE-MPC5200B-tiny, here are the latest results:
http://www.pengutronix.de/oselas/realtime/results/20080113-1/

However, when I try to switch on the latency tracer, it ends with the
warnings below. I've added early_printk() stubs in order to make it
link at all.

In file included from kernel/latency_trace.c:27:
include/asm/asm-offsets.h:76:1: warning: "CLONE_VM" redefined
In file included from include/linux/security.h:32,
                 from include/linux/mm.h:15,
                 from kernel/latency_trace.c:7:
include/linux/sched.h:8:1: warning: this is the location of the previous definition
In file included from kernel/latency_trace.c:27:
include/asm/asm-offsets.h:77:1: warning: "CLONE_UNTRACED" redefined
In file included from include/linux/security.h:32,
                 from include/linux/mm.h:15,
                 from kernel/latency_trace.c:7:
include/linux/sched.h:22:1: warning: this is the location of the previous definition
In file included from kernel/latency_trace.c:27:
include/asm/asm-offsets.h:88:1: warning: "TASK_SIZE" redefined
In file included from include/asm/thread_info.h:25,
                 from include/linux/thread_info.h:34,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:85,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:4,
                 from include/linux/mm.h:8,
                 from kernel/latency_trace.c:7:
include/asm/processor.h:84:1: warning: this is the location of the previous definition
In file included from kernel/latency_trace.c:27:
include/asm/asm-offsets.h:112:1: warning: "NSEC_PER_SEC" redefined
In file included from include/linux/stat.h:60,
                 from include/linux/fs.h:278,
                 from include/linux/security.h:25,
                 from include/linux/mm.h:15,
                 from kernel/latency_trace.c:7:
include/linux/time.h:37:1: warning: this is the location of the previous definition
In file included from kernel/latency_trace.c:27:
include/asm/asm-offsets.h:115:1: warning: "PGD_TABLE_SIZE" redefined
In file included from include/asm/pgtable.h:15,
                 from include/linux/mm.h:38,
                 from kernel/latency_trace.c:7:
include/asm/pgtable-ppc32.h:91:1: warning: this is the location of the previous definition
  CC [M]  fs/ext2/balloc.o
kernel/latency_trace.c: In function 'check_wakeup_timing':
kernel/latency_trace.c:2240: warning: format '%016lx' expects type 'long unsigned int', but argument 2 has type 'cycle_t'

Robert
-- 
 Robert Schwebel              |  http://www.pengutronix.de
 OSADL Testlab @ Pengutronix  |  http://www.osadl.org
