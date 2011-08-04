From: Peter Zijlstra <peterz@infradead.org>
Subject: [ANNOUNCE] 3.0-rt7
Date: Thu, 04 Aug 2011 15:53:10 +0200
Message-ID: <1312465990.16729.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

With Thomas enjoying his well earned holidays, I hereby present you with
3.0-rt7.

Goodies included since last time:

 - some raw_spinlock patch from Uwe.
 - cpupri rework from Rostedt, something which should greatly benefit
   everybody with smp hardware, the more cpus the more benefit.
 - a possible fix for some posix timer splat reported by Fernando.
 - i386-highmem support because I'd already written the code anyway
   so I thought I might as well make it work.

I'll take patches implementing similar highmem muck on other arches, if
there's any code to be shared between the arches, do so.

Patches live at the usual location, single patch:

 http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0-rt7.patch.bz2

quilt series tarball:

 http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0-rt7.tar.bz2

If your favourite patch isn't included, make sure it landed in my inbox,
or better yet make it land there again.

Known issues I still have to look at is some posix test fail from der
Hofrat and the ever fun pile of CGROUP_RT.

Enjoy!
