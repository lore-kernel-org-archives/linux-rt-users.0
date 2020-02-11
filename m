Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E106C352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7DB2051A
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 12:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgBKMEo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:04:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBKMEo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 07:04:44 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j1UHT-0006jW-8C; Tue, 11 Feb 2020 13:04:43 +0100
Date:   Tue, 11 Feb 2020 13:04:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
Message-ID: <20200211120443.tpb5feweflnjr72i@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com>
 <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-11 13:48:59 [+0200], John Mathew wrote:
> > Have you tested this patch and if so how?
> I ran the syzkaller for many days and was not able to reproduce the
> hang, also no new issues were found.
> Do you know any more tests for the crypto functionality?

crypto/tcrypt.c

Sebastian
