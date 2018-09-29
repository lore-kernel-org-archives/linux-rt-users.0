From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2] watchdog, rt: prevent deferral of watchdogd wakeup
Date: Sun, 30 Sep 2018 00:13:02 +0200
Message-ID: <20180929221301.z7dytm4whpcbip6a@linutronix.de>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
 <201809290614.fxFuwGkP%fengguang.wu@intel.com>
 <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kbuild test robot <lkp@intel.com>, Julia Cartwright <julia@ni.com>,
        kbuild-all@01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-29 08:38:55 [+0200], Thomas Gleixner wrote:
> On Sat, 29 Sep 2018, kbuild test robot wrote:
> > [also build test ERROR on v4.19-rc5 next-20180928]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> 
> It's against the RT tree, so it won't work against next or upstream. I
> think it would be good to have a machine parseable tag to describe which
> tree/branch/commit patches are applicable to. If that tag is missing, the
> bot can assume it's against upstream/next.

I asked the testing team to ignore patches or test against the RT tree
if the patch is tagged [PATCH RT]. I think it worked since I haven't
seen those mails.

> Thanks,
> 
> 	tglx

Sebastian
