From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 4.8-rc5-rt1 beta
Date: Sat, 17 Sep 2016 16:45:06 -0400
Message-ID: <20160917204505.GP2513@windriver.com>
References: <20160906182508.GB9950@windriver.com>
 <1473313660.9698.38.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473313660.9698.38.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[Re: [ANNOUNCE] 4.8-rc5-rt1 beta] On 08/09/2016 (Thu 07:47) Mike Galbraith wrote:

> On Tue, 2016-09-06 at 14:25 -0400, Paul Gortmaker wrote:
> 
> >   Patch conflicts/issues of interest 4.6 --> 4.7
> >   ----------------------------------------------
> > 
> > -v4.7 introduced a lot of users of down_write_killable which wasn't
> >  implemented for -rt (rwsem_rt.h), so I created one.  (see new patch
> >  rt-create-down_write_killable.patch -- local commit 14625e96ff085f),
> >  it probably warrants a look see from other people smarter than me.
> 
> You forgot nested, so btrfs won't build.  I posted a patchlet here that
> includes it.

I didn't see the patchlet, so I just did my own:  https://goo.gl/MNiUy7
Let me know if anything looks wrong with it.

I also integrated the latest changes from Sebastian from the 4.6 branch
for this 4.8 repo; build tested btrfs and sanity boot tested the series
against 4.8-rc6 and pushed the changes out:

https://git.kernel.org/cgit/linux/kernel/git/paulg/4.8-rt-patches

Everything else is unchanged (incl. the NFS borkage below.)

Paul.
--

> 
> > -Al Viro added a 2nd user of down_read_non_owner into NFS unlink.
> >  Previously it was just bcache and Sebastian just made that depend on
> >  !RT_FULL (md-disable-bcache.patch).  So we'll need to decide what to
> >  with that; I just ignored NFS for now, since it is horrible anyway.
> >  (see upstream commit 884be175351e73c)
> 
> Yeah, that is annoying.  I've been carrying a revert ever since, with
> poke nfs on todo, but it seems to be marooned there (haven't even
> gotten around to generating the first obligatory explosion).
> 
> 	-Mike
