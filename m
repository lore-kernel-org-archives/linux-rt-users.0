Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169FC433E9
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A588F64E83
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 13:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhBVNpZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBVNn3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 08:43:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E73C061793
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 05:41:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:41:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614001276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSyCI6ylSKkHhPSprKBzulW3xfHdDkiezgdIZTsdYFU=;
        b=fQbK4wb43PgsM17c3xOxBdDuqe21TF5OuLC/NAF7Tk9Fs7r2j09GU/cqxk9EGCJojZtlHL
        rciPew3VcG7R7GI4age858pqVUYhTsL/SVq60Mzdskwh1ETJF743JipvhHOpfOnqkyHob4
        mE6bWh9skI1nlmNWR1uwU/1us5mA4LL0ppzYorfAsiwqhfeY3x5G+brPZ44cW5TaQfnHuO
        eSCajLNWwnBoskRvDY0GSGedIa60hyKojWNv9GCp5l/wxpBSbhElUlKhKKVKBHyPkBIATa
        N9XFjBaHrMsyfnb5Ew+6f37omPkjeqDdJV0/B7Q9pCkQA16hAbQ1KWwJrYXFiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614001276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSyCI6ylSKkHhPSprKBzulW3xfHdDkiezgdIZTsdYFU=;
        b=dgKrQjWCSkdOHeeeCGqc9LFxAi+DoifXFOe4+gBBCW5HQledKdghy4eXsBam0ZnW/PRZaT
        8t6lePmifJDzSiDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: sync system call failure
Message-ID: <20210222134115.pjeiszuskg5kk23n@linutronix.de>
References: <6ed96c7e-aa40-e8d9-6330-85dc84514a81@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6ed96c7e-aa40-e8d9-6330-85dc84514a81@nvidia.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-21 17:46:25 [-0800], Dipen Patel wrote:
> Hi,
Hi,

> I encountered below crash during the sync system call possibly coming
> from the stress threads spawned because of the --io options which does
=E2=80=A6

> Platform:
> Nvidia Jetson AGX XAVIER, with 32GB eMMC 5.1 and 256 bit 32GB LPDDR4 RAM.
>=20
> Kernel:
> 4.9.201-rt134
=E2=80=A6
> Call stack:
>=20
> [ 1813.814464] INFO: task stress blocked for more than 120 seconds.
> [ 1813.814610]       Not tainted 4.9.201-rt134 #2

This is not a crash. It is simply an information that a task was blocked
for quite some time (as it says).
The important information would be:
- does it recover
  - does the time in seconds always increase or does it also drop
  - does the message disappear if stress terminates.

- does it occur on v5.11-RT.

Sebastian
