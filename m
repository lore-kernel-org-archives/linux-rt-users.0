From: Steven Rostedt <rostedt@goodmis.org>
Subject: Using random in interrupts for RT
Date: Tue, 14 Aug 2012 10:30:49 -0400
Message-ID: <1344954649.6724.13.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

Ben Hutchings asked me if we still need "genirq: Disable random call on
preempt-rt" for -rt? With commit 902c098a366 "random: use lockless
techniques in the interrupt path" there is no more locks used. But does
it still produce high latencies?

-- Steve
