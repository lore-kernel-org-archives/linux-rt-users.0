From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ofa-general] [PATCH] [WORKAROUND] CONFIG_PREEMPT_RT and
	ib_umad_close() issue
Date: Mon, 17 Sep 2007 14:40:08 -0700
Message-ID: <adair69nf7r.fsf@cisco.com>
References: <46EEB715.7060509@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: general@lists.openfabrics.org, linux-rt-users@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>, linux-kernel@vger.kernel.org
To: john.blackwood@ccur.com
Return-path: <general-bounces@lists.openfabrics.org>
In-Reply-To: <46EEB715.7060509@ccur.com> (John Blackwood's message of "Mon,
	17 Sep 2007 13:19:17 -0400")
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

Thanks for the explanation...

 > But basically, with CONFIG_PREEMPT_RT enabled, the lock points, such as
 > aqcuiring a spinlock, potentially become places where the current task
 > may be context switched out / preempted.
 > 
 > Therefore, when a call is made to lock a spinlock for example, the
 > caller should not currently have irqs disabled, or preemption disabled,
 > since a context switch may occur.

this doesn't seem relevant here...

 > void fastcall rt_downgrade_write(struct rw_semaphore *rwsem)
 > {
 >         BUG();
 > }

this seems to be the problem... the -rt patch turns downgrade_write()
into a BUG().

I need to look at the locking in user_mad.c again, but I think it may
be possible to replace both places that do downgrade_write() with
up_write() followed by down_read().

 - R.
