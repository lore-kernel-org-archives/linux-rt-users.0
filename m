From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch rfc] locking/rwsem: Add
 down_write_killable/killable_nested()
Date: Thu, 9 Jun 2016 15:06:33 +0200
Message-ID: <20160609130633.GD6305@linutronix.de>
References: <20160603104424.GA18975@linutronix.de>
 <1465273159.3931.24.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465273159.3931.24.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2016-06-07 06:19:19 [+0200]:

>v4.7 added down_write_killable/killable_nested(), add them to -rt.

looks good, I will postpone this until v4.8-RT

>Signed-off-by: Mike Galbraith <mgalbraith@suse.de>

Sebastian
