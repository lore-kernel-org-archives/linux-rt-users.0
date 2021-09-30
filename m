Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0454BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AB561A59
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349685AbhI3XmQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348832AbhI3XmP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 19:42:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FFFC06176A
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:40:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so5959397pjb.4
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c3ZJkBoC6jGSqEGAGeDjBKeXBWcQfhkojnW+Xo8j8XI=;
        b=CM80o18giomJfRpzl8DSoxl+P4oe1sXNgcKVIOu6wnShkaVXSfdC2ikrZf/lAdlSEr
         eIPQN6ltMFY5vhb140DlWmN16jjxgoRUQNNXRNs1WNEEziHxq4ZrD+OwSrjLQ8XDJE1f
         wV+GiT2ThkTWKoPDdZnWP5VH0X7+8hM6gdNmMVYGDR9oa/TqEwhG4F71vivcLHD7rolW
         d9drvemITK6HjBGycBVR+U6hEdU294XmyRC7+zpxY+R5wftn74bXJgLJSXYhxH2y+MQ0
         WnDDorAWpPGMsMSAE0ANsMmlBhmM+JFJ+cBStY+K+6llxNQ2TLtStYimu+ydgH9EsWMa
         3/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=c3ZJkBoC6jGSqEGAGeDjBKeXBWcQfhkojnW+Xo8j8XI=;
        b=X8YQbZ/uRTjLZqZmpS3ubxgYE5Y2Br45qHG5MYy8LCVmBQJkF/yPGPtgSc/O938N+o
         3tL0r9OPLhqwMLCPmUXd3Z5aPGAkDeugoD5yC+2++b5C4GKyOWWqItKgXhT7av671/YH
         /nCQ3UWWHCF8NqLM7IV2UGLBqnwXBh/DCFOYAAsxA49+8TleQpQvJGSmakGvkBRnosZu
         A8IUvWOhjScj1PwgKtc2Z5xVttk0BHNA69N2UL3CjKbGaH6odxdOY/hhfxXTltMtTwxS
         bOKUrei9HSzi5pATzGzq2XEwyXQvwA+jTXavP76uzRH6+UDCBgOZ2DXpxH89cCpWulAF
         FJjg==
X-Gm-Message-State: AOAM532dmj4B0kTGJqsRZ5H3KLh9UzGSDWqSQ1UmCLR+AKavR4BN333x
        SCd7mb5wi4WytDLXHKHr5Bw=
X-Google-Smtp-Source: ABdhPJyXtMv0nk8o2hPFCjD0xLGWSE0EkTSzi+8JAT+d/66TEyd4w2zZPu6m0c8WB65yct0zCPCI9A==
X-Received: by 2002:a17:902:c3c5:b0:13e:31a6:c1c7 with SMTP id j5-20020a170902c3c500b0013e31a6c1c7mr6735722plj.62.1633045231677;
        Thu, 30 Sep 2021 16:40:31 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id a10sm3930399pfn.48.2021.09.30.16.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:40:31 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
        <87y27e53a2.fsf@stealth>
        <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
        <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
        <20210930135145.mdlzzwp64yykixhx@linutronix.de>
        <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
Date:   Fri, 01 Oct 2021 08:40:25 +0900
In-Reply-To: <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
        (Pierre FICHEUX's message of "Thu, 30 Sep 2021 16:31:25 +0200")
Message-ID: <871r554opi.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Please don't top-post[0] - it makes it harder to reply with context from
previous emails. Kernel related mailing lists tend to prefer
bottom-posting[1].

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> # cpupower -c all idle-info
> CPUidle driver: none
> CPUidle governor: menu
> analyzing CPU 0:
>
> CPU 0: No idle states
> ...
> same for all cpus.

It looks like cpuidle may not be to blame for your woes.

One last thing to check regarding idle (call me paranoid) would be to
see if there's an option to disable C-states in bios. Not being familiar
with your system, it would be useful to rule out any firmware driven
idle management.

Barring that, maybe look into upgrading to a newer kernel if possible.

[0] https://en.wikipedia.org/wiki/Posting_style#Top-posting
[1] https://en.wikipedia.org/wiki/Posting_style#Bottom-posting

[...]

