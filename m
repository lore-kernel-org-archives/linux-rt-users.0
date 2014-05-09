From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ftrace: Simplify ring buffer resizing, make work with
 RT
Date: Fri, 09 May 2014 12:08:43 -0500
Message-ID: <536D0B9B.8070906@mvista.com>
References: <1399579402-27034-1-git-send-email-minyard@acm.org> <20140509131244.GF29014@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, minyard@acm.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140509131244.GF29014@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/09/2014 08:12 AM, Sebastian Andrzej Siewior wrote:
> * minyard@acm.org | 2014-05-08 15:03:22 [-0500]:
>
>> This isn't well tested, but fixes an obvious PREEMPT_RT problem and seems
>> like a good simplification.  You can see the PREEMPT_RT bug if you enable
>> ftrace and all the self tests; it will fail running selftests when it tries
>> to resize the buffers.
> I posted http://marc.info/?l=linux-rt-users&m=139962823022896&w=2 before
> I noticed this one. You seem not to touch the second hunk.
>
> Sebastian
That's a good solution, too.  I didn't notice the second hunk in my testing.

Thanks,

-corey
