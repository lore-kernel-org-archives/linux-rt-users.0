Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A5BC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 17:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584722074F
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T4NZ2pKh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="55XGgogR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgKCRBn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgKCRBn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 12:01:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2435C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue,  3 Nov 2020 09:01:43 -0800 (PST)
Date:   Tue, 3 Nov 2020 18:01:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604422902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePJ8OysAq1ytcO0K6uJS+nC3huuCCUp0jrSWt39vphA=;
        b=T4NZ2pKhOHG4ChHD/VtN8m1ch9y+/jC98NT/U6Y2J2KNCKFlstNazm9CCSRSODSjk8O0sz
        AhWElxrMlbdJaztYGQXOvNvrOnXx/Ju8s/JkBSan0FEMQYe4Kus4lBCKOu4WKNgrS2biCQ
        KvPI7Py0UhX7YluiQoTSlrro9b60ptCZJrU6ZVlyrSQPEZm35V6jGNyLwJ5QzZwlGNv2/s
        qbiEAODK1JHmnkL31pKDKE/kspdUze1hR3ELUMtz8+vHc+R811yCvSy/xvMrk3Gmm0lBbX
        REZw+k7NduVOphZtMeRGxQEmMTV/MKeiaQ2CPXzycVv5I7qrfezcNIj1sbIOPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604422902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePJ8OysAq1ytcO0K6uJS+nC3huuCCUp0jrSWt39vphA=;
        b=55XGgogRwR1rKumbfTV5wXizQwmnQWv13PrpekjtAUg72Tk5iyQZAiv6kKy03j3GAn+Oxe
        +peVB0JKzgEXrYAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201103170140.hnrxoq4cumjlbhj5@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
 <20201103113901.GA29800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103113901.GA29800@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-03 12:39:01 [+0100], Oleg Nesterov wrote:
> The commit 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
> changed ptrace_freeze_traced() to take task->saved_state into account,
> but ptrace_unfreeze_traced() has the same problem and needs a similar
> fix: it should check/update both ->state and ->saved_state.
> 
> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Fixes: 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Applied, thank you.

Sebastian
