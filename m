From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.8-rc5-rt1 beta
Date: Thu, 08 Sep 2016 07:47:40 +0200
Message-ID: <1473313660.9698.38.camel@gmail.com>
References: <20160906182508.GB9950@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906182508.GB9950@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2016-09-06 at 14:25 -0400, Paul Gortmaker wrote:

>   Patch conflicts/issues of interest 4.6 --> 4.7
>   ----------------------------------------------
> 
> -v4.7 introduced a lot of users of down_write_killable which wasn't
>  implemented for -rt (rwsem_rt.h), so I created one.  (see new patch
>  rt-create-down_write_killable.patch -- local commit 14625e96ff085f),
>  it probably warrants a look see from other people smarter than me.

You forgot nested, so btrfs won't build.  I posted a patchlet here that
includes it.

> -Al Viro added a 2nd user of down_read_non_owner into NFS unlink.
>  Previously it was just bcache and Sebastian just made that depend on
>  !RT_FULL (md-disable-bcache.patch).  So we'll need to decide what to
>  with that; I just ignored NFS for now, since it is horrible anyway.
>  (see upstream commit 884be175351e73c)

Yeah, that is annoying.  I've been carrying a revert ever since, with
poke nfs on todo, but it seems to be marooned there (haven't even
gotten around to generating the first obligatory explosion).

	-Mike
