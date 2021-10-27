Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D104C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F2460EB4
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 09:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhJ0JJS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:09:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbhJ0JJR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 05:09:17 -0400
Date:   Wed, 27 Oct 2021 11:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635325611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LNkiOWoBk2GDUOqc1vm4hrBW4RuL4nn0iAM7w24Xf0=;
        b=WFhgORQYb/yeteztdPQJGmST9srGSx8gPGZ/tB+l0DKCA2ImPYsLYQvCCWJu38YYgbLtlQ
        aLUzLrCCwRCjjAjseqatLv+xILCEq41FDRpsSphcUOe88mOClpCMF6JXuW69wx6m2P12TY
        XSHs4sgNrNb1me0umvGEtYau8N65VrkSgtn1vE99WgubX8ZK0AwRbQf81KKuRsOQnrGKOD
        wMeXWgD8QwHolSCIiRibmsGLPL+K+Mn/9iNkTxlkkc7koyCHWQ2IQ50H2dYBD2G+P2OHB7
        2C7dGu70gTdCYi+mQgkITYcOxrM/+6scKvsoG7faHtywIoQ9zYQtxTYyizz8sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635325611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4LNkiOWoBk2GDUOqc1vm4hrBW4RuL4nn0iAM7w24Xf0=;
        b=WCQhRqENIV6SstllcgfVkrRuC4djzFLEceYatdxz6674L8jHptHbpOIeVNboEBrDJ3X+lf
        hgggW9IW06cPXpDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in
 raw_seq_start()
Message-ID: <20211027090650.fqpqtze6wfetihej@linutronix.de>
References: <YVuwBEWw4F7NGUd2@uudg.org>
 <20211011163333.2o64amr4qks4gpdm@linutronix.de>
 <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-18 12:51:32 [-0300], Luis Goncalves wrote:
> Again, the use of tuned in the tests is mostly to reproduce the
> configuration in use at
> the moment. I can isolate the specific configuration that makes it
> possible to trigger the
> lockdep splat.

I can't reproduce any of those two issues. I tried both and iterated the
tuned profiles
	tuned-adm profile realtime
	tuned-adm profile throughput-performance

while running the test you mentioned.
Could you please try if this reproduces with latest v5.15-RT and post
complete lockdep backtrace?

Sebastian
