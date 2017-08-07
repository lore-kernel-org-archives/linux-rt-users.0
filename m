From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Mon, 7 Aug 2017 09:33:50 +0200
Message-ID: <20170807073350.nwytftryfp34mrwi@linutronix.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
 <1501913583.7917.42.camel@gmx.de>
 <1501945043.5473.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501945043.5473.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-05 16:57:23 [+0200], Mike Galbraith wrote:
> > Woohoo!
> 
> Box put a small dent in enthusiasm.  After a bit of hotplug flogging,
> box blew up on shutdown.  x3550 M3 has a serial port, and reproduced.
> 
> [  624.216065] list_del corruption. prev->next should be ffff88015cb31278, but was ffff88017f0945a0
> [  624.216077] ------------[ cut here ]------------
> [  624.216079] kernel BUG at lib/list_debug.c:53!

what timer is it :)?

Sebastian
