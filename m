Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 05:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108AE6052B
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 05:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhJKF4I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 01:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJKF4H (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 01:56:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22DC061570
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Oct 2021 22:54:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n65so36307177ybb.7
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Oct 2021 22:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAOzAGGnnupSbqlGEq/gtC02BeZ4adY9fDF03ytJODk=;
        b=DEYL0uBkg4mOq254ddi0O4+YSSA2YXd6qQjw2FhWX+sk4ws6ziNzhpN+XzQ5kHgDo6
         /8IB4b7akCgoccwyWI/7my7W1S3QmE67/p+Wq6Wi1nGnJonCzJF6SQ7thYPa5aM2bAtL
         L7Q1iPSkeo+HbRtQL90qkylU3ixthAOiTk4jM0Gl1e/k3Qfwx+/eiIaJtP/l6Oi1bBQM
         zJJMRBzY83rKU/QpV/cgFkDjfHX20yehks/YjGTMH/JmpSCWxkn4Po5q/XLGkYUZBrVt
         J4adhtb5s6tJTXUUP+0vYCu0GoYqG2DGKDUJMVgZI40Ru3svfa5N+Pcs9XpmdnOzGXsC
         wfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAOzAGGnnupSbqlGEq/gtC02BeZ4adY9fDF03ytJODk=;
        b=YzxFVzxBCfcsue8l1oiQFubue6jPQK7xWAaQJY7hTAsSjFn3PG1bGZ6rI6M1/3o2XD
         XQVAfQx45Ape8DNTDLlaosaR5KR6P0VMVamOLX8wRI4oO27KT5rNjGHa13WLZM/6NZr5
         uVvBxNfVVKRCPdX0+Xd4N6D8Mvb4U0tEIaNnXq/yQjJnHzCC3bfBQt5mujkb1Zy+gElm
         sleFJfEnYzck7PtgtAYrjrQBINf3lVpZnXKw9LRn058X73UPNA6pOxcG7udffh5aI+hR
         7U3bVaUqAFQ2Lu6Rz22Rsj7ZIeK5ugl/gFyNq8yCJWBtIF7z7x3NuqRIbzm/sqe2I57V
         X0ow==
X-Gm-Message-State: AOAM532blfxVnwNDUz2W4jA0eLGqeec8cS+uYDXpKPlapp90W+weaI0z
        OXI8Nax9WzIZnA4tOkHA7DWLsf8cwu2UaUTLLIQh5iY//Ok=
X-Google-Smtp-Source: ABdhPJwS4wJv/VZ9YR0NhyhG9MEE6qJe21ZskavEZ1dPMtK25dgSRtP7WN+FqrJCvskdvRnPU7GZfMUnlDlT6z6V+MA=
X-Received: by 2002:a05:6902:705:: with SMTP id k5mr21294520ybt.67.1633931646922;
 Sun, 10 Oct 2021 22:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGHUO10W0-MR4zPbbCZY96zXRTsRU4eKgb_0_1S+TLgcX=q4mg@mail.gmail.com>
In-Reply-To: <CAGHUO10W0-MR4zPbbCZY96zXRTsRU4eKgb_0_1S+TLgcX=q4mg@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 11 Oct 2021 07:53:59 +0200
Message-ID: <CAKXUXMxHUfS76+YGBz820D_K=m4Y3LEP-1z+E=XGwDEMiNfrhA@mail.gmail.com>
Subject: Re: [RFC] Following RT Linux Upstream Development
To:     Joseph Salisbury <josephtsalisbury@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 11, 2021 at 3:17 AM Joseph Salisbury
<josephtsalisbury@gmail.com> wrote:
>
> Per the RTL Project wiki[0], patches for PREEMPT_RT should be sent to
> LKML with the option to CC this mailing list.
>
> As most of you know, LKML receives a lot of mail everyday.  I'm
> interested in following the RT Linux Project as closely as possible,
> but I would like to filter out non RT related messages on LKML.  Has
> anyone found a way to do this? Are there any suggestions to filter RT
> Linux messages out of all the other LKML mail?
>
> Thanks,
>
> Joe
>

Joe,

A quick answer: just subscribe to this mailing list and you will get a
smaller list of patches in your inbox that are related to real-time
Linux issues, but this is not really a complete list of ongoing work
for mainlining.

But further just to clarify this mportant point:

RT Linux is not a much separate thing from the mainline Linux; most
development of getting the last bits and pieces accepted just go to
the needed lists, e.g., the printk rework (see
https://lore.kernel.org/lkml/20210803131301.5588-1-john.ogness@linutronix.de/),
was sent to LKML, but not to this list here. Maybe this is a good
heuristics for you: If a complete view of patches under discussion and
review is really important to you, you might just identify the names
of the core Real-time Linux Team and filter all emails from this team
on all linux-kernel mailing lists, which can be done quite easily with
lore.kernel.org nowadays. Otherwise, try to identify all the topics
under work for Real-time Linux, e.g., by looking at the remaining
PREEMPT_RT patchset, and follow exactly those on the mailing list.

Lukas

>
> [0] https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches
