From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RT 2/2] net: gianfar: do not try to cleanup TX packets
 if they are not done
Date: Wed, 9 Apr 2014 19:48:36 -0500
Message-ID: <1397090916.20280.36.camel@snotra.buserror.net>
References: <1396004220-5711-1-git-send-email-bigeasy@linutronix.de>
	 <1396004220-5711-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Claudiu Manoil" <claudiu.manoil@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396004220-5711-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-03-28 at 11:57 +0100, Sebastian Andrzej Siewior wrote:
> What I observe is that the TX queue is not empty and does not make any
> progress. gfar_clean_tx_ring() does not clean up the packet because it
> is not completed yet.
> The root cause is that the DMA engine did not start yet (it was
> preempted before doing so) and that dumb loop, loops until that packet
> is gone.
> This is broken since c233cf4 ("gianfar: Fix tx napi polling").
> 
> What remains are spurious interrupts if CPU0 cleans up TX packages and
> CPU1 returns with IRQ_NONE.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Why is this only being sent to RT and not to netdev for mainline?

> ---
>  drivers/net/ethernet/freescale/gianfar.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 8f1afda..091945c 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -134,7 +134,6 @@ static int gfar_poll_sq(struct napi_struct *napi, int budget);
>  static void gfar_netpoll(struct net_device *dev);
>  #endif
>  int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit);
> -static void gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue);
>  static void gfar_process_frame(struct net_device *dev, struct sk_buff *skb,
>  			       int amount_pull, struct napi_struct *napi);
>  void gfar_halt(struct net_device *dev);
> @@ -2516,7 +2515,7 @@ static void gfar_align_skb(struct sk_buff *skb)
>  }
>  
>  /* Interrupt Handler for Transmit complete */
> -static void gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
> +static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
>  {
>  	struct net_device *dev = tx_queue->dev;
>  	struct netdev_queue *txq;
> @@ -2939,10 +2938,14 @@ static int gfar_poll(struct napi_struct *napi, int budget)

You changed the return from void to int, but you never added any return
statement.  GCC should have warned you about this...

-Scott
