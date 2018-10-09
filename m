From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Tue, 9 Oct 2018 13:56:40 +0200
Message-ID: <9837aa4b-1bd4-bc6a-84f7-0b8704995d44@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        will.deacon@arm.com, andrea.parri@amarulasolutions.com,
        dietmar.eggemann@arm.com, patrick.bellasi@arm.com,
        henrik@austad.us, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 10/9/18 12:51 PM, Sebastian Andrzej Siewior wrote:
>> The main concerns I have with the current approach is that, being based
>> on mutex.c, it's both
>>
>>  - not linked with futexes
>>  - not involving "legacy" priority inheritance (rt_mutex.c)
>>
>> I believe one of the main reasons Peter started this on mutexes is to
>> have better coverage of potential problems (which I can assure everybody
>> it had). I'm not yet sure what should we do moving forward, and this is
>> exactly what I'd be pleased to hear your opinions on.
> wasn't the idea that once it works to get rid of rt_mutex?

As far as I know, it is. But there are some additional complexity
involving a -rt version of this patch, for instance:

What should the protocol do if the thread migrating is with migration
disabled?

The side effects of, for instance, ignoring the migrate_disable() would
add noise for the initial implementation... too much complexity at once.

IMHO, once it works in the non-rt, it will be easier to do the changes
needed to integrate it with -rt.

Thoughts?

-- Daniel
