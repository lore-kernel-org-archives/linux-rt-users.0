From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: 3.10.4-rt1 : too many arguments to function 'phy_connect'
Date: Wed, 28 Aug 2013 11:28:30 -0400
Message-ID: <521E171E.6030604@windriver.com>
References: <52088F6B.8080707@onera.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>
To: Paul Chavent <Paul.Chavent@onera.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:35171 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3H1P2e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Aug 2013 11:28:34 -0400
In-Reply-To: <52088F6B.8080707@onera.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-08-12 03:31 AM, Paul Chavent wrote:
> Hi.
> 
> When i compile this version (3.10.4-rt1) for typical da850 (arm omap) 
> config i get this error :
> 
>    CC      drivers/net/ethernet/ti/davinci_emac.o
> drivers/net/ethernet/ti/davinci_emac.c: In function 'emac_dev_open':
> drivers/net/ethernet/ti/davinci_emac.c:1604:9: error: too many arguments 
> to function 'phy_connect'
>           PHY_INTERFACE_MODE_MII);
>           ^
> In file included from drivers/net/ethernet/ti/davinci_emac.c:56:0:
> include/linux/phy.h:522:21: note: declared here
>   struct phy_device * phy_connect(struct net_device *dev, const char 
> *bus_id,
>                       ^
> 
> There are some suspect lines in the patch that add an extra argument to 
> the phy_connect function without modifying its signature.
> 
> The compilation complete if i remove this extra arg (but the kernel 
> don't start, i will check my config for this point).

I just ran into a similar problem when moving the Yocto MIPS reference
board from 3.8 --> 3.10.  It is caused by this commit added in 3.9:

   ------------------------------
   commit f9a8f83b04e0c362a2fc660dbad980d24af209fc
   Author: Florian Fainelli <florian@openwrt.org>
   Date:   Mon Jan 14 00:52:52 2013 +0000

       net: phy: remove flags argument from phy_{attach, connect, connect_direct}

       The flags argument of the phy_{attach,connect,connect_direct} functions
       is then used to assign a struct phy_device dev_flags with its value.
       All callers but the tg3 driver pass the flag 0, .....
   ------------------------------

I wonder if you removed the right argument, since that is all I did
for the Yocto board, and it was happy...

Paul.
--

--- a/drivers/net/ethernet/atheros/ag71xx/ag71xx_phy.c
+++ b/drivers/net/ethernet/atheros/ag71xx/ag71xx_phy.c
@@ -131,7 +131,7 @@ static int ag71xx_phy_connect_multi(struct ag71xx *ag)
        }
 
        ag->phy_dev = phy_connect(dev, dev_name(&phydev->dev),
-                                 &ag71xx_phy_link_adjust, 0,
+                                 &ag71xx_phy_link_adjust,
                                  pdata->phy_if_mode);
 
        if (IS_ERR(ag->phy_dev)) {
