From: Fengguang Wu <lkp@intel.com>
Subject: Re: [kbuild-all] [PATCH] locking_selftest: Save/restore
 migrate_disable_atomic in locking selftest
Date: Mon, 23 Nov 2015 22:58:43 +0800
Message-ID: <20151123145843.GA25396@wfg-t540p.sh.intel.com>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
 <201511231529.iE0YvIjj%fengguang.wu@intel.com>
 <20151123084325.4f0b4d62@gandalf.local.home>
 <20151123141408.GA24611@wfg-t540p.sh.intel.com>
 <20151123091756.5e775366@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, kbuild-all@01.org,
	jianchuan.wang@windriver.com, tglx@linutronix.de,
	yang.shi@windriver.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151123091756.5e775366@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 23, 2015 at 09:17:56AM -0500, Steven Rostedt wrote:
> On Mon, 23 Nov 2015 22:14:08 +0800
> Fengguang Wu <lkp@intel.com> wrote:
> 
> > > Need to add RT in the subject like "[PATCH RT]". Then perhaps Fengguang
> > > can have his tests either ignore these or test against the -rt trees.  
> > 
> > Yes sure. Shall I apply RT patches to this tree/branch?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt
> 
> Looks like a good of a branch as any.

OK. Added the [RT] mapping to that branch.

Thanks,
Fengguang
