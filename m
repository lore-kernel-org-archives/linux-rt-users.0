Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E449EC48BE5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CB161474
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFONvb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFONva (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Jun 2021 09:51:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D2C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2021 06:49:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba2so49449302edb.2
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2021 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u61IP45ErRHu1XSm4XpPBMQxQAMbY5rT3i06pp9fyeM=;
        b=c57CF2DXgG6c/5WZ8LFWaIEsswo3g4PhhJeqwwbnoL5eGlJ1y4GhVZaYZAajrkLcOz
         XE3bLRVdvnLiFnRE4Gow7jDo4RdcLsdnu6bkEXXHJ5rouzkCQKxiAMnNPwA4oNrO+Vea
         3GdBI/VBWh5oo/ZNDi2cHjjDH8IOj5HZy2mfixIEV+6J0Uw1M1DFwQbQs8WYKHSKdZgn
         kl6+HowJMKldD8ZzCE8cg9/tjZdeqtUyykBaNimczS0ohs13zAjHy8D8ULcJDrFUprS+
         L75MnIuHgOEXvNxOyOUAZGXBeFxNF6+ZYPQ3/hYmNrodZxx4fod9qmFyMUFHJorlUyNE
         5W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u61IP45ErRHu1XSm4XpPBMQxQAMbY5rT3i06pp9fyeM=;
        b=HWBOIF1kY6BMJk0/1UqqSJEDQHn05Afqu2wmbCYdKDQcookhgCetactqtIN2dMmEVO
         IszhmKOdTkK4UHr+tNBpi4zC56HPKc6vlCmC5Du9PB4y2z6hhzasoInxkp2ao8XvHf8a
         YH89YPK2fNH1ENDLw8bz52l/TbeBcPpX8aT1G6lKMXHXoQaJmpfqiVycfsPAAfWP0OlS
         RoLtzb8wPlEisEjMcRHIMzFcXwXgNaCWLNcH5a/Q9fnI7SXH5pcOHfqKOfOz/d3HYZgJ
         j6LgpBjlCEQChR0QjELRio4kA30h/5Tmg0QKpP8zCEk0DUwXl2tOxa/DixWLuW4/9quh
         meGw==
X-Gm-Message-State: AOAM530QFAOEwWMVvHULKd/joLEX7+TA6OhTRCzee7QnB5aReV/TVLtx
        CEWHjRiBcICt2cHqYeELJvyKl6LfNegxSg==
X-Google-Smtp-Source: ABdhPJw0O6ZLQGHj+qoSNkpROw0Uxgp/7GivRJT76/JCgM1aOODt73XHMixwFkKgDrdPso8epFq94Q==
X-Received: by 2002:aa7:da4b:: with SMTP id w11mr23943872eds.272.1623764963134;
        Tue, 15 Jun 2021 06:49:23 -0700 (PDT)
Received: from [10.41.230.130] ([209.206.26.76])
        by smtp.gmail.com with ESMTPSA id d25sm9052583edu.83.2021.06.15.06.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:49:22 -0700 (PDT)
Subject: Re: Hung task in 4.9 using kvm 5.2
From:   Christoph Mathys <eraserix@gmail.com>
To:     Luis Goncalves <lgoncalv@redhat.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
References: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
 <YL842Rg3yRcTpW2r@lx-t490>
 <CAD8J--9oKRQ2Fb9Q6Rtnfg21iU0NHYk-u8oVN-Rn=HqsEu93gQ@mail.gmail.com>
 <b7b5a1d2-472c-5202-6b10-d1e8bcfcf58b@gmail.com>
 <0d6485d8-62d2-0e28-fb30-b52883dc0ecf@gmail.com>
Message-ID: <e05f9a0b-042b-a64e-e5e8-7c47884135eb@gmail.com>
Date:   Tue, 15 Jun 2021 15:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0d6485d8-62d2-0e28-fb30-b52883dc0ecf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm unable to reproduce "BUG: unable to handle kernel paging request" 
when I use 4.9.178-rt131, so I'm inclined to think that it got 
introduced somewhere along the way to 4.9.271-rt182.

The problem with "hung task" is also gone when I don't force qemu 5.2 to 
use cache.direct=true and aio=native. Qemu 2.1 from Debian Jessie does 
not trigger this problem on the same system.

Christoph
