From: Li Zefan <lizefan@huawei.com>
Subject: Re: [PREEMPT RT] SLUB and split softirq lock for v3.2-rt
Date: Tue, 19 Feb 2013 09:54:58 +0800
Message-ID: <5122DB72.7030100@huawei.com>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de> <1360776274.23152.7.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360776274.23152.7.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2013/2/14 1:24, Steven Rostedt wrote:
> On Wed, 2013-02-13 at 17:11 +0100, Sebastian Andrzej Siewior wrote:
>> 3.2-rt is a long term supported kernel, which lacks two RT features
>> from 3.6: SLUB support and the split softirq lock implementation.
>>
>> SLUB has a way better performance than SLAB on RT and the split
>> softirq lock implementation is necessary especially for realtime
>> networking applications.
>>
>> The following patch series backports these features to 3.2-rt.
>>
>> Steven, could you please apply these patches to a separate
>> 3.2-rt-features branch?
> 
> Is it possible to separate these two features into two different patch
> sets. I would like to apply the softirq changes first, and then apply
> the slub changes.
> 
> Although it looks as though the first half is softirq only 1-8, and the
> second half is slub related 9-16. If that's the case, I'll just pull in
> 1-8 first, play with them, and then do 9-16.
> 

We've also ported these two features to 3.4-rt. Do you want us to post
them?
