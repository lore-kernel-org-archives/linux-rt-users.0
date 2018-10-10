From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
Date: Wed, 10 Oct 2018 11:57:41 +0200
Message-ID: <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de> <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de> <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de> <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010095343.6qxved3owi6yokoa@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 10, 2018 at 11:53 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-10-10 11:45:32 [+0200], Dmitry Vyukov wrote:
>> > Should I repost Clark's patch?
>>
>>
>> I am much more comfortable with just changing the type of the lock.
>
> Yes, that is what Clark's patch does. Should I resent it?


Yes. Clark's patch looks good to me. Probably would be useful to add a
comment as to why raw spinlock is used (otherwise somebody may
refactor it back later).


>> What are the bad implications of using the raw spinlock? Will it help
>> to do something along the following lines:
>>
>> // Because of ...
>> #if CONFIG_RT
>> #define quarantine_spinlock_t raw_spinlock_t
>> #else
>> #define quarantine_spinlock_t spinlock_t
>> #endif
>
> no. For !RT spinlock_t and raw_spinlock_t are the same. For RT
> spinlock_t does not disable interrupts or preemption while
> raw_spinlock_t does.
> Therefore holding a raw_spinlock_t might increase your latency.

Ack.
