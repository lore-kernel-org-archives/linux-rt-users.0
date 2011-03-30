From: Geunsik Lim <leemgs1@gmail.com>
Subject: Re: cyclictest: fix warning about printf format for u64
Date: Wed, 30 Mar 2011 23:51:41 +0900
Message-ID: <AANLkTin1Zv-M5SDv7NFfpHGm=yWj5JzEK=ktx=BuBwjf@mail.gmail.com>
References: <1301490764-15063-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45864 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab1C3Ovm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2011 10:51:42 -0400
Received: by ywj3 with SMTP id 3so540820ywj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Mar 2011 07:51:41 -0700 (PDT)
In-Reply-To: <1301490764-15063-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sounds good to me.
Reviewed-by: Geunsik Lim <geunsik.lim@samsung.com>

2011/3/30 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> This fixes
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0src/cyclictest/cyclictest.c: In function =E2=
=80=98print_hist=E2=80=99:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0src/cyclictest/cyclictest.c:1168: warning:=
 format =E2=80=98%09llu=E2=80=99 expects type =E2=80=98long long unsign=
ed int=E2=80=99, but argument 2 has type =E2=80=98uint64_t=E2=80=99
>
> on amd64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> =C2=A0src/cyclictest/cyclictest.c | =C2=A0 =C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1165,7 +1165,7 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("# Total:");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j < nthreads; j++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(" %09llu", =
log_entries[j]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(" %09llu", =
(unsigned long long)log_entries[j]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("# Max Latencys:");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j < nthreads; j++)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Regards,
Geunsik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 leemgs@gmail.com , leemgs1@gma=
il.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
Please read the FAQ at=C2=A0 http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
