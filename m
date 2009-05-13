From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: [PATCH] ARM: __builtin_return_address works with argument 0
Date: Wed, 13 May 2009 18:33:12 +0530
Message-ID: <921ca19c0905130603g3823b213vdb2b62b75934104d@mail.gmail.com>
References: <1242205213-27452-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:42565 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757790AbZEMNDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 May 2009 09:03:12 -0400
In-Reply-To: <1242205213-27452-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These seem to be required too. Mostly for optimizations the compiler ca=
n
provide. Seem to be supported in gnu.

__builtin_clz
__builtin_constant_p
__builtin_expect
__builtin_frame_address

http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0376a/=
Caceiddh.html



2009/5/13 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> This saves the function overhead for CALLER_ADDRESS0.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> Hi Thomas,
>
> this applies to .29.3-rt12. =A0Feel free to squash this into
> arm-tracing-updates.patch.
>
> Best regards
> Uwe
>
> =A0arch/arm/include/asm/ftrace.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftr=
ace.h
> index 900fc19..f7e8bac 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -15,7 +15,7 @@ extern void mcount(void);
> =A0void *return_address(unsigned int);
>
> =A0#define HAVE_ARCH_CALLER_ADDR
> -#define CALLER_ADDR0 ((unsigned long)return_address(0))
> +#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> =A0#define CALLER_ADDR1 ((unsigned long)return_address(1))
> =A0#define CALLER_ADDR2 ((unsigned long)return_address(2))
> =A0#define CALLER_ADDR3 ((unsigned long)return_address(3))
> --
> 1.6.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
