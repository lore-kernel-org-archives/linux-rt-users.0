From: Paul Chavent <Paul.Chavent@onera.fr>
Subject: 3.10.4-rt1 : too many arguments to function 'phy_connect'
Date: Mon, 12 Aug 2013 09:31:55 +0200
Message-ID: <52088F6B.8080707@onera.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Chavent <Paul.Chavent@onera.fr>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from briaree.onecert.fr ([134.212.190.4]:53120 "EHLO
	briaree.onecert.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3HLHx0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 03:53:26 -0400
Received: from neree.onecert.fr (thetis.onecert.fr [134.212.178.12])
	by briaree.onecert.fr (8.14.3/8.14.3/ONERA-SRI) with ESMTP id r7C7bU3a000807
	for <linux-rt-users@vger.kernel.org>; Mon, 12 Aug 2013 09:37:30 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi.

When i compile this version (3.10.4-rt1) for typical da850 (arm omap) 
config i get this error :

   CC      drivers/net/ethernet/ti/davinci_emac.o
drivers/net/ethernet/ti/davinci_emac.c: In function 'emac_dev_open':
drivers/net/ethernet/ti/davinci_emac.c:1604:9: error: too many arguments 
to function 'phy_connect'
          PHY_INTERFACE_MODE_MII);
          ^
In file included from drivers/net/ethernet/ti/davinci_emac.c:56:0:
include/linux/phy.h:522:21: note: declared here
  struct phy_device * phy_connect(struct net_device *dev, const char 
*bus_id,
                      ^

There are some suspect lines in the patch that add an extra argument to 
the phy_connect function without modifying its signature.

The compilation complete if i remove this extra arg (but the kernel 
don't start, i will check my config for this point).

Regards.

Paul.

PS : please CC me, i haven't subscribed to this list.
