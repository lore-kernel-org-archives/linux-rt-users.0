From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd
 wakeup
Date: Sat, 29 Sep 2018 08:38:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com> <201809290614.fxFuwGkP%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Julia Cartwright <julia@ni.com>, kbuild-all@01.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201809290614.fxFuwGkP%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 29 Sep 2018, kbuild test robot wrote:
> [also build test ERROR on v4.19-rc5 next-20180928]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 

It's against the RT tree, so it won't work against next or upstream. I
think it would be good to have a machine parseable tag to describe which
tree/branch/commit patches are applicable to. If that tag is missing, the
bot can assume it's against upstream/next.

Thanks,

	tglx
