From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Sat, 14 Jul 2012 15:38:16 +0200
Message-ID: <1342273096.7368.57.camel@marge.simpson.net>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <20120713125043.GH30128@shiny>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Chris Mason <chris.mason@fusionio.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120713125043.GH30128@shiny>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2012-07-13 at 08:50 -0400, Chris Mason wrote:

> There is also a chunk of code in btrfs_clear_path_blocking that makes
> sure to strictly honor top down locking order during the conversion.  It
> only does this when lockdep is enabled because in non-RT kernels we
> don't need to worry about it.  For RT we'll want to enable that as well.

Hm, _seems_ that alone is enough prevent deadlock.  Throughput really
sucks though.  The other bits of my stab bump throughput for dbench 128
from ~200 mb/s to ~360 mb/s (appears it's the paranoid trylock loops).
ext3 does 775 mb/s with the same kernel.  Or, dbench 8 on ext3 gives
~1800 mb/s and ~480 mb/s btrfs.  Not exactly wonderful.

Hohum, guess I'll wait and see what your patch looks like.  I bet it'll
work a lot better than mine does :)

-Mike
