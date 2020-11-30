Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F0C64E7B
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7D206F9
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GkHjY+KB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cytT6MDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgK3Qc5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:32:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgK3Qc5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 11:32:57 -0500
Date:   Mon, 30 Nov 2020 17:32:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606753935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaR3NAbZ9l+efCs0oIK/8D1qbTRqtOvlBevnYGdFB5g=;
        b=GkHjY+KBzzixyASW5TGajK4EonHPffk/9wLcyhbDWNTj7i7DE1/rrFALkHbqDS59tjepzU
        FJrEPV1cGTBPAWD5vqh5u9QJAjxO34FBWAcPiS5okbirXfHof5CByOjwcZvxUsdqjT3StD
        BpamjloE1qRUuY357sbalYDEundVzZkNL3PCLMCMl9lmFTcB7CbnuwraNMDel/AsafyZnm
        UXR2roRS9XtOXos1GSuL/2NNWZ4UewQlTmDU/Fn77duuqrQyC060cB7jOE1NYpd2Fz3o5z
        oLHvWksIJ7QDXK/YS5aNbyc++NqG2BV9w3LJhxDidVSROzjeqz/LTscY6aVavA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606753935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaR3NAbZ9l+efCs0oIK/8D1qbTRqtOvlBevnYGdFB5g=;
        b=cytT6MDcE6UQPQdirmzwPZ9eRgFaOE7IM4m/06a4MTQRLF2By3gNCOqwAMSOR3kJqaF6x0
        ZWp+rPuCQBd5K2DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130163214.3zdlppkkd7dnnpzp@linutronix.de>
References: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
 <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de>
 <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2658a2a26e53826687cd7b22f424e2d3319423dd.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-30 17:27:17 [+0100], Mike Galbraith wrote:
> > This just passed. It however killed my git-gc task which wasn't done.
> > Let me try tomorrow with your config.
> 
> FYI, I tried 5.9-rt (after fixing 5.9.11), it exploded in the same way,
> so (as expected) it's not some devel tree oopsie.

v5.9 has the same missing local-lock init due to merged local-lock
upstream. I don't remember when this get_cpu_ptr() came it.

> 	-Mike

Sebastian
