From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
Date: Sat, 8 Jul 2017 15:25:14 +0800
Message-ID: <2bf3cdfa-f8b6-9d32-b3b5-33900cb9122a@linaro.org>
References: <1499330866-19520-1-git-send-email-alex.shi@linaro.org>
 <20170707102527.bg7ktbkazxl3qpqt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rik van Riel <riel@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34685 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdGHHZU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 8 Jul 2017 03:25:20 -0400
Received: by mail-pf0-f171.google.com with SMTP id q85so26985120pfq.1
        for <linux-rt-users@vger.kernel.org>; Sat, 08 Jul 2017 00:25:20 -0700 (PDT)
In-Reply-To: <20170707102527.bg7ktbkazxl3qpqt@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 07/07/2017 06:25 PM, Sebastian Andrzej Siewior wrote:
> On 2017-07-06 16:47:46 [+0800], Alex Shi wrote:
>> This patch replace a rwlock and raw notifier by atomic notifier which
> + is 
>> protected by spin_lock and rcu.
> …
>> Sebastian suggested using atomic_notifier instead of rwlock, which is not
>> only removing the sleeping in idle, but also getting better latency
>> improvement.
> 
> Did you measure this / have numbers or did you write this because this
> is what RCU does in general?

Uh, I have no number on the performance. The benefit is in the theory.
https://lwn.net/Articles/263130/
But above article give some comparison data of rwlock and RCU.

> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 

Thanks a lot!

Regards
Alex
