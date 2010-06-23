From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: Re: beagleboard RT problem
Date: Wed, 23 Jun 2010 11:45:36 +0200
Message-ID: <AANLkTileTAXkfHwhSruyWhZqpPkEr4KnEGyf1fUQqaPw@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	<1276514850.26993.4.camel@sven.thebigcorporation.com>
	<AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
	<AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
	<AANLkTilakntJf43kOkuT0EVu6v3s17VNJR6S60lB2ls3@mail.gmail.com>
	<AANLkTinojaU-FL3K3C09hV9-qrr8ZdjA8fzDMWTeQh_k@mail.gmail.com>
	<1277218015.10664.5.camel@sven.thebigcorporation.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED2FC9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Chatterjee, Amit" <amit.chatterjee@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42002 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0FWJpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jun 2010 05:45:38 -0400
Received: by fxm10 with SMTP id 10so2934806fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jun 2010 02:45:36 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030DED2FC9@dbde02.ent.ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Amit,

thanks for the tip. I'll try the setting and will get back with the
results of my testing.

Cheers,
Maksym.

On 23 June 2010 10:51, Chatterjee, Amit <amit.chatterjee@ti.com> wrote:
> Please use the following config settings for RT tests. The following =
option enables the timer to work in high resolution mode.
>
> CONFIG_OMAP_MPU_TIMER=3Dy
> # CONFIG_OMAP_32K_TIMER is not set
>
> Also increase the default timer resolution from 10 msec to 1 msec
> --- arch/arm/Kconfig.orig =C2=A0 =C2=A0 =C2=A0 2010-06-23 14:28:30.00=
0000000 +0530
> +++ arch/arm/Kconfig =C2=A0 =C2=A02010-03-12 14:58:31.000000000 +0530
> @@ -1078,7 +1078,7 @@ config HZ
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default 200 if ARCH_EBSA110 || ARCH_S3C241=
0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default OMAP_32K_TIMER_HZ if ARCH_OMAP && =
OMAP_32K_TIMER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default AT91_TIMER_HZ if ARCH_AT91
> - =C2=A0 =C2=A0 =C2=A0 default 100
> + =C2=A0 =C2=A0 =C2=A0 default 1000
>
> =C2=A0config THUMB2_KERNEL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Compile the kernel in Thumb-2 mode"
>
> Regards,
> Amit
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
