From: Fengguang Wu <lkp@intel.com>
Subject: Re: [kbuild-all] [PATCH] locking_selftest: Save/restore
 migrate_disable_atomic in locking selftest
Date: Mon, 23 Nov 2015 23:03:03 +0800
Message-ID: <20151123150303.GA26066@wfg-t540p.sh.intel.com>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
 <201511231529.iE0YvIjj%fengguang.wu@intel.com>
 <20151123084325.4f0b4d62@gandalf.local.home>
 <20151123141408.GA24611@wfg-t540p.sh.intel.com>
 <5653241F.4070704@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kbuild-all@01.org, jianchuan.wang@windriver.com,
	tglx@linutronix.de, yang.shi@windriver.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5653241F.4070704@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 23, 2015 at 03:35:11PM +0100, Sebastian Andrzej Siewior wrote:
> On 11/23/2015 03:14 PM, Fengguang Wu wrote:
> 
> >> Need to add RT in the subject like "[PATCH RT]". Then perhaps Fengguang
> >> can have his tests either ignore these or test against the -rt trees.
> > 
> > Yes sure. Shall I apply RT patches to this tree/branch?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt
> 
> I'm going to get you your kbot branch where you run bisect tests and
> everything and tests the patches against. The problem with this one is
> that we will drop it (or leave it stale) once we move to the next major
> kernel release.

Thanks! Yes, a stable branch name would be better than "linux-4.1.y-rt"
that's like to become stable over time.

Thanks,
Fengguang
