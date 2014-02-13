From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.12.9-rt13: BUG: soft lockup
Date: Thu, 13 Feb 2014 23:25:25 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402132324230.21991@ionos.tec.linutronix.de>
References: <52FBF2F1.8040504@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FBF2F1.8040504@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 12 Feb 2014, Fernando Lopez-Lezcano wrote:
> [771508.546449] RIP: 0010:[<ffffffff810dc60a>]  [<ffffffff810dc60a>]
> smp_call_function_many+0x2ca/0x330

Can you decode the exact location inside of smp_call_function_many via
addr2line please ?

Thanks,

	tglx
