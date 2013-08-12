From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.10.4-rt1 : too many arguments to function 'phy_connect'
Date: Mon, 12 Aug 2013 13:12:36 +0200
Message-ID: <20130812111236.GD23040@linutronix.de>
References: <52088F6B.8080707@onera.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Paul Chavent <Paul.Chavent@onera.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43788 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab3HLLNa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 07:13:30 -0400
Content-Disposition: inline
In-Reply-To: <52088F6B.8080707@onera.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Chavent | 2013-08-12 09:31:55 [+0200]:

>Hi.
Hi Paul,

>When i compile this version (3.10.4-rt1) for typical da850 (arm omap)
>config i get this error :
>
>  CC      drivers/net/ethernet/ti/davinci_emac.o
>drivers/net/ethernet/ti/davinci_emac.c: In function 'emac_dev_open':
>drivers/net/ethernet/ti/davinci_emac.c:1604:9: error: too many
>arguments to function 'phy_connect'
>         PHY_INTERFACE_MODE_MII);
>         ^
>In file included from drivers/net/ethernet/ti/davinci_emac.c:56:0:
>include/linux/phy.h:522:21: note: declared here
> struct phy_device * phy_connect(struct net_device *dev, const char
>*bus_id,
>                     ^
>
>There are some suspect lines in the patch that add an extra argument
>to the phy_connect function without modifying its signature.
>
>The compilation complete if i remove this extra arg (but the kernel
>don't start, i will check my config for this point).

The series files has a bunch of cpsw patches. For the next -rt release
I'm going to remove all of them as they were only required for the v3.8
release were I backported the cpsw driver. If you drop them, cpsw will
compile. After quick testing I've seen that the cpsw wasn't running nice
but did not crash / hang the system. That is something that should be
investigated.

>Regards.
>
>Paul.

Sebastian
