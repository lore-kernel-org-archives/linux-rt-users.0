From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Date: Thu, 6 Sep 2018 21:30:29 +0200
Message-ID: <20180906193028.jvyp2dj3rto4ax7s@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
 <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
 <20180906124349.56b89024@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906124349.56b89024@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-06 12:43:49 [-0400], Steven Rostedt wrote:
> > Your tree (v4.14.63) has
> >   80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
> >   0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
> >                  inline softirq")
> > 
> > which means that the patch "nohz: Prevent erroneous tick stop
> > invocations" can be reverted / dropped. It might have clashed during the
> > emerge of the stable tree.
> >
> 
> My tree also has this:
> 
> commit 5536f5491a2e098 
> 
>     softirq: keep the 'softirq pending' check RT-only
>     
>     The patch "nohz: Prevent erroneous tick stop invocations" was merged
>     differently upstream. The original issue where a slow box could lock up
>     with a pending timer remained. I currently assume that this is a RT only
>     issue and keep the patch as RT only.
>     
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> 
> What needs to be done?

This commit can be removed / reverted. The two commits (80d20d35af1ed
and 0a0e0829f9901) fix the issue and this duct-tape commit
(5536f5491a2e098) is no longer required.

> -- Steve

Sebastian
