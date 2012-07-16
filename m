From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Mon, 16 Jul 2012 18:16:47 +0200
Message-ID: <1342455407.7659.86.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <20120713125043.GH30128@shiny> <1342260883.7368.30.camel@marge.simpson.net>
	 <1342436144.7659.58.camel@marge.simpson.net>
	 <20120716154304.GG25961@shiny.int.fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Chris L. Mason" <clmason@fusionio.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Chris Mason <chris.mason@fusionio.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120716154304.GG25961@shiny.int.fusionio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-07-16 at 11:43 -0400, Chris Mason wrote: 
> On Mon, Jul 16, 2012 at 04:55:44AM -0600, Mike Galbraith wrote:

> > Seems btrfs isn't entirely convinced either.
> > 
> > [ 2292.336229] use_block_rsv: 1810 callbacks suppressed
> > [ 2292.336231] ------------[ cut here ]------------
> > [ 2292.336255] WARNING: at fs/btrfs/extent-tree.c:6344 use_block_rsv+0x17d/0x190 [btrfs]()
> > [ 2292.336257] Hardware name: System x3550 M3 -[7944K3G]-
> > [ 2292.336259] btrfs: block rsv returned -28
> 
> This is unrelated.  You got far enough into the benchmark to hit an
> ENOSPC warning.  This can be ignored (I just deleted it when we used 3.0
> for oracle).

Ah great, thanks.  I'll whack it in my tree as well then.

> re: dbench performance.  dbench tends to penalize fairness.  I can
> imagine RT making it slower in general.

It seems to work just fine for my normal workloads, and cyclictest is
happy, so I'm happy.  Zillion threads is 'keep the pieces' to me ;-)

If you think the patch is ok as is, I'll go ahead and submit it after I
let dbench hammer on it overnight at least.

-Mike
