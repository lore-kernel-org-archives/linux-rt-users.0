Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D818DC4742C
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F4221FD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Nov 2020 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLbX6RHy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u2E/8gL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbgKPRWZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgKPRWY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Nov 2020 12:22:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F809C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2020 09:22:24 -0800 (PST)
Date:   Mon, 16 Nov 2020 18:22:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605547342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjmTbb6r33nVaOeQssCCx8+rW0chX1s81iQrey6UUd0=;
        b=zLbX6RHykt5v7ZWySJ/f8mmH9ZDGNfJGeV198ezH6MD8bKjwanh3D2WY9cyE3XMrJydeFw
        Iy9YxfdEn0DPydwZ+8FIt7ePMjtZOMLOrlk1M4LXhVxrkeAztAgcGQk0xsXTo54yMV6Jbi
        55faFl56U2JPxAGpm9YT7e4oX8CbqeTjw/JBtNvmFVz4UCgHBjRPAh/WrrxDD3HDn6XxdC
        T+DFGWvEeBq3Vcjm4F+A55zmxA9PriGbNWhT5PKw0a/0IkWYcjgEmHTMeKw5ED+j8FDQje
        BJUCAUR60BlbzeVDZDbYcOxQKtBSkcz4sfFKVT+TZJ0gABIBL8vQOWlYgp6aBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605547342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjmTbb6r33nVaOeQssCCx8+rW0chX1s81iQrey6UUd0=;
        b=u2E/8gL7w9Dz1DakL0FtkQenkOjU2po3YZXHGbRplRFdV59hAQkV6sMn9UFWHGOxK9akT9
        BrNKTd3I/oXQWxAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT v2] net: Add missing seqcount_release() to
 qdisc_run_end()
Message-ID: <20201116172221.25ymeo62tgmzwe4z@linutronix.de>
References: <edf053cb3e36a3640cff920d74f582415896373d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edf053cb3e36a3640cff920d74f582415896373d.camel@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-14 14:12:45 [-0600], Tom Zanussi wrote:
> Hi Sebastian and Steve,
Hi Tom,

> This patch fixes a problem [1] I saw when backporting 'net: Properly
> annotate the try-lock for the seqlock" from 5.4 to 4.19 which also
> looks like it should apply to -devel.
> 
> This was tested on 5.14 but applies cleanly to rt-devel as well.

as just explained in the other thread, I would recommend to simply drop
that backported patch instead. There should be no splat in the devel
tree.

> Thanks,
> 
> Tom

Sebastian
