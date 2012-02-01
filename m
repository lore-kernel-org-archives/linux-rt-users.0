From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2 v3] preempt-rt/x86: Handle sending signals from do_trap() by gdb
Date: Wed, 01 Feb 2012 16:06:12 -0500
Message-ID: <20120201210612.730595791@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Version 3 that changes the name of preempt_conditinal_sti/cli() to
conditional_sti/cli_ist(), as discussed between Masami and myself.

-- Steve
