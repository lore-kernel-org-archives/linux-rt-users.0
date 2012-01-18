From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: rt-kernel 3.0.14-rt31: BUG: sleeping function called from
 invalid context
Date: Tue, 17 Jan 2012 20:02:05 -0500
Message-ID: <1326848525.17534.66.camel@gandalf.stny.rr.com>
References: <CAONaPpFjfGiKKGAzrQNk+MF4k50nRf+wMU8H9491NgHyJrUkyw@mail.gmail.com>
	 <201201180053.52617.fzuuzf@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Karsten Wiese <fzuuzf@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201201180053.52617.fzuuzf@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2012-01-18 at 00:53 +0100, Karsten Wiese wrote:

> The bug happens because acpi_ev_gpe_detect does
> raw_spin_lock_irqsave(&acpi_gbl_gpe_lock, flags) before it calls
> acpi_ev_gpe_dispatch.

Correct. I believe there's a fix in the 3.2-rt. I'm working on getting
the updates from it to the stable tree.

-- Steve
