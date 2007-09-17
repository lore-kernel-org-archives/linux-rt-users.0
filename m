From: John Blackwood <john.blackwood@ccur.com>
Subject: Re: [ofa-general] [PATCH] [WORKAROUND] CONFIG_PREEMPT_RT and
	ib_umad_close() issue
Date: Mon, 17 Sep 2007 19:41:22 -0400
Message-ID: <46EF10A2.40905@ccur.com>
References: <46EEB715.7060509@ccur.com> <adair69nf7r.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: general@lists.openfabrics.org, linux-rt-users@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>, linux-kernel@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Return-path: <general-bounces@lists.openfabrics.org>
In-Reply-To: <adair69nf7r.fsf@cisco.com>
List-Unsubscribe: <http://lists.openfabrics.org/cgi-bin/mailman/listinfo/general>,
	<mailto:general-request@lists.openfabrics.org?subject=unsubscribe>
List-Archive: <http://lists.openfabrics.org/pipermail/general>
List-Post: <mailto:general@lists.openfabrics.org>
List-Help: <mailto:general-request@lists.openfabrics.org?subject=help>
List-Subscribe: <http://lists.openfabrics.org/cgi-bin/mailman/listinfo/general>,
	<mailto:general-request@lists.openfabrics.org?subject=subscribe>
Sender: general-bounces@lists.openfabrics.org
Errors-To: general-bounces@lists.openfabrics.org
List-Id: linux-rt-users.vger.kernel.org

Roland Dreier wrote:
> Thanks for the explanation...
> 
>  > But basically, with CONFIG_PREEMPT_RT enabled, the lock points, such as
>  > aqcuiring a spinlock, potentially become places where the current task
>  > may be context switched out / preempted.
>  > 
>  > Therefore, when a call is made to lock a spinlock for example, the
>  > caller should not currently have irqs disabled, or preemption disabled,
>  > since a context switch may occur.
> 
> this doesn't seem relevant here...

Hi Roland,

right.  just some background info.

>  > void fastcall rt_downgrade_write(struct rw_semaphore *rwsem)
>  > {
>  >         BUG();
>  > }
> 
> this seems to be the problem... the -rt patch turns downgrade_write()
> into a BUG().
> 
> I need to look at the locking in user_mad.c again, but I think it may
> be possible to replace both places that do downgrade_write() with
> up_write() followed by down_read().
> 
>  - R.


that sounds like it would be a good solution for both preempt rt and 
non-preempt rt kernels.

thanks again for looking at this for us.
