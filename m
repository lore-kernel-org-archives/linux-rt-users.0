From: Tim Sander <tim@krieglstein.org>
Subject: Re: 3.4.28-rt40 arm freescale imx35 pcm43
Date: Wed, 06 Feb 2013 17:43:40 +0100
Message-ID: <5977343.5KpmQXLB4x@dabox>
References: <6003615.pRQnIgKCSn@dabox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lvps176-28-13-145.dedicated.hosteurope.de ([176.28.13.145]:45396
	"EHLO lvps176-28-13-145.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756396Ab3BFQnn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 11:43:43 -0500
Received: from dabox.localnet (unknown [62.159.134.146])
	by lvps176-28-13-145.dedicated.hosteurope.de (Postfix) with ESMTPSA id 66FBBA8A407B
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Feb 2013 17:43:41 +0100 (CET)
In-Reply-To: <6003615.pRQnIgKCSn@dabox>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I just noticed that the thread irq/45-IMX-uart is the current thread. 
Nevertheless the interrupt for this thread is enabled which seems wrong to me?
So the interrupt handler imx_rxint does not get call as it is always 
interrupted by the level triggered interrupt of the same hw source?

Thanks
Tim
