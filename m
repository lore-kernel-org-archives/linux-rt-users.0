From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
Date: Tue, 9 Oct 2018 16:27:42 +0200
Message-ID: <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com>
 <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de>
 <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Dmitry Vyukov <dvyukov@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-10-08 11:15:57 [+0200], Dmitry Vyukov wrote:
> Hi Sebastian,
Hi Dmitry,

> This seems to beak quarantine_remove_cache( ) in the sense that some
> object from the cache may still be in quarantine when
> quarantine_remove_cache() returns. When quarantine_remove_cache()
> returns all objects from the cache must be purged from quarantine.
> That srcu and irq trickery is there for a reason.

That loop should behave like your on_each_cpu() except it does not
involve the remote CPU.

> This code is also on hot path of kmallock/kfree, an additional
> lock/unlock per operation is expensive. Adding 2 locked RMW per
> kmalloc is not something that should be done only out of refactoring
> reasons.
But this is debug code anyway, right? And it is highly complex imho.
Well, maybe only for me after I looked at it for the first time…

> The original message from Clark mentions that the problem can be fixed
> by just changing type of spinlock. This looks like a better and
> simpler way to resolve the problem to me.

I usually prefer to avoid adding raw_locks everywhere if it can be
avoided. However given that this is debug code and a few additional us
shouldn't matter here, I have no problem with Clark's initial patch
(also the mem-free in irq-off region works in this scenario).
Can you take it as-is or should I repost it with an acked-by?

Sebastian
