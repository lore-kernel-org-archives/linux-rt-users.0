Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DCC4361A
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A044723110
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Dec 2020 18:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgLESyW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLESyU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Dec 2020 13:54:20 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440DC061A4F
        for <linux-rt-users@vger.kernel.org>; Sat,  5 Dec 2020 10:53:40 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y16so10483450ljk.1
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Dec 2020 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dDUwk90jziYI2krQWqAl3O9xgrVrPjSfCWq17+5k7uw=;
        b=YN8XNlbJqUQ1In/LN4GCGPv2Dt/WMcNUQ6COVcPNqtewSYPaEuhnte3dMT4zWWCl8/
         jgIyNshWafihJY0d+s3cMMJl6VBfk/HVPbtPkoDqxo4P5y3P3bKtJpWClIm0XXvGieUr
         mM+QyCFNFK9XPo6Xo5gFXeFXg6j/ltLKeKcz+VT24TwwxNVfFzxA1kgkgdnvzmY6PRpr
         UIPzgSKrkzGCFDLwl8xUpMk84Ez1s5g9v4zro87zZ2amAzKtTqxZoBn0OUazX8GZUGMu
         JU/8zRKH1aI+Uxfq53qdckY8Ix9ZXlWS5hZycIUEC+7oV0vBpESZF09cXLN2JAXiwyhZ
         WpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dDUwk90jziYI2krQWqAl3O9xgrVrPjSfCWq17+5k7uw=;
        b=Nonar2yLJOYF3nKOJmQK7sVCTqzK4/L8tdWIMX0uyJ77hQr6EQJCj7IZgEnh64g8AR
         3Mq7KGbrMdmTzXxeZ/cDPFKQDJTHXpxcI8qQsplQZspUStszJmsp/J4DSZafzTfD1M/h
         xERGoxCcndbkJJOC0irzh0wL7u1KpH7aY6rDdZSNb8ZBOWpn98a4xJZol2sClyMYKUgd
         hp14Xh5NLTpppMOg8Phi0i5Q2GsXvuSBhz2q5PU+RrGQgyO+MjhqyXMVpoYIQzyfkrIk
         m3ZTyL54GaXj//ZnZgRc9PO1WTNjYIsnWjzd63ZztLPJyrIRGTrxmqGC53ucYTpCpIum
         M3/A==
X-Gm-Message-State: AOAM532xw8W0urjor6BLCWcDfEeTn5Rg23902Eu18V/O9bVDVcgdQqGA
        WH2E5ylsZEYpjpnofxneM1LR+FHUdOrlpaxDgvhcKRbdJQy1lA==
X-Google-Smtp-Source: ABdhPJxUw0qjKlbcDGzOzepDrcciSPsN6ugQ5XNjG73LcRudHA+ExWGkFkKVp3xTz8qQhMvHXRvKzreaIHoQl2Wggb4=
X-Received: by 2002:a2e:8796:: with SMTP id n22mr5791629lji.345.1607194418975;
 Sat, 05 Dec 2020 10:53:38 -0800 (PST)
MIME-Version: 1.0
References: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
In-Reply-To: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Sat, 5 Dec 2020 13:53:27 -0500
Message-ID: <CAD56B7cQxt+0Fy6KXDHVJCA3qvtGZ6iU42_EBdcX-OTz1Pui5Q@mail.gmail.com>
Subject: Re: net latency, long wait for softirq_entry
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The trace can be found here:
https://bugzilla.kernel.org/attachment.cgi?id=293951
The softirq_raise with a long wait before the softirq_entry starts at
time 515.509590.
