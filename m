From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.14-rt1
Date: Fri, 2 May 2014 12:16:46 +0200
Message-ID: <20140502101646.GD9178@linutronix.de>
References: <20140411185739.GA6644@linutronix.de>
 <1397918766.5436.16.camel@marge.simpson.net>
 <1398051078.4437.6.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398051078.4437.6.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-04-21 05:31:18 [+0200]:

>Another little bug.  This hunk of patches/stomp-machine-raw-lock.patch
>should be while (atomic_read(&done.nr_todo)) 

Thanks, fixed up.

Sebastian
