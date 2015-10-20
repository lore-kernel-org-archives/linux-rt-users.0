From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2 3/4] rcu: use simple wait queues where possible in
 rcutree
Date: Tue, 20 Oct 2015 09:14:41 +0200
Message-ID: <5625E9E1.1020200@monom.org>
References: <1444808602-29500-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1444808602-29500-4-git-send-email-daniel.wagner@bmw-carit.de>
 <20151019233157.GD5105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: paulmck@linux.vnet.ibm.com,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151019233157.GD5105@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Paul,

On 10/20/2015 01:31 AM, Paul E. McKenney wrote:
> On Wed, Oct 14, 2015 at 09:43:21AM +0200, Daniel Wagner wrote:
>> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>> @@ -4178,7 +4178,8 @@ static void __init rcu_init_one(struct rcu_state *rsp,
>>  		}
>>  	}
>>
>> -	init_waitqueue_head(&rsp->gp_wq);
>> +	rsp->rda = rda;
> 
> This is initialized at compile time in current mainline, so the above
> statement is not needed.

I accidentally forward ported this from 3.10.

> But now that you mention it, the second parameter to rcu_init_one() is
> a bit pointless these days.  I have queued a patch eliminating it,
> which should not conflict with our patch.

Glad I can help :)

I am about to send an updated version of this series containing which
swaps this patch with #4 to avoid lockdep warning while doing bissect.
Obviously, the above statement will be gone as well.

cheers,
daniel
