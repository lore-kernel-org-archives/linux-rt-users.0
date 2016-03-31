From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v0] Use swait in completion
Date: Thu, 31 Mar 2016 08:14:24 +0200
Message-ID: <56FCC040.7080504@monom.org>
References: <1457452754-24029-1-git-send-email-wagi@monom.org>
 <20160308175206.GD21842@linutronix.de>
 <20160308182656.GA27081@jcartwri.amer.corp.natinst.com>
 <20160309122423.GD10517@linutronix.de>
 <20160328145702.589da4bd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Josh Cartwright <joshc@ni.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160328145702.589da4bd@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 03/28/2016 08:57 PM, Steven Rostedt wrote:
> On Wed, 9 Mar 2016 13:24:23 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
>> * Josh Cartwright | 2016-03-08 12:26:56 [-0600]:
>>
>>> Is it really just about latency?  Does this deferral not lead to an
>>> inversion in the case where the single woken task isn't the highest
>>> priority waiter on the completion (and doesn't run due to a
>>> middle-priority thing spinning)?  
>>
>> This would be case, yes. Not only with deferral. Say you have two
>> waters: 1st one is MID-prio and the second is HI-prio. Currently after
>> the wakeup of the MID-prio waiter you get preempted. Waking all of them
>> at once would put the second waiter first on the CPU.
>> Samething without the deferral flag.
>>
>>> In order for this to work, it seems like the chosen waiter would need to
>>> inherit the highest priority of all waiters (which AFAICT isn't
>>> happening).  
>>
>> sorting the waiters by priority? This will be fun. This is only done for
>> the rtmutex waiters.
>>
> 
> Hmm, perhaps we should use an rbtree to sort simple waiters by
> priority :-)
> 
> Probably wont make them simple anymore.

I am going through the users of complete_all(). So far I couldn't
identify any user with more than one waiter. That doesn't mean they
don't exist (maybe overlooked).

The -rt version of this patch contains a WARN_ON() in complete_all() if
there are more than one waiter. During resume some warnings are printed.
Let's see if there are more reports showing up.

If the common use case is one waiter and only in slow paths we see
several waiters I would like to avoid to adding fairness and increase
the complexity.

cheers,
daniel
