From: Peter Zijlstra <peterz@infradead.org>
Subject: [ANNOUNCE] 3.0.1-rt8
Date: Fri, 05 Aug 2011 23:44:41 +0200
Message-ID: <1312580681.28695.44.camel@twins>
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

Since yesterday is old, and yesterday's kernels aren't interesting,
here's a fresh one: 3.0.1-rt8.

Aside from the obvious rebase to 3.0.1 changes include:

 - a fix from Rostedt for his cpupri rework involving memory ordering
 - a fix from me regarding this highmem muck, seeing as I mostly
   wrecked things last time around :-)
 - some lockdep annotations from upstream for things people were
   seeing here as well
 - a patch from Clark adding a sysfs file to recognize a PREEMP_RT
   kernel for udev -- is there really no saner solution !?
 - and a fresh raw_spinlock_t conversion of cpufreq_driver_lock, done
   just minutes before releasing this, to keep life interesting.

Still working on the known issues from last time..

The patch is at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0.1-rt8.patch.bz2

The quilt series can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0.1-rt8.tar.bz2

Once kernel.org mirrors catch up that is..
