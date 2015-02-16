From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patchlet] rt,locking: fix __ww_mutex_lock_interruptible()
 lockdep annotation
Date: Mon, 16 Feb 2015 18:24:32 +0100
Message-ID: <20150216172432.GG21649@linutronix.de>
References: <1401714764.5757.3.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401714764.5757.3.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-06-02 15:12:44 [+0200]:

>Using mutex_acquire_nest() as used in __ww_mutex_lock() fixes the 
>splat below.  Remove superfluous line break in __ww_mutex_lock()
>as well.

applied.

>Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

umgwanakikbuti? The good ones were taken, right?

Sebastian
