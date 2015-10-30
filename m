From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH -rt] Revert "net: use synchronize_rcu_expedited()"
Date: Fri, 30 Oct 2015 18:16:08 +0900 (KST)
Message-ID: <20151030.181608.1502431720880609527.davem@davemloft.net>
References: <20151027004422.GH5105@linux.vnet.ibm.com>
	<20151027123153.GG8245@jcartwri.amer.corp.natinst.com>
	<1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: joshc@ni.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
	bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: eric.dumazet@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445955481.7476.21.camel@edumazet-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 27 Oct 2015 07:18:01 -0700

> On Tue, 2015-10-27 at 07:31 -0500, Josh Cartwright wrote:
> 
>> Okay, yes, I like the first suggestion better as well, I've included a
>> patch below that does just that.  I hope you don't mind me turning it
>> into a Suggested-by :).
>> 
>> Thanks for taking a look!
>>   Josh
> 
> 
>> @@ -6969,7 +6969,7 @@ EXPORT_SYMBOL(free_netdev);
>>  void synchronize_net(void)
>>  {
>>  	might_sleep();
>> -	if (rtnl_is_locked())
>> +	if (rtnl_is_locked() && !IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
>>  		synchronize_rcu_expedited();
>>  	else
>>  		synchronize_rcu();
> 
> No objection from me. Thanks.
> 
> Acked-by: Eric Dumazet <edumazet@google.com>

I agree with the sentiment to do the simple thing here first before
adding potentially useless knobs.

Signed-off-by: David S. Miller <davem@davemloft.net>
