Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3651C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Feb 2021 08:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820F764E2E
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Feb 2021 08:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBAIf0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Feb 2021 03:35:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBAIfZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Feb 2021 03:35:25 -0500
Date:   Mon, 1 Feb 2021 09:34:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612168483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=aaJFegpsFq5Ifsc5Ox2rbD2EGiC1q66G9Lz8akhD8ns=;
        b=Ss6QxNgvhf29a5NlX4+6KGlZaJL/pl4egdJLNxHBYAt0O5LsgyKI+q/jbJSt+sjzrHDmho
        AKkOTNCI5wwliQ8ZS1PoknX9ZcsI5/14bc20gTD/e07TtEpXHa2H7NRGj5CV0q9X7cy8w7
        iYEn4mp4CIrW6th5QZIqlslGKStx7rRW4sJtoDIPs2TIhKRoJj5txclaVN/M76Lt/TeMxK
        tBtW3uS2gk9j9IR8PvKAdPMJJUL5LOK39q7RmtkMcBQV5haPtG2HEG1JJGbizyX/1wkuXs
        sk65JWLcWVwizVH0AYMysomaKo49zKW9JFm820l1SA5Kkqhfame9KxXw33sFYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612168483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=aaJFegpsFq5Ifsc5Ox2rbD2EGiC1q66G9Lz8akhD8ns=;
        b=Tdn+lzXx3YWyLhCP+aPjQJW+VWX+YS+wdVEllOEX7/Ju7ZSvrLrHNzi0YYOVxMmvmZFSJz
        Uaf+1h1pGKqffNBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210201083441.ocucdvdrv37goz2s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YBVG/PG7syFIUBno@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

+ firewire maintainer

On 2021-01-30 12:46:04 [+0100], David Runge wrote:
> On 2021-01-29 18:04:14 (+0100), Sebastian Andrzej Siewior wrote:
> > I don't see anything wrong. There is small difference in timing and
> > then the RT version does not do a thing while !RT keeps reseting=E2=80=
=A6
> > Could you try non-RT with the
> > 	threadirqs
> >=20
> > option?
>=20
> Yes, (sorry for not including that earlier D:) that fails the same way
> as the realtime kernel:
> https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel_threadirqs.l=
og

Could be specific to the chip or the ohci driver. Either way, the problem
are the threaded interrupts.

> Best,
>=20
> David

Sebastian
