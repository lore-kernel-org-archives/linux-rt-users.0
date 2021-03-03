Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84027C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E86A6146D
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhCDAVr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356407AbhCCH04 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 02:26:56 -0500
Date:   Wed, 3 Mar 2021 08:26:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614756370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwcSOzGMY0CzKVvj1qFzmW9c8MyAdk3J2WM9FhPOuXU=;
        b=Wx+qditlfmo9zg9Lh0Wm2HRTcXrFylNEs3plEcxP1ishRjW1EkKe4zkZ+UAt6xa/YgZWUD
        DVvYumTKJxHbpYeSpNvaGbCvdoVeIXxJ2K81RzE5E9TYlWrJMSRobvLa/55xfCerF7hkYa
        wOW7MqA0RY44DT0qT7YxWcDlPDajKuc6Il3EgJvuC1YBsxniefZ9dTuYM551rIHed7uqkY
        YUx6BRlRMz7VJ2L0iE0gYoYgXHwffPopqHMHlfQXZ2qDnkycTennxX2sHEOwRZYGZCCZ8m
        fSYnl1yMxNmoj4vbTpO7Zo4mddLPHcEUwXBTJVcXFGCQS8elX6TjuAnPLXNjBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614756370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwcSOzGMY0CzKVvj1qFzmW9c8MyAdk3J2WM9FhPOuXU=;
        b=+nKBIO1iIWihqlNQsdTCkD7lScup2PoMwxZ3hq0Bn9az1PhXisLRTzstAkTI4NF3RvNfdv
        D8IryIo3pDU1imCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] all: Fix printf format errors
Message-ID: <20210303072608.stni24hteabncdjw@linutronix.de>
References: <20210226073802.9406-1-ceggers@arri.de>
 <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-03-02 14:58:22 [-0500], John Kacur wrote:
> Are you seeing a compile time warning on some systems?

My wild guess would be 32bit systems.

> John

Sebastian
