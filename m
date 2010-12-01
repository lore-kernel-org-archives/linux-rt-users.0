From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: Networking latency issue on 2.6.33.7-rt29 kernel
Date: Wed, 01 Dec 2010 09:27:24 +0100
Message-ID: <id50tc$lju$1@dough.gmane.org>
References: <AANLkTi=7_zBakGaCys6FpLO8BbZKKX0sYb7Y6RBU8_bB@mail.gmail.com>	<0016e65a0784be92790495bd73d5@google.com>	<AANLkTimzu3fM4_PaxSqrmUuYoZheDNjf5yVPmhJh=Yzz@mail.gmail.com> <AANLkTin6nJxLa_U61yj=a=BQapHxMoc6FFtLfwP_yma_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51492 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab0LAI1p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Dec 2010 03:27:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1PNi2M-0001an-Ry
	for linux-rt-users@vger.kernel.org; Wed, 01 Dec 2010 09:27:38 +0100
Received: from ih5.theoinf.tu-ilmenau.de ([141.24.203.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Dec 2010 09:27:38 +0100
Received: from andre.puschmann by ih5.theoinf.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Dec 2010 09:27:38 +0100
In-Reply-To: <AANLkTin6nJxLa_U61yj=a=BQapHxMoc6FFtLfwP_yma_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 11/24/2010 02:35 PM, Jean-Michel Hautbois wrote:

> For those who may be interested, CONFIG_TINY_RCU changes the behaviour
> (it was CONFIG_TREE_PREEMPT_RCU) :
> http://picasaweb.google.com/lh/photo/DmKJyIv04fvnN_y0wR0_9ZMU3g7ObZTPqzWaaCIpUqI?feat=directlink

In init/Kconfig, CONFIG_TINY_RCU is configured to depend on "!SMP && 
!PREEMPT_RT".

Did you just remove the !PREEMPT_RT dependency then?

If so, I am afraid this may cause side effects.


Regards,
Andre

