From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [RT] sysrq Z: sleeping function called from invalid context
Date: Fri, 2 Dec 2011 16:27:22 -0800
Message-ID: <4ED96CEA.7060404@am.sony.com>
References: <4ED95A5F.7030309@am.sony.com> <1322869775.30977.61.camel@frodo>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:18059
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752416Ab1LCAde (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Dec 2011 19:33:34 -0500
In-Reply-To: <1322869775.30977.61.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/02/11 15:49, Steven Rostedt wrote:
> On Fri, 2011-12-02 at 15:08 -0800, Frank Rowand wrote:
>> Hi Steve,
>>
>> I get a "sleeping function called from invalid context" when I invoke sysrq Z.
>>
>> I get this both with CONFIG_MAGIC_SYSRQ_FORCE_PRINTK enabled and disabled.
> 
> Patient:  Hey doctor, it hurts when I do this
> 
> Doctor:  Don't do that.

I had similar thoughts as I was writing my email.

< snip >

> 
> Oh! looking into the ring_buffer code, could you add this:
> (totally untested)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2467714..2ffbb9d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1045,7 +1045,7 @@ static inline int ok_to_lock(void)
>  	if (in_nmi())
>  		return 0;
>  #ifdef CONFIG_PREEMPT_RT_FULL
> -	if (in_atomic())
> +	if (in_atomic() || irqs_disabled())
>  		return 0;
>  #endif
>  	return 1;

I would say the result is good with the patch applied.

If CONFIG_MAGIC_SYSRQ_FORCE_PRINTK is disabled then the splat does not occur
and the ftrace buffer is printed on the console.

If CONFIG_MAGIC_SYSRQ_FORCE_PRINTK is enabled, then the splat does not occur
and the ftrace buffer sometimes is printed on the console.  I think that
this is good enough, given that sysrq when CONFIG_PREEMPT_RT_FULL is enabled
is somewhat dicey to begin with.

-Frank

