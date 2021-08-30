Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD857C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 19:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8268960F25
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Aug 2021 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhH3Twu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhH3Twt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Aug 2021 15:52:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881CC061575
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Aug 2021 12:51:55 -0700 (PDT)
Date:   Mon, 30 Aug 2021 21:51:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630353113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXAB732gwjxw9fh0jz0mOjVLpq7ivO9RixXuR6UnEYs=;
        b=LFNLyHQzuh6vabCJ9AfVdkovlowEVbr7bivCWK7KmGOg14h3hDKQl7nyn/uIP9r91UoPQ+
        NgejQRIAtWPS33oJHoRZvL+qmtWEaGbljOK/sOx6SmV7xc0wFE+nqu8JC5GULCUO0v/kQ/
        06/1mb3fJ4e2kevLMpmML5zJramcwp/Td5dWELEqSzlxpBSOluJrymhFCFdZFkmCVvX2AK
        yYZz2+P7WtD229fxZCuwwhaQjYCcuusv5PnVtYuUznpjKxpT3fURfscQDqb8A0NJuCZi5Q
        wJbzEenIkeym55/v2p4j+Ov8cSEiAxZe9Ls7ivVrB2zgdKcCcmEQrczp0eM/+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630353113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXAB732gwjxw9fh0jz0mOjVLpq7ivO9RixXuR6UnEYs=;
        b=wawusglHLWR3FaT0x7JFHDUkFUnBDpMUWmGxDxrczkOSVUbxldTaajd2mt7Sf3Pg4dU8Ee
        NDe8GYWjNksJepAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: Re: [rteval] Fails to work without numactl
Message-ID: <20210830195151.ym2svjnbekk7hvsg@linutronix.de>
References: <20210816115809.bb4jtb56zkagqmq6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210816115809.bb4jtb56zkagqmq6@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-16 13:58:09 [+0200], To linux-rt-users@vger.kernel.org wrote:
> rteval as of v3.2 (and the main branch) fails to work continue without
> numactl around:
=E2=80=A6
> | TypeError: 'NoneType' object is not subscriptable
>=20
> It continues to wait for kcompile=E2=80=A6
>=20
> With numactl around it uses a different path and continues. However it
> then finishes (the main binary) while the compile job and hackbench
> continues (not sure if this is intended).

ping.

Sebastian
