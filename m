From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/3] swait: Add memory barrier before checking list
 empty
Date: Mon, 19 Aug 2013 11:51:55 -0400
Message-ID: <20130819115155.41f909fe@gandalf.local.home>
References: <20130819153530.409041534@goodmis.org>
	<20130819153618.983248997@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130819153618.983248997@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 19 Aug 2013 11:35:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There's a race condition with swait wakeups and adding to the list. The
> __swait_wake() does a check for swait_head_has_waiters(), and if it is
> empty it will exit without doing any wake ups. The problem is that the
> check does not include any memory barriers before it makes a decision
> to wake up or not.
> 
> 	CPU0				CPU1
> 	----				----
> 
>   condition = 1
> 
>   load h->list (is empty)
> 				    raw_spin_lock(hlist->lock)
> 				    hlist_add();
> 				    __set_current_state();
> 				    raw_spin_unlock(hlist->lock)
>   swait_wake()
>    swait_head_has_waiters()
>    (sees h->list as empty and returns)
> 

BTW, the race still exists if you move the raw_spin_unlock(hlist->lock)
above to here. That is:

   swait_wake()
    swait_head_has_waiters()
     (sees h->list as empty and returns)

				    raw_spin_unlock(hlist->lock)


Maybe this will help to understand it more.

-- Steve

> 				    check_condition (sees condition = 0)
> 
>    store condition = 1
> 
> 				    schedule()
> 
> Now the task on CPU1 has just missed its wakeup. By adding a memory
> barrier before the list empty check, we fix the problem of miss seeing
> the list not empty as well as pushing out the condition for the other
> task to see.
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
