From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: sc16is7xx: a lot of time is spend in sc16is7xx_port_irq
Date: Wed, 24 Feb 2016 18:39:46 +0100
Message-ID: <56CDEAE2.9050102@prevas.dk>
References: <56CDCCE6.5020801@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>
To: <linux-serial@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:34659 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208AbcBXRju (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 12:39:50 -0500
In-Reply-To: <56CDCCE6.5020801@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

CC'ing RT

On 2016-02-24 16:31, Sean Nyekj=C3=A6r wrote:
> Hi
>
> I'm using the sc16is750 on an imx6d platform with RT patches applied.
>
> I have observed that sometimes the driver locks the whole system as i=
s=20
> loops inside the sc16is7xx_port_irq.
> I have applied some debug and seen we are looping upto 130000 times i=
n=20
> the while(1) loop.
> The SC16IS7XX_IIR_REG does signal the SC16IS7XX_IIR_XOFFI_SRC but the=
=20
> SC16IS7XX_IER_XOFFI_BIT is not set.
>
> Please ask for more debug info if needed :-)
>
> Br
> Sean

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
