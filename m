Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC14C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 00:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E104261029
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 00:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbhKIAU1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbhKIAU0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Nov 2021 19:20:26 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F63C061570
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Nov 2021 16:17:41 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m9so5936699iop.0
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Nov 2021 16:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNdyFNsXSxNH9v9OHYQYy0Fxo/ERZTiUg9ChGLYPaqM=;
        b=mPkT5sCISyMHomK7MwTPUoP3oeOinJ6I+tkDwYFP9gnyW9pLQnt84baCR8t6SMxnwv
         RpFozqU34DNVP6J1KAOa/5dKJNj1ONTcOkWoW1nlNYTRqRv8kqlrWoT4qEJQvDzhxQtM
         rz90KJP+CsTSSI+dl0EoGwhk72YZzXWsbGlzPSpEM7l9KoACQLPdItU/qwp/IYbNXCEH
         f8XWXDP6PEQOO4jnaP7+1F1j0BiGmu0D/4hoz8BICQQolxVxg7mgshgRp6yQd7l63uAD
         YsnomcrwCOAQK8QFfhvBcJ7Z148rmBuqpA21T9ST753x7q8dh8CmNMUgkpbHbY/4Nkxo
         SCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNdyFNsXSxNH9v9OHYQYy0Fxo/ERZTiUg9ChGLYPaqM=;
        b=d6eWjlAACmBFbVI+CQu5e+uY2MF6quPjHYhZLFk/dgHxe2auxMPjTbZrP7oPhO2bA7
         KbK4Ngi4vMRhCqmpVIyJN27/vLmy+Sxb8zygYbwG3Wk9VZQ5wK+uv482T0Xi3bvAy5xk
         BKF9eBHbdOeaIVOqf/2vHVW1HI1+CYm0ELlVeAhbd93OZ2fTN5QJrJnmc0fLzUGy1Ij5
         Lkl6I6rnJWj0I54JoV/szALO5wf2zj+XeqxXvI1amxlzW5KgTaNbws+PXP9foZtxu7DR
         RZ5hOmoJh/QM/x6CMAlhguvd2oBuvGFRt49N62nmPqMeFVf+RxofCZveU0qzLM03st9S
         PaMg==
X-Gm-Message-State: AOAM531PsbSZVA95m/u01/vIYCQfk8KNtbY6FCWPCiIM2JeUu/Fo0jih
        vtM080VckJtXOE6rtwkL7XnO/zLayDCj6WBkFe4=
X-Google-Smtp-Source: ABdhPJzaDCiygLcrd5ti4gJE5oWUGybo1/WIZc1eZWZEgeexvNi47OxZOWnoyB9Yww83x2WYehLqlQNX8aooaz0xgVc=
X-Received: by 2002:a05:6638:164a:: with SMTP id a10mr2327795jat.1.1636417061049;
 Mon, 08 Nov 2021 16:17:41 -0800 (PST)
MIME-Version: 1.0
References: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
In-Reply-To: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
From:   John Kacur <jkacur@redhat.com>
Date:   Mon, 8 Nov 2021 19:17:30 -0500
Message-ID: <CAONaPpFhR9MCrOa7WHLNDkD3Jx=hvzyJ=Y0jV51Y6WWZrsAObQ@mail.gmail.com>
Subject: Re: Questions to CI Testing the RT-Kernel
To:     Gylstorff Quirin <quirin.gylstorff@siemens.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        SCHILD HENNING Z003BPMR <henning.schild@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is a program called rteval

It uses cyclictest as a measurement module.
It uses hackbench as a load module, and it also compiles the kernel as
a load module.
Finally it can uses stress-ng as an optional load module - the support
for that is fairly new and developing.

git clone git://git.kernel.org/pub/scm/utils/rteval/rteval.git
To run from git: su c './rteval cmd'

You can also get it in Fedora with dnf

John

On Mon, 8 Nov 2021 at 08:52, Gylstorff Quirin
<quirin.gylstorff@siemens.com> wrote:
>
> Dear all,
>
> we are currently looking to setup a test lab based on LAVA[1] for
> CI-testing the RT-Kernel.
>
> Kernelci executes the combination cyclictest with hackbench in the
> background[2].
>
> Our questions are:
>
>  From what I found the RT-Project also uses the combination of
> cyclictest with hackbench for testing or are there currently any other
> tests specifically for real-time executed?
>
> Are there recommended tests that should be added to the CI testing of a
> RT-Kernel?
>
> [1]: https://docs.lavasoftware.org/lava/index.html
> [2]:
> https://github.com/kernelci/kernelci-core/blob/main/config/lava/preempt-rt/preempt-rt.jinja2
>
> --
>
> With best regards,
> Quirin Gylstorff
>
> Siemens AG
