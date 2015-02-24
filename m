From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 3.18.7-rt2
Date: Tue, 24 Feb 2015 18:50:14 +0100
Message-ID: <1424800214.6955.30.camel@gmail.com>
References: <20150223090617.GA26453@linutronix.de>
	 <1424785301.8767.11.camel@gmail.com>
	 <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Gustavo Bittencourt <gbitten@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA8Xd+9QEn0XE2pV-7fW0cBXKBSK9=oZyTaFH2urGvJLGb=gFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-24 at 13:19 -0300, Gustavo Bittencourt wrote:
> On Tue, Feb 24, 2015 at 10:41 AM, Mike Galbraith
> <umgwanakikbuti@gmail.com> wrote:
> > locking, ww_mutex: fix ww_mutex vs self-deadlock
> >
> > If the caller already holds the mutex, task_blocks_on_rt_mutex()
> > returns -EDEADLK, we proceed directly to rt_mutex_handle_deadlock()
> > where it's instant game over.
> >
> > Let ww_mutexes return EDEADLK/EALREADY as they want to instead.
> >
> > Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> > ---
> >  kernel/locking/rtmutex.c |   17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> 
> The deadlock returned after I applied this patch in v3.18.7-rt2. Here is my log:


Hrmph.  I definitely want your patch to die ;-)  It adds a whole new
dimension to ww_mutex that only now exists in -rt.  That's not good.  My
patchlet may not be perfect either, but it lets ww_mutex do that return
EALREADY business it's supposed to, vs going straight to while(1).  We
can't have it both ways, so I suppose I'll fire up my old Q6600 box
(that doesn't have annoying GTX980 that my userspace can't deal with DRM
wise), and see if I can chase the nouveau thing down.  I'm not all that
enthusiastic though, as there are or at least were other issues with
nouveau.  Sebastian reported some completely _missing_ locking IIRC,
that led to his box exploding. 

	-Mike
