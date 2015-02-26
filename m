From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Thu, 26 Feb 2015 13:40:27 -0300
Message-ID: <CAA8Xd+-hCKnuy96PMoo2T5xwDPNh+79sme8bakK_ossMbfMs7Q@mail.gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	<1424785301.8767.11.camel@gmail.com>
	<CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
	<1424937725.3622.31.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424937725.3622.31.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Feb 26, 2015 at 5:02 AM, Mike Galbraith
<umgwanakikbuti@gmail.com> wrote:
> On Tue, 2015-02-24 at 13:19 -0300, Gustavo Bittencourt wrote:
>
>> The deadlock returned after I applied this patch in v3.18.7-rt2.
>
> Grr, because dummy here munged a reject when he backported to 3.18-rt.
> Please try the below, my trusty old Q6600 box is now running with
> nouveau/drm in both 3.18-rt and 4.0-rt.
>
> I found what was breaking my core2 lappy in 4.0-rt as well, namely the
> rtmutex.c set_current_state() munging that went into mainline recently,
> and that also broke my Q6600 box with nouveau/drm as well!  Seems you
> need a slow box and drm to experience the breakage nice and repeatably,
> which is kinda worrisome.  Anyway, all of my boxen can use drm just fine
> in both rt trees now, so your box _should_ be happy too.
>

Mike, my box is running very well now. Thanks.
