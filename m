From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 9 Apr 2015 15:39:16 +0200
Message-ID: <20150409133916.GA2416@linutronix.de>
References: <20150317163541.080310081@goodmis.org>
 <20150317163617.218582800@goodmis.org>
 <20150317163551.3093b6c2@gandalf.local.home>
 <1426753029.4168.80.camel@gmail.com>
 <20150319122611.0d002d48@gandalf.local.home>
 <20150324181034.GD1321@linutronix.de>
 <1427250833.3459.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427250833.3459.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-03-25 03:33:53 [+0100]:

>Nah, I was referring to get_next_timer_interrupt() because I saw that
>rt_spin_unlock_after_trylock_in_irq(&base->lock) sitting there.

Hmm. Good question. But it was Ingo who introduced the lock, so it might
have special Ingo magic included.

>	-Mike

Sebastian
