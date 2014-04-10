From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/2] net: gianfar: do not try to cleanup TX packets
 if they are not done
Date: Thu, 10 Apr 2014 09:20:25 +0200
Message-ID: <53464639.2040208@linutronix.de>
References: <1396004220-5711-1-git-send-email-bigeasy@linutronix.de>	 <1396004220-5711-2-git-send-email-bigeasy@linutronix.de> <1397090916.20280.36.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397090916.20280.36.camel@snotra.buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/10/2014 02:48 AM, Scott Wood wrote:
> Why is this only being sent to RT and not to netdev for mainline?

I tried. And complained about how that problem was fixed by a duct tape
solution (by dropping the outer loop) instead of understanding the
problem and fixing it properly. Even Eric tied to point out that there
might be something else going on. Look at netdev for "gianfar: Simplify
MQ polling to avoid soft lockup".
The threaded ended ended up with the fact that I took this for -RT only
because netdev had already code for v3.15 and Claudiu managed to
rewrite that part (again) and added napi for TX. So that Patch as-is
does not apply anymore.
With NAPI for TX I had may no longer persists so I will probably drop
this patch in -RT >= 3.15

>> --- a/drivers/net/ethernet/freescale/gianfar.c
>> +++ b/drivers/net/ethernet/freescale/gianfar.c
>> @@ -2516,7 +2515,7 @@ static void gfar_align_skb(struct sk_buff *skb)
>>  }
>>  
>>  /* Interrupt Handler for Transmit complete */
>> -static void gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
>> +static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
>>  {
>>  	struct net_device *dev = tx_queue->dev;
>>  	struct netdev_queue *txq;
>> @@ -2939,10 +2938,14 @@ static int gfar_poll(struct napi_struct *napi, int budget)
> 
> You changed the return from void to int, but you never added any return
> statement.  GCC should have warned you about this...

Interesting. I remember that I added "howmany" as return value. I
remember testing it. And yet there is evidence that I did not such a
thing. I will add it. Thanks for pointing out.

> 
> -Scott
> 

Sebastian
