Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D26C55178
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB2E20936
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABh9/5/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6sGdLA6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374146AbgJWHXn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368405AbgJWHXn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 03:23:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3605CC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 00:23:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603437821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tf5c0R/jL+DCKGv4s4dNfadHjgCPr1nrMIbHKu29JL8=;
        b=ABh9/5/+GAUbyplebUP5OHZGDVEMWx/GxlQD7sh01L4w32an0C0K5jJxwvvDDJXrcIygxs
        tluwVg8nHaxwnBo4HpyivNiDuHdK4FJKA7Y0KhuRC0fRUOBCtiXrCWMub6kt57jTe4ltSa
        MXhlZiWP6fJ3K67OSswwA68SxcM9PJA6VBwAbKbmP2j7lF19k4oTLyVvSelxuhcSEPxYIH
        O9qb9MG9awSlKG2kIKexr061TTzaI8r9C808CK9MQvZFBjlDV9hYKrBnBuI/5cw8l7MM6C
        SqWjmH5hOUL+JL2q/XkxisZ982AMuxo+J3s3s/59h+5Z4FpXt8cNtRal3XYo4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603437821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tf5c0R/jL+DCKGv4s4dNfadHjgCPr1nrMIbHKu29JL8=;
        b=6sGdLA6eiuGOLRJIWi61oJ3lJi9hUhocq9ZOMQyBehgndLQWrk5SzBY4VNwe12zzRicBHo
        XwnbhYCLK0/N1ZBw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: printk: add pr_flush()
In-Reply-To: <20201022145214.a5sm66naswycezae@linutronix.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de> <20201022141529.zvwafoqglnhyklj5@linutronix.de> <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de> <c2965ef22b5e95db0d9e214efb6f653628549579.camel@gmx.de> <20201022145214.a5sm66naswycezae@linutronix.de>
Date:   Fri, 23 Oct 2020 09:29:41 +0206
Message-ID: <877drhmmma.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

The "printk: add pr_flush()" patch should be removed from PREEMPT_RT
until this issue is resolved. I am getting several independent bug
reports of reboot problems.

Note that on crash situations the full ringbuffer should still be
printed. pr_flush() was only responsible for non-crash scenarios.

John Ogness
