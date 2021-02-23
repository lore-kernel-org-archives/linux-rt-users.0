Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F6C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 11:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C1E64E00
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 11:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhBWLBc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:01:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhBWLA6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 06:00:58 -0500
Date:   Tue, 23 Feb 2021 12:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614078017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2KcikPht0lTK/7/hX5Z/KSJhYeIMpQ+NLGbTyHnKuM=;
        b=N86VYho5O4E2daO9kebVIrku72MisGqczXYXKsJZ/qdfMiYY8wUIjatBOkjWvm8Beg890R
        FlnT/REoH2y9TRN/cWo2Hd8IlwU4gLACD97EtxRtcT1XAKMZbLtr4XaynO+PKGCYSy+FVG
        ENyRzVVPuwc5HGtqzn3xUamtSkZdsGRauMJzysAw6E7ikB/ErgZmy1BB3ryCkojBhz4BnS
        KzL3t26F64Wyh1x2qiRsytNzFcPC8CP4aDvXpdtKw7Yzv8aaEmHVqoVRlF7v54Y21uxiz+
        MqwcTodxd3+qr8cvRcIFJrq2Jm5bUJb6GakdxwmPQOhZ/HBG6tlq9l96+1r1Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614078017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2KcikPht0lTK/7/hX5Z/KSJhYeIMpQ+NLGbTyHnKuM=;
        b=PtYeqAO+xw6EZyOi/UT68AVocRwIFBIkU7FBrdNfs/OIDPuMIiE++z6e0gH8wnGIwB4Go1
        LxjEp5hn+IksjeAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RT v5.11-rt7] WARNING at include/linux/seqlock.h:271
 nft_counter_eval
Message-ID: <20210223110015.ybl7feu43wvtjoqu@linutronix.de>
References: <YDTdo+jETVr983t6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YDTdo+jETVr983t6@localhost.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-23 11:49:07 [+0100], Juri Lelli wrote:
> Hi,
Hi,

> I'm seeing the following splat right after boot (or during late boot
> phases) with v5.11-rt7 (LOCKDEP enabled).
=E2=80=A6
> [   85.273588] WARNING: CPU: 5 PID: 1416 at include/linux/seqlock.h:271 n=
ft_counter_eval+0x95/0x130 [nft_counter]
=E2=80=A6
> [   85.273713] RIP: 0010:nft_counter_eval+0x95/0x130 [nft_counter]

This is a per-CPU seqcount_t in net/netfilter/nft_counter.c which is
only protected by local_bh_disabled(). The warning expects preemption
to be disabled which is the case on !RT but not on RT.

Not sure what to do about this. It is doing anything wrong as of now. It
is noisy.

> Best,
> Juri

Sebastian
