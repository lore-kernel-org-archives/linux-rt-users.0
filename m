From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Thu, 2 Feb 2012 16:53:15 +0100
Message-ID: <4F2AB16B.4090305@digi.com>
References: <4F292FE0.7090302@digi.com> <4F2A8850.4080201@digi.com> <201202021525.05606.tim.sander@hbm.com> <201202021632.50065.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"efault@gmx.de" <efault@gmx.de>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail210.messagelabs.com ([216.82.250.179]:55030 "EHLO
	mail210.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab2BBPxZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 10:53:25 -0500
In-Reply-To: <201202021632.50065.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tim,

On 02/02/2012 04:32 PM, Tim Sander wrote:
> Attached you will find a hacky patch which should just verify that the problem
> hypothesis can be validated.
> It just initializes the phy with driver initialisation and should work around
> this ksoftirq/sirq-net-tx problem.

Confirmed, this hack works around the problem.


> ---
>   drivers/net/fec.c |   58 ++++++++++++++++++++++++++++------------------------
>   1 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 885d8ba..292ae7e 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -231,6 +231,7 @@ static void *swap_buffer(void *bufaddr, int len)
>          return bufaddr;
>   }
>
> +
>   static netdev_tx_t
>   fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   {
> @@ -1135,24 +1136,6 @@ static int
>   fec_enet_open(struct net_device *ndev)
>   {
>          struct fec_enet_private *fep = netdev_priv(ndev);
> -       int ret;
> -
> -       /* I should reset the ring buffers here, but I don't yet know
> -        * a simple way to do that.
> -        */
> -
> -       ret = fec_enet_alloc_buffers(ndev);
> -       if (ret)
> -               return ret;
> -
> -       /* Probe and connect to PHY when open the interface */
> -       ret = fec_enet_mii_probe(ndev);
> -       if (ret) {
> -               fec_enet_free_buffers(ndev);
> -               return ret;
> -       }
> -       phy_start(fep->phy_dev);
> -       netif_start_queue(ndev);
>          fep->opened = 1;
>          return 0;
>   }
> @@ -1164,15 +1147,6 @@ fec_enet_close(struct net_device *ndev)
>
>          /* Don't know what to do yet. */
>          fep->opened = 0;
> -       netif_stop_queue(ndev);
> -       fec_stop(ndev);
> -
> -       if (fep->phy_dev) {
> -               phy_stop(fep->phy_dev);
> -               phy_disconnect(fep->phy_dev);
> -       }
> -
> -       fec_enet_free_buffers(ndev);
>
>          return 0;
>   }
> @@ -1432,10 +1406,32 @@ fec_probe(struct platform_device *pdev)
>          netif_carrier_off(ndev);
>
>          ret = register_netdev(ndev);
> +
>          if (ret)
>                  goto failed_register;
>
> +// Tim: very hacky for testing
> +       /* I should reset the ring buffers here, but I don't yet know
> +        * a simple way to do that.
> +        */
> +
> +       ret = fec_enet_alloc_buffers(ndev);
> +       if (ret)
> +               return ret;
> +
> +       /* Probe and connect to PHY when open the interface */
> +       ret = fec_enet_mii_probe(ndev);
> +       if (ret) {
> +               fec_enet_free_buffers(ndev);
> +               return ret;
> +       }
> +       phy_start(fep->phy_dev);
> +       netif_start_queue(ndev);
> +       fep->opened = 1;
> +// end hacky
> +
>          return 0;
> +
>
>   failed_register:
>          fec_enet_mii_remove(fep);
> @@ -1466,7 +1462,15 @@ fec_drv_remove(struct platform_device *pdev)
>          struct fec_enet_private *fep = netdev_priv(ndev);
>          struct resource *r;
>
> +       netif_stop_queue(ndev);
>          fec_stop(ndev);
> +
> +       if (fep->phy_dev) {
> +               phy_stop(fep->phy_dev);
> +               phy_disconnect(fep->phy_dev);
> +       }
> +
> +       fec_enet_free_buffers(ndev);
>          fec_enet_mii_remove(fep);
>          clk_disable(fep->clk);
>          clk_put(fep->clk);

