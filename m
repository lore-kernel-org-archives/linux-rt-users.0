Return-Path: <SRS0=qep6=D2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043FC433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF19522365
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zDwzOVT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Q8fccYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgJSPJi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSPJi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Oct 2020 11:09:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FDAC0613CE;
        Mon, 19 Oct 2020 08:09:38 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603120176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7nGlt0IAau+1wC1BEz0+nWCjYuyVVx93t5gJ7KzFPs=;
        b=0zDwzOVTVPvr6xfGTRdEMuMArrhm6DezAME1QpJeKkFSjbf/VGHKr7ECmvWNK4W4f5UWtx
        SNGqzifQwogGOMtREvafw+IDVQNl9swvWKvbgXauAQFrm0FxCxVtKlpB+HYMPYLWnqRw7t
        +2d5kjcGreTk4nhtwda832gHOk1FSKrkJMgLSwq1e26ZdVI06v3BnBjdWA+viiIIL+rAUd
        q/zHfIYacJVdqdGJw+9un03e2aR1sQyQV8nhxq+ham3gYOoxsA6DW7aapwu6zco4VH7EH6
        TqDFrFz7dGZZgmTWgnR62u34VOogSH+dEkHIXMJS+fkU2OoP79DLV/LWbWPNpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603120176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7nGlt0IAau+1wC1BEz0+nWCjYuyVVx93t5gJ7KzFPs=;
        b=4Q8fccYZg0YJQPx6iWPNB640rgSWl+nI46uDLq0z6G7t0ou4EeL+m2Hz3vcAhIEaIx8hB3
        v2s0rphgC/OebIDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sched: system doesn't boot since  "sched: Add new
 migrate_disable() implementation"
Message-ID: <20201019150935.koqbk57dmahhomdc@linutronix.de>
References: <1654655.1jrfHnk7pZ@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1654655.1jrfHnk7pZ@n95hx1g2>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-19 12:21:06 [+0200], Christian Eggers wrote:
> I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_SMP):
>=20
=E2=80=A6
> Any hints?

Thank you for the report. The reason is the migrate_disable()
implementation for !SMP.

> Best regards
> Christian

Sebastian
