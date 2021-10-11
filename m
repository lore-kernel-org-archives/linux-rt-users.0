Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A250AC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826A660F6E
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 16:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhJKQfg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:35:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhJKQfg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 12:35:36 -0400
Date:   Mon, 11 Oct 2021 18:33:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633970014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSohxNjpjCh/ohfSbrQOZrGh24l5ahnQu3wyfREWVrc=;
        b=NWMW2c0un1+nCh823dFsfBZyBv2bsjXwKCOzVnxtYP85d/f0RPOJdtN1i8TmCleLyfg0YK
        t0R2VXYv7Vow7xFZIm361rCu4kTL7UVIRzyevxLYqdX9d9tEd0vr0gERTt+mqD+Cw2npGs
        aG0lg0DP1sa58fs5cFzKOgG//TlLmxGyISaA3jJG7qH0XY+1fDs9t1EZhPim6uaG9JNSbl
        e29N9xtyg3A6zuGbFHzvZWf6WFjeR20joiYqEwwLqStnqtTbpfUa4tQSxVJ+WXF/RwK7X1
        Tql1wCAbqBjfB7ggZo90mBHzt3v1plwedYH54VvxQmC+bEp55qEaW9f9cKNSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633970014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSohxNjpjCh/ohfSbrQOZrGh24l5ahnQu3wyfREWVrc=;
        b=yb1Do1s7xK2WV5H4Hh8XdsFp7hY+sDtJCNuSI+n7Ocw9imo79QLyJaqTuz+h1juELlaJSY
        t3faWc5EnXSN2cBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in
 raw_seq_start()
Message-ID: <20211011163333.2o64amr4qks4gpdm@linutronix.de>
References: <YVuwBEWw4F7NGUd2@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVuwBEWw4F7NGUd2@uudg.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-04 22:53:08 [-0300], Luis Claudio R. Goncalves wrote:
> Avoid a possible circular locking dependency by taking the softirq_ctrl.lock
> before taking raw_v6_hashinfo.lock in raw_seq_start(), keeping locking order
> consistent.

How do you reproduce this one? It does not trigger here. Maybe I'm doing
something wrong. The command
	hping3 -C 3 -K 1 -c 1 $ip

triggers raw_icmp_error() from within the softirq processing. And
	cat /proc/net/raw

does raw_seq_start(). No BH here. Additionally during boot raw_hash_sk()
is invoked from non-BH context here but it is a write-lock so it has to
disable BH since there is at least one reader in BH.

The ipv4 code looks close to the ipv6. The problem is that hping does
not support v6 :/ Maybe the ipv6 acquires a bh lock somewhere which
leads to this.

Sebastian
