From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.0.1-rt8
Date: Tue, 09 Aug 2011 11:31:46 -0700
Message-ID: <4E417D12.70608@localhost>
References: <1312580681.28695.44.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.219.83]:34344 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751799Ab1HISbv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 14:31:51 -0400
In-Reply-To: <1312580681.28695.44.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/05/2011 02:44 PM, Peter Zijlstra wrote:
> Hi,
>
> Since yesterday is old, and yesterday's kernels aren't interesting,
> here's a fresh one: 3.0.1-rt8.

Hmmm, what are reasonable values for CONFIG_RCU_BOOST_PRIO and 
CONFIG_RCU_BOOST_DELAY? (or at least what are you using?). I think 
CONFIG_RCU_BOOST should be working now so I should reenable the option 
for my next build.

-- Fernando


> Aside from the obvious rebase to 3.0.1 changes include:
>
>   - a fix from Rostedt for his cpupri rework involving memory ordering
>   - a fix from me regarding this highmem muck, seeing as I mostly
>     wrecked things last time around :-)
>   - some lockdep annotations from upstream for things people were
>     seeing here as well
>   - a patch from Clark adding a sysfs file to recognize a PREEMP_RT
>     kernel for udev -- is there really no saner solution !?
>   - and a fresh raw_spinlock_t conversion of cpufreq_driver_lock, done
>     just minutes before releasing this, to keep life interesting.
>
> Still working on the known issues from last time..
>
> The patch is at:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0.1-rt8.patch.bz2
>
> The quilt series can be found here:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0.1-rt8.tar.bz2
>
> Once kernel.org mirrors catch up that is..
