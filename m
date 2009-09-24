From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [PATCH] get rid of [softirq-NULL]
Date: Thu, 24 Sep 2009 22:46:36 +0200
Message-ID: <3efb10970909241346r36d284ebufbe17e24fb133bd6@mail.gmail.com>
References: <1253825033-30094-1-git-send-email-linux@bohmer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remy Bohmer <linux@bohmer.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f183.google.com ([209.85.210.183]:52846 "EHLO
	mail-yx0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbZIXUqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Sep 2009 16:46:33 -0400
In-Reply-To: <1253825033-30094-1-git-send-email-linux@bohmer.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/9/24 Remy Bohmer <linux@bohmer.net>:
> if CONFIG_HIGH_RES_TIMERS is not configured, still the hrtimer-softir=
q
> is started, so to prevent the name 'softirq-NULL' in 'ps' output we
> should still define its name here.
> Preventing the softirq from starting at all would touch much more cod=
e, so
> I chose the easy way here, it is a cosmetic fix anyway.
>
> Signed-off-by: Remy Bohmer <linux@bohmer.net>

oops... Forgot to mention that this patch applies to 2.6.31-rt11 (preem=
pt-RT)

> ---
> =A0kernel/softirq.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index aae8d45..590049c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -1139,9 +1139,7 @@ static const char *softirq_names [] =3D
> =A0 [NET_RX_SOFTIRQ] =A0 =A0 =3D "net-rx",
> =A0 [BLOCK_SOFTIRQ] =A0 =A0 =A0=3D "block",
> =A0 [TASKLET_SOFTIRQ] =A0 =A0=3D "tasklet",
> -#ifdef CONFIG_HIGH_RES_TIMERS
> =A0 [HRTIMER_SOFTIRQ] =A0 =A0=3D "hrtimer",
> -#endif
> =A0 [RCU_SOFTIRQ] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D "rcu",
> =A0};
>
> --
> 1.6.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
