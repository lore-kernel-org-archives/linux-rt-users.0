From: Daniel Walker <dwalker@mvista.com>
Subject: 2.6.23-rc4-dw1
Date: Wed, 29 Aug 2007 17:17:29 -0700
Message-ID: <1188433049.26038.15.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, mingo@redhat.com, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761534AbXH3A0q@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I've updated to 2.6.23-rc4 .. This is an "Ingo appears to be busy.."
release .. I've been waiting for a -rt update , but there hasn't been
one for a while. So my tree is the best everyone will get for now.

ftp://source.mvista.com/pub/dwalker/rt/patch-2.6.23-rc4-dw1
ftp://source.mvista.com/pub/dwalker/rt/patch-2.6.23-rc4-dw1.tar.bz2

The patches follow the release style of Ingo's tree, and his release
notes also apply to my patch as well.

I included a fresh git-acpi pull. I also included all the patches I've
submitted to Ingo, and the following patches that got submitting to lkml
and the linux-rt-users list,

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] fix non SMP compile smp stubs

From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: [PATCH RT] - Mellanox IB driver patch

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Add missing semicolon in percpu_list.h

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC -rt] synchronize_sched() without migration

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC -rt] Allow rcutorture to handle synchronize_sched()

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Only run softirqs from the irq thread if the irq

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] initialize the clock source to jiffies clock.

Enjoy,

Daniel
