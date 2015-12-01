From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [kbuild-all] [PATCH] locking_selftest: Save/restore
 migrate_disable_atomic in locking selftest
Date: Tue, 1 Dec 2015 18:59:44 +0100
Message-ID: <565DE010.3040907@linutronix.de>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
 <201511231529.iE0YvIjj%fengguang.wu@intel.com>
 <20151123084325.4f0b4d62@gandalf.local.home>
 <20151123141408.GA24611@wfg-t540p.sh.intel.com>
 <5653241F.4070704@linutronix.de>
 <20151123150303.GA26066@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kbuild-all@01.org, jianchuan.wang@windriver.com,
	tglx@linutronix.de, yang.shi@windriver.com
To: Fengguang Wu <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151123150303.GA26066@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/23/2015 04:03 PM, Fengguang Wu wrote:
> Thanks! Yes, a stable branch name would be better than "linux-4.1.y-rt"
> that's like to become stable over time.

finally. I got to it.
I pushed two branches @ pub/scm/linux/kernel/git/rt/linux-rt-devel.git:

	for-kbuild-bot/current-stable [0]
	for-kbuild-bot/prepare-release [1]

Branch [0] should contain the last -RT release. This could be used for
testing patches against (if you find one with the RT marker in subject).
The tree should start a stable-tree marker (currently it is v4.1.13)
and have -RT tree applied on top. You should be able compile after each
commit (between the stable tag and HEAD) and nothing should introduce
warnings or fail to compile.
The second branch [1] would be similar to the first one except that I
plan to push stuff there before I make a release it. Does this make
sense or do I over think this?
If you do compile tests, it would be nice if you could enable
CONFIG_PREEMPT_RT_FULL. That is where most of the changes start to work.
Nevertheless it should also work without it(i.e. no preemption or
desktop).
If you have slightly different naming scheme or suggestions just tell
me I will adapt to it:)

Thank you for the service.

> Thanks,
> Fengguang

Sebastian
