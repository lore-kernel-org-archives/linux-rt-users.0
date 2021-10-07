Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB514C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC4F6113E
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhJGRVg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbhJGRV2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EFC061570;
        Thu,  7 Oct 2021 10:19:34 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633627171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wBNXpOyOE9HM/ZxKmlXobh0LUJjnX0lvRptKFcJ9OM=;
        b=CplXng9MzFaWzWLGbE7dbGYVRiEz9vM+u23h7FsSuYGIATEg10B2TooG22kkSAGJ20c2tY
        kO18pOcumb/6I9CoSGe4PnHi1cjlYlT3lQ0KMXdj13lwUEawnvhm73LHno9WpsP9L7+udR
        CGnX7c4payqQPFfWHCx/dA3c2WpX3Fp1ELSmM5Ttnce0ypdJ8dRmqeB3xG5nzmR/MT23eF
        vv2B85aL7V2SMTmu7yya3XqVQh3102h22WfSBEHJBqLAlSZ18I+17NWgxHMbx8aol2HDDk
        XOJ66uvBHMXSXE7W8uK7PZv/Q1PphCbVQQ0ERi6CWaRxBdrdiCAtGA2N3PBnvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633627171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wBNXpOyOE9HM/ZxKmlXobh0LUJjnX0lvRptKFcJ9OM=;
        b=d7CGKbpnAf0ir+dumPZAcFuOBpLbCt/4ajaYrOsBVgdTNM/oeZSOm+W1Vwr+yC6HpHdzME
        kph48471npeMewBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Jun Miao <jun.miao@windriver.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10-rt+] drm/i915/gt: transform irq_disable into
 local_lock.
Message-ID: <20211007171929.hegwwqelf46skjyw@linutronix.de>
References: <20211007165928.GA43890@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211007165928.GA43890@zipoli.concurrent-rt.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-07 12:59:28 [-0400], Joe Korty wrote:
> Convert IRQ blocking in intel_breadcrumbs_park() to a local lock.
>=20
> Affects 5.10-rt and all later releases, up to and including when
> rt was merged into mainline.

RT was merged into mainline? Nobody tells me anything anymore=E2=80=A6=20

> This problem has been reported in two other linux-rt-users postings,
>  =20
>    [PREEMPT_RT] i915: fix PREEMPT_RT locking splats (Clark Williams)
>    [linux-5.12.y-rt] drm/i915/gt: Fix a lockdep warning with interrupts e=
nabled (Jun Miao)
>=20
> Neither of these submit the obvious solution, nor,
> AFAICT, has either yet been acted on.  So I muddy the
> waters further by submitting this, a third fix.

5.12 is longer maintained. Could you please take the latest devel tree
for testing and participate in
  https://lore.kernel.org/all/20211005150046.1000285-1-bigeasy@linutronix.d=
e/

?

If anything I would prefer those patches backported into v5.10 if it is
affected.

Sebastian
