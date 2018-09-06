From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Date: Thu, 6 Sep 2018 12:43:49 -0400
Message-ID: <20180906124349.56b89024@gandalf.local.home>
References: <20180905122754.443196118@goodmis.org>
        <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 6 Sep 2018 09:54:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-09-05 08:27:54 [-0400], Steven Rostedt wrote:
> > Dear RT Folks,
> > 
> > This is the RT stable review cycle of patch 4.14.63-rt41-rc1.
> > 
> > Please scream at me if I messed something up. Please test the patches too.
> > 
> > The -rc release will be uploaded to kernel.org and will be deleted when
> > the final release is out. This is just a review release (or release candidate).
> > 
> > The pre-releases will not be pushed to the git repository, only the
> > final release is.
> > 
> > If all goes well, this patch will be converted to the next main release
> > on 9/7/2018.  
> 
> Your tree (v4.14.63) has
>   80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
>   0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
>                  inline softirq")
> 
> which means that the patch "nohz: Prevent erroneous tick stop
> invocations" can be reverted / dropped. It might have clashed during the
> emerge of the stable tree.
>

My tree also has this:

commit 5536f5491a2e098 

    softirq: keep the 'softirq pending' check RT-only
    
    The patch "nohz: Prevent erroneous tick stop invocations" was merged
    differently upstream. The original issue where a slow box could lock up
    with a pending timer remained. I currently assume that this is a RT only
    issue and keep the patch as RT only.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>


What needs to be done?

-- Steve
