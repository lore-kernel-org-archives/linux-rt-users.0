From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in
 fcoe_recv_frame()
Date: Fri, 29 Jul 2016 17:39:55 +0200
Message-ID: <20160729153955.GD21715@linutronix.de>
References: <20160715114803.GA11606@linutronix.de>
 <1469678689.3889.10.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469678689.3889.10.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2016-07-28 06:04:49 [+0200]:

>During master->rt merge, I stumbled across the buglet below.
>
>Fix get_cpu()/put_cpu_light() imbalance.
applied.

>Signed-off-by: Mike Gabraith <umgwanakikbuti@gmail.com>

Sebastian
