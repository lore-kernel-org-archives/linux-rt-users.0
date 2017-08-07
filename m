From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Mon, 07 Aug 2017 10:22:01 +0200
Message-ID: <1502094121.5568.22.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de> <1501945043.5473.31.camel@gmx.de>
         <20170807073350.nwytftryfp34mrwi@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807073350.nwytftryfp34mrwi@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-08-07 at 09:33 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-08-05 16:57:23 [+0200], Mike Galbraith wrote:
> > > Woohoo!
> > 
> > Box put a small dent in enthusiasm.  After a bit of hotplug flogging,
> > box blew up on shutdown.  x3550 M3 has a serial port, and reproduced.
> > 
> > [  624.216065] list_del corruption. prev->next should be ffff88015cb31278, but was ffff88017f0945a0
> > [  624.216077] ------------[ cut here ]------------
> > [  624.216079] kernel BUG at lib/list_debug.c:53!
> 
> what timer is it :)?

kernel/exit.c:
851                     hrtimer_cancel(&tsk->signal->real_timer);

That one.
