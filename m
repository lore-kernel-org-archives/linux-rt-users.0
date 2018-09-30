From: "Li, Philip" <philip.li@intel.com>
Subject: RE: [kbuild-all] [PATCH RT 2/2] watchdog, rt: prevent deferral of
 watchdogd wakeup
Date: Sun, 30 Sep 2018 01:41:18 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CD1CCC3@shsmsx102.ccr.corp.intel.com>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
 <201809290614.fxFuwGkP%fengguang.wu@intel.com>
 <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
 <20180929221301.z7dytm4whpcbip6a@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Julia Cartwright" <julia@ni.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "Tim Sander" <tim@krieglstein.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, lkp <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929221301.z7dytm4whpcbip6a@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Subject: Re: [kbuild-all] [PATCH RT 2/2] watchdog, rt: prevent deferral of
> watchdogd wakeup
> 
> On 2018-09-29 08:38:55 [+0200], Thomas Gleixner wrote:
> > On Sat, 29 Sep 2018, kbuild test robot wrote:
> > > [also build test ERROR on v4.19-rc5 next-20180928]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> > >
> >
> > It's against the RT tree, so it won't work against next or upstream. I
> > think it would be good to have a machine parseable tag to describe which
> > tree/branch/commit patches are applicable to. If that tag is missing, the
> > bot can assume it's against upstream/next.
> 
> I asked the testing team to ignore patches or test against the RT tree
> if the patch is tagged [PATCH RT]. I think it worked since I haven't
> seen those mails.
thanks Sebastian for the input, we will consider this to add to our TODO.

> 
> > Thanks,
> >
> > 	tglx
> 
> Sebastian
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
