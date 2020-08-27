Return-Path: <SRS0=N+eC=CF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B4C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200BD2177B
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Aug 2020 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bJ5Xiojd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nq8vw3Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgH0MyL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:54:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgH0MxV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Aug 2020 08:53:21 -0400
Date:   Thu, 27 Aug 2020 14:52:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598532777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpZ8o27xQN0ZCzFbn5h0xI7sUQbNusAOPscGXu3QKis=;
        b=bJ5XiojdgpRQ6IX1g9j3DPARTmN9SK8F1Z4c1/hFvZzKNGtAX4lVWI3hn1sS+vuN6AntGo
        e/9HUuHuEAByOPbwMN9Z5emZ0AlqlVO6mpKCJ0b/G4ySLawnfi6LwXoK/uX18rTFIrcIKD
        odQjbVDnigtT0GYqQfpU4v5gALptA5pxpXUH9xyETtEc3moGF1cXl5ME2P8Gujfqns/Puy
        4BxNdBT0OFfrtmfbFULGeZw/1196UDGnPXCBreAy4v1wW3Viq7S3UUka2vtRfhAaHUED/k
        UR53hWevR0rsQJebycreuHuDEC/okqOnNQF/l8KJmTV7t8eIP3equi12fapNTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598532777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BpZ8o27xQN0ZCzFbn5h0xI7sUQbNusAOPscGXu3QKis=;
        b=nq8vw3KafPNPxis/JzRgJJYQU3qoBA5atfbsqLoYNP3rZBuh4blmRo3nIy69/mwPibACvG
        f1qq9dUpddMJ0OAw==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Roosen Henri <Henri.Roosen@ginzinger.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "williams@redhat.com" <williams@redhat.com>
Subject: Re: RT kernel v4.14 NULL pointer dereferences
Message-ID: <20200827125256.etg57uakct2gobl3@linutronix.de>
References: <fd9d435b3f6a5f4ffd7ef93763e78c087871d565.camel@ginzinger.com>
 <20200814115848.w4m2bfqttkid6woi@linutronix.de>
 <25412beffb96ab8c2b8f869bdac5a66c49faa5ca.camel@ginzinger.com>
 <20200817111311.zyqjznhferoqqxkh@linutronix.de>
 <05cc3d6085641c7f0425e45358451b05c5e9fc07.camel@ginzinger.com>
 <1ffc7e58e5fdc26c60f403e454d4077241605a7b.camel@ginzinger.com>
 <be2424198cd899ca182b38c51f97f5b9acc16131.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be2424198cd899ca182b38c51f97f5b9acc16131.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-08-26 09:56:16 [+0000], Roosen Henri wrote:
> Please let me know if there you find any unregularities in my config or
> suggestions on any usefull debugging-/forensic-config-options.

I have no suggestions. Well besides memory debugging, lockdep and these
kind of things.

> Thanks!
> Henri

Sebastian
