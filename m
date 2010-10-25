From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: RT scheduling / scheduling of RT groups
Date: Mon, 25 Oct 2010 14:37:15 -0500
Message-ID: <AANLkTinzy8Vz8YmpoCJ+e+XhTbysqGhCS7XSRNccipuC@mail.gmail.com>
References: <AANLkTim5r_GoCDp0oKmEjWbf+64UL1r35_3GmCow1ETD@mail.gmail.com>
	<4CC2E09B.7020704@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41885 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0JYThS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Oct 2010 15:37:18 -0400
Received: by fxm16 with SMTP id 16so3279104fxm.19
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Oct 2010 12:37:17 -0700 (PDT)
In-Reply-To: <4CC2E09B.7020704@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Oct 23, 2010 at 8:18 AM, Armin Steinhoff <armin@steinhoff.de> w=
rote:
> Hi all,
>
> AFAIK, =C2=A0the RT scheduler (sched_rt.c) is part of the CFS.
> =C2=A0Is there a way to handle task running with SCHED_NORMAL and SCH=
ED_OTHER
> also with the RT scheduler ?
> ( CFS deactivated )
>
> There are scheduling groups. In which way (priorities? other attribut=
es?)
> =C2=A0are these groups defined ?
> =C2=A0How can sched_rt_period and sched_rt_runtime be set or read?
>
> Cheers
>
> --Armin
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

somehow I thought sched_fair.c(CFS) and sched_rt.c(RT scheduler) are
separated, in that RT is always taking precedances over CFS and CFS is
only for non-RT process/threads, am I missing something?

xianghua
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
