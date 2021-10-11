Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49060C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3136660231
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 14:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbhJKOZa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243619AbhJKOZR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 10:25:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0EC02B873;
        Mon, 11 Oct 2021 06:56:12 -0700 (PDT)
Date:   Mon, 11 Oct 2021 15:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633960570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydfCU8UVBINEvm3NMag8k4T8SSzWV3k4Q87RDLtozsc=;
        b=ukPUtY6Qx/phgJ6ET3uNJuQZtqzY8Ri7LkyKdqISBltpS2pjlvowGgQpuSfUuBodO12lIw
        2mIAeMjlRH7zS6eW9xbOaLwY7kjpDmE83fX5M23sFzQOHCjUKoiwr5xjfqL0y2RcAs7bI9
        ilEnGqfUUHeEtbPHKINg0osK2Inm4LEY6wJFBY5AvbAsMpA6GNsaVCOT2KB4ufqhTgPjtn
        LyYTZ2EzdHMI9SLZTbK5CRdt/hqkGdjLJMK02m5QqO/9pOJxBrIER8zum7KtHj3iCbt5g1
        +QOyDCj/wmhZ77nWYseSrgtc7Ke6DcHpZLv3YwOV4ueSZc05IAi/WZOALFEysw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633960570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydfCU8UVBINEvm3NMag8k4T8SSzWV3k4Q87RDLtozsc=;
        b=E9u1IpzHA8yh5JfcEWKSh0ByvNBCue2Z4Dqy53MPH6YU7+5UngUy3aWz0VaiIXRCU1luLH
        EHlTxD0D3knS5vAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in
 netstat_show()
Message-ID: <20211011135609.22y7hkycbqm52w6d@linutronix.de>
References: <YVuviZ3F7MbPvleo@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YVuviZ3F7MbPvleo@uudg.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-04 22:51:05 [-0300], Luis Claudio R. Goncalves wrote:
> Avoid a possible circular locking dependency by taking the softirq_ctrl.l=
ock
> before taking dev_base_lock in netstat_show(), keeping locking order
> consistent.
=E2=80=A6
> [  106.529734] 5.10.65-rt53+ #1 Tainted: G        W I     =20

So looking at 5.15 there are multiple instances of that. Either _all_ of
them need to disable bh while acquiring dev_base_lock or none of them.
I've been looking at a few call chains and didn't find one which
acquired that lock from softirq. This does not mean there isn't one.

Tracing this back, I stumbled upon v2.3.6 where a few of those got their
_bh removed while new ones were added with _bh. So _maybe_ this _bh
isn't required and nobody noticed. Lockdep would yell if it would
observe dev_base_lock in softirq and noticed one instance like this one
in netstat_show() where it is missing. But it didn't happen.

So my guess is that the _bh isn't needed.

Sebastian
