From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Thu, 29 Jun 2017 11:56:59 +0200
Message-ID: <7a940c90-206d-05cd-a73d-c5456a60bbfe@manjaro.org>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
 <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
 <20170629075000.haum2aiv25pj2xpg@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.manjaro.org ([176.9.38.148]:49386 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdF2J5E (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2017 05:57:04 -0400
In-Reply-To: <20170629075000.haum2aiv25pj2xpg@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 29/06/17 09:50, Sebastian Andrzej Siewior wrote:
> On 2017-06-29 02:30:12 [+0200], Bernhard Landauer wrote:
>> I'm unable to compile the ndiswrapper extramodule against 4.11.7-rt3
> I am surprised that this is still needed.
>
>> I get lots of errors of the kind
>>
>> 'struct task_struct' has no member named 'cpus_allowed'; did you mean
>> 'nr_cpus_allowed'?
>>
>> What can I do?
> You should only need a read copy and ->cpus_ptr is for that.
ntoskernel.h has this:

   #define tsk_cpus_allowed(tsk) (&(tsk)->cpus_allowed)

so should it become:

   #define tsk_cpus_allowed(tsk) ((tsk)->cpus_ptr)

?

>
>> kind regards
>> Bernhard
> Sebastian

