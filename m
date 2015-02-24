From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Mon, 23 Feb 2015 19:57:43 -0500
Message-ID: <20150223195743.546b2ef0@grimm.local.home>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1424395866-81589-2-git-send-email-tmac@hp.com>
 <20150223133719.2b7c604e@gandalf.local.home>
 <54EBC2DB.3050904@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EBC2DB.3050904@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 23 Feb 2015 17:16:27 -0700
Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com> wrote:


> Thanks again for the comments and suggestion.
> 
> Yes, creating a per cpu fake task was one of the alternative considered.
>  I believe one of the reasons I did not purse is the amount of extra
> storage it requires (sizeof(struct task_struct) * number of cpus.
> Though the changes may not be as intrusive as the one I sent, some are
> still required, mainly with current (one in particular came to mind is
> in wakeup_next-watier()).

Yeah, that's a draw back, but still. Big CPU machines should have big
memory. If we really are concerned, we could tidy up task_struct a bit,
rearranging the fields to make sure like fields are together (helps
with cache too) and move the RT stuff up further. Then we could
allocate just enough to cover all the task struct fields that are
accessed in the rtmutex code.


> 
> If I'm not mistaken, another reason could also be due to the rate of the
> timer interrupt, in the case that the mutex is highly contested IH could
> stall the non-real-time requester for a long time, even to the point of
> the cpu is perceived as hung.

Perhaps we should just have trylocks fail if there are other waiters.
As it wont slow down the high priority task. And doing that would
probably even help other rt tasks that are blocked on the lock waiting
for a release. Why make those tasks wait more if even a higher priority
task is simply doing a trylock and can safely fail it. At least we
could do that if the task trying to get the lock is a interrupt.

-- Steve
