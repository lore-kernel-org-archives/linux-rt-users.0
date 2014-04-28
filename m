From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/4] net: gianfar: do not try to cleanup TX packets
 if they are not done
Date: Mon, 28 Apr 2014 08:37:56 +0200
Message-ID: <535DF744.60606@linutronix.de>
References: <20140427143119.898655303@goodmis.org> <20140427143140.384915886@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60265 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaD1GiH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2014 02:38:07 -0400
In-Reply-To: <20140427143140.384915886@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/27/2014 04:31 PM, Steven Rostedt wrote:
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 5c0efcc..8aecc1d 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2856,10 +2855,14 @@ static int gfar_poll(struct napi_struct *napi, int budget)
>  			tx_queue = priv->tx_queue[i];
>  			/* run Tx cleanup to completion */
>  			if (tx_queue->tx_skbuff[tx_queue->skb_dirtytx]) {
> -				gfar_clean_tx_ring(tx_queue);
> -				has_tx_work = 1;
> +				int ret;
> +
> +				ret = gfar_clean_tx_ring(tx_queue);
> +				if (ret)
> +					has_tx_work++;
>  			}
>  		}
> +		work_done += has_tx_work;
>  
>  		for_each_set_bit(i, &gfargrp->rx_bit_map, priv->num_rx_queues) {
>  			/* skip queue if not active */

The 3.14-RT version of the patch should have an additional return
statement here which I forgot initially.

Sebastian
