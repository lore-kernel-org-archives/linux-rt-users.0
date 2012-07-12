From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Thu, 12 Jul 2012 10:44:08 +0200
Message-ID: <1342082648.7338.171.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342072060.7338.102.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2012-07-12 at 07:47 +0200, Mike Galbraith wrote: 
> Greetings,
> 
> I'm chasing btrfs critters in an enterprise 3.0-rt kernel, and just
> checked to see if they're alive in virgin latest/greatest rt kernel.  
> 
> Both are indeed alive and well, ie I didn't break it, nor did the
> zillion patches in enterprise base kernel, so others may have an
> opportunity to meet these critters up close and personal as well.

3.2-rt both explodes and deadlocks as well.  3.0-rt (virgin I mean) does
neither, so with enough re-integrate investment, it might be bisectable.

Rummaging in btrfs, that begins to look down right attractive ;-)

-Mike
