From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [RESEND] [PATCH V2 ]cyclictest: fix invalid comment of debugfs
	mount directory.
Date: Mon, 8 Jun 2009 14:37:28 +0900
Message-ID: <49b7c2350906072237g163fc86bhc497183452de9a17@mail.gmail.com>
References: <1243821987.20635.42.camel@centos51>
	 <1243919642.20635.53.camel@centos51>
	 <1244425929.20635.90.camel@centos51>
	 <20090608045353.GA11319@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	lclaudio@uudg.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:33543 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZFHFh0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jun 2009 01:37:26 -0400
Received: by gxk10 with SMTP id 10so1421363gxk.13
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Jun 2009 22:37:28 -0700 (PDT)
In-Reply-To: <20090608045353.GA11319@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/6/8 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <geunsi=
k.lim@samsung.com>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Reviewed-by =C2=A0: Luis Claudio R=
=2E Goncalves <lclaudio@uudg.org>
> hhm, I don't know how Clark handles these flags, but I wouldn't count
> the comments by Luis Claudio R. Goncalves as review. =C2=A0Still more=
 as you
> didn't follow his advice and I would only add this tag after the
> reviewer is OK with the result.
> <nitpick>
> In the kernel the colons and names usually are not aligned.
> </nitpick>
Thank you for your advice and opinion about my trivital patch.
Sorry.  Maybe, I mistooked  about  how to append  "Reviewed-by tag".

>> + * mountpoint of debugfs filesystem.
>> + * - debugfs related reference: http://lwn.net/Articles/334546/
> set_debugfileprefix doesn't depend on a "default mountpoint", it pars=
es
> /proc/mounts, so it should even work if you mount it somewhere below =
/home.
> And I'm not convinced that adding a link to lwn is a good idea. =C2=A0=
I would
> expect that the normal cyclictest hacker knows about debugfs.
Yes, It's correct.  But, I think that a detailed remark is not bad.

>
> So what about simply
>
> + * Finds the tracing directory in a mounted debugfs.
>
> ? =C2=A0Ah, just see that is similar to the suggestion by Luis Claudi=
o R.
> Goncalves.
Your comment is also correct.
Anyway, I want Clark to edit "debugfs/tracing" comment  with a suitable
expression normally.

--=20
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
