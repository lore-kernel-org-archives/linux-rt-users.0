Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C60C07E9D
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Sep 2022 11:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiI0LI4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiI0LIe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Sep 2022 07:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20065807
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Sep 2022 04:06:11 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:06:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664276770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XjE/ukMOMHNnSkLlWLj4n9kmtWw/gfwswYeCMszUok=;
        b=Uo/5zfnEcEsmmE98eVs557cLM4ljp6tX+690stsILVJi6rmMUPqjMsgktHvSfWnDDrTjrA
        F26+PXcnYGcpBUeW4ifoqOCVI33UZtrekPliu1+XyKSZsmlQQv7V/neWvuyXbpnbk2lv3j
        bSXghkBJHZErsFQXBGPAFwqHWt5EHox6BBckHtvh7CHcCNk5JTeZ0oJVSUu0PXkaIqzjHM
        zabJYLfLgvLGf7aiEqLJ2+5nmR4LQzepXdilFSUphZQagRTtzJelk1BKHoWu+uoBEj0W/J
        W/0LoGHhDiVmuB+k3lISmicVYqnrTpUFMvbAFbCT9MoEpkr2mqXrq8AihvguzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664276770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XjE/ukMOMHNnSkLlWLj4n9kmtWw/gfwswYeCMszUok=;
        b=I/FbiYkvVLS/yZFsotgOlGJ5hS7ipVIGxWYSf//azWDR/FqTE78+g2yoNVSjQrvhgpE0ck
        0rf5Qpr9jeFt2mAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Danilo Cezar Zanella <danilo.zanella@iag.usp.br>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Exception in function_graph tracing
Message-ID: <YzLZIX+Pi6lyIr1f@linutronix.de>
References: <CAAxUTH4zpibkhOS+NPzcYsXFqx1bJfSU19gdt0eCAOrpWAkinA@mail.gmail.com>
 <YyTXIUjq9tmFPTDi@linutronix.de>
 <CAAxUTH4xawCFpnwpRkcaZ5fdzMEbZZmPOyVDoqdMrPrf+G64dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAxUTH4xawCFpnwpRkcaZ5fdzMEbZZmPOyVDoqdMrPrf+G64dg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-09-16 17:28:00 [-0300], Danilo Cezar Zanella wrote:
> Hi Sebastian,
Hi Danilo,

please don't lose the list.

> > No, not as far I can tell.
> It sounds good. ;-)
>=20
> > It looks like the function_graph tracer is busted in v4.19 even without=
 the PREEMPT_RT patch.
> It sounds bad... :-(
>=20
> I'm new in LKM development and even more in Kernel tracing.
> I've tested 'nop' and 'function' tracing, both seem to work. Do you
> know when this issue was solved? Perhaps could I do a backport of
> it(if it is easy, of course)?

I managed to reproduce it on v4.19 but on v6.0-rcX. So it must have
been fixed somehow in between. I browsed the history but I did not
notice anything obvious.
So someone needs to dig deeper=E2=80=A6

> Thank you again
>=20
> Danilo

Sebastian
