From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM.. and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Thu, 12 Jul 2012 15:51:23 +0200
Message-ID: <1342101083.7707.22.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <1342082648.7338.171.camel@marge.simpson.net>
	 <1342086792.7707.9.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207121310420.32033@ionos>
	 <1342094233.7707.12.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207121514240.32033@ionos>
	 <1342100270.7707.20.camel@marge.simpson.net>
	 <alpine.LFD.2.02.1207121542510.32033@ionos>
	 <1342100889.7707.21.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342100889.7707.21.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-07-12 at 15:48 +0200, Mike Galbraith wrote: 
> On Thu, 2012-07-12 at 15:43 +0200, Thomas Gleixner wrote: 
> > On Thu, 12 Jul 2012, Mike Galbraith wrote:
> > > On Thu, 2012-07-12 at 15:31 +0200, Thomas Gleixner wrote: 
> > > > A quick check for memcpy finds that __btrfs_close_devices() does a
> > > > memcpy of btrfs_device structs w/o initializing the lock in the new
> > > > copy, but I have no idea whether that's the place we are looking for.
> > > 
> > > 
> > > Cool, you found one, thanks!  I'm setting boobytraps.
> > > 
> > > Um, correction, box says I'm setting _buggy_ boobytraps :)
> > > 
> > > Tomorrow-man will test this and frob traps anew.
> > 
> > What kind of test setup do you have? i.e. raid, single disk ...
> 
> Yeah, megaraid sas.. x3550 M3.

(one disk for OS, one disk for xfstests to mangle)
