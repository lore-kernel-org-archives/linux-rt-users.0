From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Tue, 24 Feb 2015 17:00:31 -0300
Message-ID: <CAA8Xd+-+zGz8R2H2t1Smp0erN7NtwDLbxAWshRz_FjU2T8CnEA@mail.gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	<1424785301.8767.11.camel@gmail.com>
	<CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
	<1424800214.6955.30.camel@gmail.com>
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
In-Reply-To: <1424800214.6955.30.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Feb 24, 2015 at 2:50 PM, Mike Galbraith
<umgwanakikbuti@gmail.com> wrote:
> On Tue, 2015-02-24 at 13:19 -0300, Gustavo Bittencourt wrote:

>>
>> The deadlock returned after I applied this patch in v3.18.7-rt2. Here is my log:
>
>
> Hrmph.  I definitely want your patch to die ;-)  It adds a whole new
> dimension to ww_mutex that only now exists in -rt.  That's not good.

No problem.

> My
> patchlet may not be perfect either, but it lets ww_mutex do that return
> EALREADY business it's supposed to, vs going straight to while(1).  We
> can't have it both ways, so I suppose I'll fire up my old Q6600 box
> (that doesn't have annoying GTX980 that my userspace can't deal with DRM
> wise), and see if I can chase the nouveau thing down.  I'm not all that
> enthusiastic though, as there are or at least were other issues with
> nouveau.  Sebastian reported some completely _missing_ locking IIRC,
> that led to his box exploding.

Is there anyway that I could help? I think I can write a code to
reproduce the deadlock without the nouveau driver.
