Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D108C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2527C64E85
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhBRP5M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhBRO5S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 09:57:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA8C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 06:56:34 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:56:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613660192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vanZ5/HCqWqz2RCATQaJvIEXpYBpGkC/CkCeRrL/xE=;
        b=WRXO/e1WY9Op0btFIXR+4n8dW/XiIK8tZKVAXXl4yflysdVx7Kj/PhpiY23TyKx+8NBMXo
        7VGHdciZMV75coB/FY63U8qEFQbT6mNsYvsFK9f5+nl2rK6XzygTAByuNC7PkHFqX5EPdz
        RbN8p0Aeued/1Wp7bVWZV2iN/yzDDG0l/lIhXM3/M5DFjM3RleZ/4xX3EiNuRatAsfKKEe
        WBnLmQ7DQc8ElipuBmKZ7PvwGV/62oxiPIjEb3OVUDtxhUYi9Jy2zd1pBcII05Wzgi5yMd
        cFHT5DosgZYsfV1b+/izfmC7We45Y2TuaaebgB97Q4vsxhVpOrsPdoZY8OxQfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613660192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vanZ5/HCqWqz2RCATQaJvIEXpYBpGkC/CkCeRrL/xE=;
        b=2mdqrSH31oKAUYov5trHg3aG+8CGjrklXMv+TqCUA9S5K37FXe8SMZTNm+GA1b4xYS+hlr
        JSFvtUv7GZVE9hCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: rcu_preempt detected stalls [5.9.1-rt]
Message-ID: <20210218145631.kiwwk6qhoatlkqde@linutronix.de>
References: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
 <20210218144104.rfpcpzp6rhvks5vj@linutronix.de>
 <20210218144334.fnohryfmztsywxly@linutronix.de>
 <a625ec08-730b-d09e-28f4-ba11febe6493@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a625ec08-730b-d09e-28f4-ba11febe6493@xs4all.nl>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-18 15:47:09 [+0100], Udo van den Heuvel wrote:
> 100% yes.

So I guess I should look into this then=E2=80=A6

> Udo

Sebastian
