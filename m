From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Tue, 17 Jul 2012 06:46:14 +0200
Message-ID: <1342500374.7353.47.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <20120713125043.GH30128@shiny> <1342260883.7368.30.camel@marge.simpson.net>
	 <20120715175612.GF25961@shiny.int.fusionio.com>
	 <1342404140.7659.27.camel@marge.simpson.net>
	 <1342454547.5410.3.camel@gandalf.stny.rr.com>
	 <1342455968.7659.93.camel@marge.simpson.net>
	 <1342456567.7659.97.camel@marge.simpson.net>
	 <1342458195.2783.5.camel@acer.local.home>
	 <1342498722.7353.37.camel@marge.simpson.net>
	 <1342499278.24525.13.camel@gandalf.stny.rr.com>
	 <1342499648.24525.17.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <chris.mason@fusionio.com>,
	"Chris L. Mason" <clmason@fusionio.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342499648.24525.17.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-07-17 at 00:34 -0400, Steven Rostedt wrote: 
> On Tue, 2012-07-17 at 00:27 -0400, Steven Rostedt wrote:
> 
> > Actually, I was mistaken. I forgot that we defined 'cpu_chill()' as
> > msleep(1) on RT, which would keep a deadlock from happening.
> 
> Perhaps cpu_chill() isn't a good name, as it doesn't really explain what
> is happening. Perhaps one of the following?
> 
>   cpu_rest()
>   cpu_sleep()
>   cpu_deep_relax()
>   cpu_dream()
>   cpu_hypnotize()

(   cpu_waste_truckloads_of_time();)
