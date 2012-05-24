From: Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH][UPSTREAM]net,RT:Remove preemption disabling in
 netif_rx()
Date: Thu, 24 May 2012 09:17:46 -0400
Message-ID: <1337865466.13348.175.camel@gandalf.stny.rr.com>
References: <1337227511-2271-1-git-send-email-Priyanka.Jain@freescale.com>
	 <AC83832D6324604BB08FAE5A33553F19079E17C8@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Srivastava Rajan-B34330 <B34330@freescale.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3952 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2EXNRs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 May 2012 09:17:48 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F19079E17C8@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-05-24 at 04:28 +0000, Jain Priyanka-B32167 wrote:
> Waiting for review comments on this.
> 

> diff --git a/net/core/dev.c b/net/core/dev.c index 452db70..4017820 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2940,7 +2940,7 @@ int netif_rx(struct sk_buff *skb)
>  		struct rps_dev_flow voidflow, *rflow = &voidflow;
>  		int cpu;
>  
> -		preempt_disable();
> +		migrate_disable();

I really want to avoid placing open coded migrate_disable() around the
kernel. Perhaps we should use "get_cpu_light()" here too.

-- Steve

>  		rcu_read_lock();
>  
>  		cpu = get_rps_cpu(skb->dev, skb, &rflow); @@ -2950,13 +2950,13 @@ int netif_rx(struct sk_buff *skb)
>  		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
>  
>  		rcu_read_unlock();
> -		preempt_enable();
> +		migrate_enable();
>  	} else
>  #endif
>  	{
>  		unsigned int qtail;
> -		ret = enqueue_to_backlog(skb, get_cpu(), &qtail);
> -		put_cpu();
> +		ret = enqueue_to_backlog(skb, get_cpu_light(), &qtail);
> +		put_cpu_light();
>  	}
>  	return ret;
>  }
> --
> 1.7.4.1
> 
> 


