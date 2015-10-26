From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/4] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Mon, 26 Oct 2015 14:26:01 +0100
Message-ID: <20151026132601.GV2508@worktop.programming.kicks-ass.net>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1445326090-1698-2-git-send-email-daniel.wagner@bmw-carit.de>
 <20151026120426.GA1497@fixme-laptop.cn.ibm.com>
 <562E23C0.9000500@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <562E23C0.9000500@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Oct 26, 2015 at 01:59:44PM +0100, Daniel Wagner wrote:
> Hi Boqun,
> 
> On 10/26/2015 01:04 PM, Boqun Feng wrote:
> > On Tue, Oct 20, 2015 at 09:28:07AM +0200, Daniel Wagner wrote:
> >> +
> >> +/*
> >> + * The thing about the wake_up_state() return value; I think we can ignore it.
> >> + *
> >> + * If for some reason it would return 0, that means the previously waiting
> >> + * task is already running, so it will observe condition true (or has already).
> >> + */
> >> +void swake_up_locked(struct swait_queue_head *q)
> >> +{
> >> +	struct swait_queue *curr;
> >> +
> >> +	list_for_each_entry(curr, &q->task_list, task_list) {
> >> +		wake_up_process(curr->task);
> >> +		list_del_init(&curr->task_list);
> >> +		break;
> > 
> > Just be curious, what's this break for? Or what's this loop(?) for?
> 
> I have to guess here, since Peter wrote it. It looks like the function
> is based on __wake_up_common(). Though I agree the loop is not necessary
> and something like below should the trick. Unless I do not see something
> important.
> 
> 	void swake_up_locked(struct swait_queue_head *q)
> 	{
> 		struct swait_queue *curr;
> 
> 		if (list_emtpy(&q))
> 			return;
> 
> 		curr = list_first_entry(&q, typeof(*curr), task_list);
> 		wake_up_process(curr->task);
> 		list_del_init(&curr->task_list);
> 	}
> 
> If Peter is not complaining I change swake_up_locked() for the next version.

Yes, that is equivalent, just more code. As I wrote in my last email; I
was lazy :-)
