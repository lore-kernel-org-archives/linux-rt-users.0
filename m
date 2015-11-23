From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [kbuild-all] [PATCH] locking_selftest: Save/restore
 migrate_disable_atomic in locking selftest
Date: Mon, 23 Nov 2015 15:35:11 +0100
Message-ID: <5653241F.4070704@linutronix.de>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
 <201511231529.iE0YvIjj%fengguang.wu@intel.com>
 <20151123084325.4f0b4d62@gandalf.local.home>
 <20151123141408.GA24611@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kbuild-all@01.org, jianchuan.wang@windriver.com,
	tglx@linutronix.de, yang.shi@windriver.com
To: Fengguang Wu <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151123141408.GA24611@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/23/2015 03:14 PM, Fengguang Wu wrote:

>> Need to add RT in the subject like "[PATCH RT]". Then perhaps Fengguang
>> can have his tests either ignore these or test against the -rt trees.
> 
> Yes sure. Shall I apply RT patches to this tree/branch?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt

I'm going to get you your kbot branch where you run bisect tests and
everything and tests the patches against. The problem with this one is
that we will drop it (or leave it stale) once we move to the next major
kernel release.

> Thanks,
> Fengguang

Sebastian
