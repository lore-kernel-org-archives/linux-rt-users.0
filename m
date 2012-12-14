From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/2] [ANNOUNCE] 3.4.22-rt34-rc1 stable review
Date: Fri, 14 Dec 2012 17:19:57 -0500
Message-ID: <1355523597.17101.407.camel@gandalf.local.home>
References: <20121212004557.110050982@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121212004557.110050982@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-12-11 at 19:45 -0500, Steven Rostedt wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 3.4.22-rt34-rc1.
> 
> Please scream at me if I messed something up. Please test the patches too.
> 
> The -rc release will be uploaded to kernel.org and will be deleted when
> the final release is out. This is just a review release (or release candidate).
> 
> The pre-releases will not be pushed to the git repository, only the
> final release is.
> 
> If all goes well, this patch will be converted to the next main release
> on 12/14/2012, let's hope it's not an unexpected journey!
> 

Sure enough I was taken on an unexpected journey today. Unfortunately it
wasn't in the theaters.

I guess there's a small bug with one of the patches, with a fix sent to
me by Mike. This needs to be in Thomas's latest before it goes into
stable.

        oldprio = p->prio;
-       if (oldprio == param->sched_priority)
+       if (oldprio == (MAX_RT_PRIO - 1) - param->sched_priority)
                goto out;


-- Steve
