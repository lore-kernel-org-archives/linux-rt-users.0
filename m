From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v3 0/4] Simple wait queue support
Date: Mon, 26 Oct 2015 07:34:15 +0100
Message-ID: <562DC967.7060701@bmw-carit.de>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
 <20151025201033.GC5105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:38394 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbJZGeW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Oct 2015 02:34:22 -0400
In-Reply-To: <20151025201033.GC5105@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/25/2015 09:10 PM, Paul E. McKenney wrote:
> On Tue, Oct 20, 2015 at 09:28:06AM +0200, Daniel Wagner wrote:
>> Only small updates in this version, like fixing mips and reordering
>> two patches to avoid lockdep warning when doing git bissect.  Reported
>> by Fengguang Wu's build robot. Thanks!
>>
>> Also removed the unnecessary initialization in the rcu patch as Paul
>> pointed out.
>>
>> Hopefully, I do a better job on Cc list this time.
>>
>> These patches are against
>>
>>   tip/master 11f4d95e6b634d7d41e7c2b521fcec261efbf769
> 
> I didn't find this commit, so I am (temporarily!) applying against
> 19a5ecde086a (rcu: Suppress lockdep false positive for rcp->exp_funnel_mutex)
> for testing purposes.  

I verified it and I can't find it either in the upstream tree anymore.
The chances I got it wrong is quite likely considering that I just have
dangerous half knowledge on how the tip tree is organized. I was under
the impression that tip/master is a merge only branch. And even if that
is the case there is plenty of possibilities using git the wrong way.

Please let me know which tree is the preferred target. The patches seem
to apply cleanly on most trees so far.

> RCU appears to be a bit of a moving target here...

Yeah, the maintainer of RCU seems to be busy :)

cheers,
daniel

