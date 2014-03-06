From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in
 mmu_context_t
Date: Thu, 06 Mar 2014 16:36:50 -0500 (EST)
Message-ID: <20140306.163650.21682020672566331.davem@davemloft.net>
References: <20140304.141003.1969905483115684548.davem@davemloft.net>
	<20140304.152835.432307123220321373.davem@davemloft.net>
	<5316A85C.9080508@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: tkhai@yandex.ru, linux-rt-users@vger.kernel.org,
	sparclinux@vger.kernel.org, bigeasy@linutronix.de
To: allen.pais@oracle.com
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <5316A85C.9080508@oracle.com>
Sender: sparclinux-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 05 Mar 2014 10:00:20 +0530

> On Wednesday 05 March 2014 01:58 AM, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Tue, 04 Mar 2014 14:10:03 -0500 (EST)
>> 
>>> From: Kirill Tkhai <tkhai@yandex.ru>
>>> Date: Fri, 28 Feb 2014 18:51:23 +0400
>>>
>>>> This should be fixed like that's done for 8250
>>>> [patch drivers-serial-cleanup-locking-for-rt.patch]
>>>
>>> Like the patch below?
> 
> tested. Sounds good to me.
> Tested-by: Allen Pais <allen.pais@oracle.com>

Great, I've queued this up into my tree.
