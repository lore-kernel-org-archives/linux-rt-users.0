From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: bisected - arm64 kvm unit test failures
Date: Wed, 22 Aug 2018 14:50:45 +0100
Message-ID: <77ab9a57-b3ad-d8fa-7dc8-b94527f56139@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
 <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
 <1533061729.12487.26.camel@gmx.de>
 <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
 <1534945105.8087.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534945105.8087.8.camel@gmx.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 22/08/18 14:38, Mike Galbraith wrote:
> On Tue, 2018-08-21 at 16:34 +0100, Marc Zyngier wrote:
>> Could you give that patchlet[1] a go? It solves a similar issue for me
>> on a different platform.
>>
>> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html
> 
> Yup, all better.

Now I'm not sure it actually fixes anything. Alex's test case seem to
have opened a new can of worms... In tracing hell at the moment.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
