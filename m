Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DEC63697
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Nov 2020 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F6A22252
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Nov 2020 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H84n4lQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKNTBH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:01:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:38835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgKNTBC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Nov 2020 14:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605380409;
        bh=2RQlCQR2il0fky0NYexcCy3VsVsYFq66RqBkkxwoBB4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=H84n4lQWJit+a1jIcuAQ99oMyz0uQJL06JHxqOkCOwRYQF//t9oq0O9Mx7fx6o5xA
         TranbE3N0PxKi4BF7HkASaTEtv/+5GbbHX+w2icv4wcuY7KbgWDARNJAKxi0Ppvovi
         g7cDxU0kpumd1ubigjV9G+nI188W/Q49psPllo1s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.172]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1kZu2a0alV-004nDe; Sat, 14
 Nov 2020 20:00:09 +0100
Message-ID: <6209c8773bb1d361266046323f266526a810f850.camel@gmx.de>
Subject: Re: [PATCH RT 1/5] net: Properly annotate the try-lock for the
 seqlock
From:   Mike Galbraith <efault@gmx.de>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org
Date:   Sat, 14 Nov 2020 20:00:07 +0100
In-Reply-To: <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
References: <20201110153853.463368981@goodmis.org>
         <20201110154024.958923729@goodmis.org>
         <617eb5e8478df466afa9013b02a2425f7c4c673f.camel@kernel.org>
         <aa57c01bceaaac362d4da6e25427827fabe4d37a.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f5GcBVyyvGR/HmTbOnFU0B48RjgrfxWb/6886SreAZzs+WrdKrL
 CkFxyDl8sHPSml5u6LdGxoiRfCYXkN9IWv8+2eLjYP0lQltBgLhJ3394FmlDVIvYuRpARyy
 orkwTvBAizv7wJMm59b3BFjbXTrASQ1/+RTkjRfDcqIr+OB7QDc/U9Hutv+/dzDKSEkcz+d
 pRhz4qkWLGwrFoZncjebQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F9nJw+moVa0=:vFIthc+dw2264pR9le+8nf
 iSuj8oNgI63uvN/Au93+fUtVfRex/5/AYfh93fF9wfdYIPeYAqfzrw4dC8HVuzfeKVcFmF8df
 RufjHCr8YzBgYT4S0LGDdIO6kUbU4Fp6fVxhh7TaOf7xLoPwrpRfWGqW7IsPd96AYRQj99Yps
 OTj4UWvQSLFdhDO+RMs6sZVDr+r0f5JF4BS0R2i1cZ/3bULmI7urcWJQ4v9r9qNDax14LGYQR
 6cffzgrl/Zno8NEzem8nf/csvfkn7f5XtF0InbIf+eYHUCHqfBZBU8jwQQtlggoxn/nA66hVh
 JeD7DetXdq13N3hNDU70XiorZmXtb64JDGktPRnRo6qQpLAP6FShYND7WAkATBdwjVxEouQDF
 FJupSJpBAWzEIsAkA5P0NVspl/JEYtqcRP46pcpH8RFIDAMOwrUZllHOsvTkRV3W3UPLU3rFi
 jQrGGzTGEssfz2P2iG7/vqVsH33kXzj8eu99hQWq2BqdmDrg4PjabF2QQF9nbB0ZkiD5fShhY
 dQBQEiarttXWtvdFWXLujVGbHM+7vAaraPT237AuuGqrJS7Z15AFn7/PAQrFMzQe0SzoMn6e8
 +AELcbnufG9qFJ4Q3Dypj4/SyGdArbnwEOYfhwxIAuDWB7wjZTxA3A74g08WqG1fEHjuu1SUN
 i9bvw1CF0j+YhXu/eH+A722YLJDVKq2lOuuBNfc0dJdgYD6Zak+bgKiGtoYX9sYu/uTlJkqPK
 /ax6i7xXwHjZrVIXIsqMC5oQdiWlgb7OIOaVLzY/4A0SJHHzQfXdeYUdmhzKqTYnRHNnM7dc4
 U6o3TVwo+i0z/1rpoC36bmBsdXJnbU44OGOd4SQNgD7er8Y6nIReTQJ/pMG207DbvhOJ19jAE
 27oxgmCmKsc9oZnYNKFQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2020-11-13 at 14:14 -0600, Tom Zanussi wrote:
>
> This patch seems to fix it for me:

If there was any discussion about this patch, I missed it.

> From 4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e Mon Sep 17 00:00:00 2001
> Message-Id: <4855377d0cb34b1b67a5c6d84cc8609c9da0bc3e.1605297603.git.zan=
ussi@kernel.org>
> From: Tom Zanussi <zanussi@kernel.org>
> Date: Fri, 13 Nov 2020 13:04:15 -0600
> Subject: [PATCH] net: Add missing __raw_write_seqcount_end() and
>  seqcount_release()
>
> The patch ('net: Properly annotate the try-lock for the seqlock") adds
> __raw_write_seqcount_begin() in qdisc_run_begin() but omits the
> corresponding __raw_write_seqcount_end() and seqcount_release() in
> qdisc_run_end().
>
> Add it unconditionally, since qdisc_run_end() is never called unless
> qdisc_run_begin() succeeds, and if it succeeds,
> __raw_write_seqcount_begin() seqcount_acquire() will have been called.
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  include/net/sch_generic.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 112d2dca8b08..c5ccce4f8f62 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -192,7 +192,11 @@ static inline bool qdisc_run_begin(struct Qdisc *qd=
isc)
>  static inline void qdisc_run_end(struct Qdisc *qdisc)
>  {
>  #ifdef CONFIG_PREEMPT_RT
> +	seqcount_t *s =3D &qdisc->running.seqcount;
> +
>  	write_sequnlock(&qdisc->running);
> +	__raw_write_seqcount_end(s);
> +	seqcount_release(&s->dep_map, 1, _RET_IP_);
>  #else
>  	write_seqcount_end(&qdisc->running);
>  #endif

__raw_write_seqcount_end() is an integral part of write_sequnlock(),
but we do seem to be missing a seqcount_release() in 5.4-rt.

	-Mike

