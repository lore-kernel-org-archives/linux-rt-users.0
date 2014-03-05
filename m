From: Allen Pais <allen.pais@oracle.com>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in
 mmu_context_t
Date: Wed, 05 Mar 2014 10:04:56 +0530
Message-ID: <5316A970.1000808@oracle.com>
References: <52FB65AC.4000808@oracle.com> <268891392209126@web5h.yandex.ru> <53042ACA.6060907@oracle.com> <20140304.150100.26024134985698152.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tkhai@yandex.ru, linux-rt-users@vger.kernel.org,
	sparclinux@vger.kernel.org, bigeasy@linutronix.de
To: David Miller <davem@davemloft.net>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20140304.150100.26024134985698152.davem@davemloft.net>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 05 March 2014 01:31 AM, David Miller wrote:
> From: Allen Pais <allen.pais@oracle.com>
> Date: Wed, 19 Feb 2014 09:23:46 +0530
> 
>>  I realized locking in tsb is very tricky. My attempts to try and get hackbench run
>> without causing a stall failed. So here's what I tried to fix it, am not sure if it's
>> an appropriate fix, I would love to get comments. I have tested this fix for over 24 hours
>> with hackbench and dd, the system did not stall :)
> 
> If using a local lock fixes your problem, it just means we're being
> preempted during flush_tsb_user() which is absolutely not allowed.

David, Its my bad, I realized my mistake of using local locks.
Am still looking into the tsb flush code. It's left me sleepless. :)
 

> The batch is a per-cpu object, and must be forcibly flushed if we
> preempt.
> 

