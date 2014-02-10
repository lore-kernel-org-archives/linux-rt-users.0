From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT 0/5] preempt_disable/enable -> migrate_disable/enable
	pushdown proposals
Date: Mon, 10 Feb 2014 16:36:53 +0100
Message-ID: <20140210153653.GA20017@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



a small series of preempt_disable/enable -> migrate_disable/enable pushdown 
proposals

In mainline a number of preempt_disable/enable are actually topology control 
and not actual concurrency control - these cases can be pushed down to a 
preemptible migrate_disable/enable. 

This little series contains a few pushdowns from preempt_disable to 
migrate_disable where code pattern scans using cocci scripts suggested this 
to be possible. The cases detected were then reviewed and tested with the 
migrate_disable/enable respectively with the preempt_disable/enable 
completely removed in one case.

Testing was done but is of very limited use for locking/migration related
issues, so a review of the code analysis/rational is requested along with
additional testing.

thx!
hofrat
