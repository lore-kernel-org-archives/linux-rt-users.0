From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] rt, hotplug: Use set_cpus_allowed_ptr() in
 sync_unplug_thread()
Date: Fri, 10 Apr 2015 16:00:24 +0200
Message-ID: <20150410140024.GB3057@linutronix.de>
References: <1427181289.3316.27.camel@gmail.com>
 <20150409140512.GB2416@linutronix.de>
 <1428589425.6927.10.camel@gmail.com>
 <552692C3.20709@linutronix.de>
 <1428601201.2328.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428601201.2328.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2015-04-09 19:40:01 [+0200]:

>> in the BUG() statement in set_cpus_allowed_rt() if this is where it 
>> is
>> coming from?
>
>[exception RIP: set_cpus_allowed_rt+18] is BUG_ON(!rt_task(p)).

Oh sorry, I missed the _rt. Now it makes sense.

>
>        -Mike

Sebastian
