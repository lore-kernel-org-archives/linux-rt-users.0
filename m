From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 11:09:34 +0100
Message-ID: <4F2BB25E.7090708@digi.com>
References: <4F292FE0.7090302@digi.com>	 <201202021338.44950.tim.sander@hbm.com> <4F2A8850.4080201@digi.com>	 <201202021525.05606.tim.sander@hbm.com> <1328206245.5882.113.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Sander <tim.sander@hbm.com>, linux-rt-users@vger.kernel.org,
	lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail201.messagelabs.com ([216.82.254.211]:32354 "EHLO
	mail201.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab2BCKJl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 05:09:41 -0500
In-Reply-To: <1328206245.5882.113.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,

On 02/02/2012 07:10 PM, Steven Rostedt wrote:
> That said, as I think I know the problem, can you try this patch to s=
ee
> if it fixes things. This patch is a TOTAL HACK! Not for inclusion. It=
's
> racy and buggy. I didn't even compile it because I couldn't get the
> configs to enable FEC, and I was too lazy to set up my cross compiler=
 to
> test it. ;-)

Yes, this hack fixes things as long as I boot with the Ethernet cable p=
lugged in. In=20
this case the autonegotiation is launched and fec_enet_start_xmit() wai=
ts until it=20
completes. From then on, the hack never triggers again (comp_set is 0) =
and=20
disconnecting-reconnecting the cable or asking for a new DHCP address s=
eems to work=20
normally.

If I boot with the cable disconnected the driver seems to be trapped at=
 the=20
wait_for_completion() and connecting the cable later simply doesn't all=
ow the=20
autonegotiation to complete.

--=20
H=E9ctor Palacios

> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 885d8ba..9368dc2 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -231,6 +231,9 @@ static void *swap_buffer(void *bufaddr, int len)
>   	return bufaddr;
>   }
>
> +static DECLARE_COMPLETION(kick_ksoftirq);
> +static int comp_set;
> +
>   static netdev_tx_t
>   fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   {
> @@ -243,6 +246,9 @@ fec_enet_start_xmit(struct sk_buff *skb, struct n=
et_device *ndev)
>   	unsigned long flags;
>
>   	if (!fep->link) {
> +		if (comp_set)
> +			wait_for_completion(&kick_ksoftirq);
> +
>   		/* Link is down or autonegotiation is in progress. */
>   		return NETDEV_TX_BUSY;
>   	}
> @@ -794,6 +800,8 @@ static void fec_enet_adjust_link(struct net_devic=
e *ndev)
>   	/* Link on or off change */
>   	if (phy_dev->link !=3D fep->link) {
>   		fep->link =3D phy_dev->link;
> +		complete(&kick_ksoftirq);
> +		comp_set =3D 0;
>   		if (phy_dev->link)
>   			fec_restart(ndev, phy_dev->duplex);
>   		else
> @@ -914,6 +922,9 @@ static int fec_enet_mii_probe(struct net_device *=
ndev)
>   	fep->link =3D 0;
>   	fep->full_duplex =3D 0;
>
> +	init_completion(&kick_ksoftirq);
> +	comp_set =3D 1;
> +
>   	printk(KERN_INFO "%s: Freescale FEC PHY driver [%s] "
>   		"(mii_bus:phy_addr=3D%s, irq=3D%d)\n", ndev->name,
>   		fep->phy_dev->drv->name, dev_name(&fep->phy_dev->dev),
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
