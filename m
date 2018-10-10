From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Wed, 10 Oct 2018 15:48:56 +0200
Message-ID: <ae2fb170-1414-abea-25e1-7a790dff3eb8@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010115639.GA25534@sisyphus.home.austad.us>
 <20181010122454.GR5663@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>,
        Henrik Austad <henrik@austad.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010122454.GR5663@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/10/18 2:24 PM, Peter Zijlstra wrote:
>> I believe there were some papers circulated last year that looked at 
>> something similar to this when you had overlapping or completely disjoint 
>> CPUsets I think it would be nice to drag into the discussion. Has this been 
>> considered? (if so, sorry for adding line-noise!)
> Hurm, was that one of Bjorn's papers? Didn't that deal with AC of
> disjoint/overlapping sets?
> 

This paper:
https://people.mpi-sws.org/~bbb/papers/pdf/rtsj14.pdf

But, unless I am wrong, there were findings after this paper that shows
some imprecision on it.

Anyway, it does not analyse the locking properties, only scheduler of
independent tasks - it is a start, but far from what we do here.

(btw this paper is really complex...)

The locking problem for such case: APA with the nesting of different
locks in the locking implementation (we use raw spin lock on this, and
this method could also be used in the rw lock/sem in the future, nesting
rw_lock(mutex_proxy(raw_spinlock())) is an open problem from the
academic point of view.

I explained these things (nested lock and the need of APA for locking)
as "Open Problems" at the RTSOPs (part of the ECRTS) earlier this year:

http://rtsops2018.loria.fr/wp-content/uploads/2018/07/RTSOPS18_proceedings_final.pdf

Bjorn were there, but not only him... Baruah, Davis, Alan Burns were there.

There are some works being done for more complex locking in academy, like:

https://www.cs.unc.edu/~jarretc/papers/ecrts18b_long.pdf

But still, the task model used on these implementations are not the
Linux one.

-- Daniel
