Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B99C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A688A60F9B
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhJLDMJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 23:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJLDMI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 23:12:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71108C061570
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Oct 2021 20:10:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r18so62268316wrg.6
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Oct 2021 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INefxig3E0nMtKvAeAzkbyfMFhXfTj0das0a4NTQb/k=;
        b=edIcIW7mrRbg0azHGspGZVeepdMqBvGDo+/4D7RDepgoZnlq9BBdur/G/bKQKL200Z
         LaQ3qV3Llsj6CK/tusrj7eOw5K3PvZL4Ct2f3627UXo/4uUpWEOLiuCE3CRbCEb3sKtN
         a9aIphA6w+G6+dLxmFDc7n+fSBqxycPndZj5udXOc5Iub+cn8HTewGwlrpHaewTFyXbw
         w1dd7uScxNYPG7Ktlu/zF6f+oxwXf1fqSCwWs8tJNRZODlK5s82F2oiBw7iJKqTDvwqh
         16+AZ63diH7NESv/xewvjmzIO9ygWpPSTQ75x7P4E28L1b9q/TYuk320nx3xQ4ZyJtWh
         5UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INefxig3E0nMtKvAeAzkbyfMFhXfTj0das0a4NTQb/k=;
        b=Fd2b6U5yMRfyzq7ety6qlFt5TCZOTC/4521lbCOMNhMPGRcS1uNi2CA5rF/VX4ou0f
         FeLMlA39wBFNBov9isdiX0ZdMutkQQYmI6HYwvyo4ZyOMjy5+Styk8HwG1HUrs+CDnBh
         Ko6Q7+7g+TB2WOCy/ckUA1XL7p5WNx0J3V2jKkzTHoh/4H4RicY9N+qRM+jmvN+e+Rc/
         9RVLsiSz9MbXQiOOyUXgu4V474QbEJO8FnYFJD6CGC3dUVv+7ZdxBsyL0GtrHmfhoqAd
         FBZldH467FSuu0v5X1+jgrkGERB8O8ID4h5YR7nDi7Pm3nj3ULqcX9M0dsKEz6lHqhs/
         zUjw==
X-Gm-Message-State: AOAM530xIo8q9v56R7+pIMoPipeB91XPAOfON5DFlmtAz8aMQQ1LFatv
        kpQd47z4uxcxwOlQy0hddacSRMFKxrVBC5Z7wvo=
X-Google-Smtp-Source: ABdhPJxIeUPFjfQAy8wjsmcBFFZlmCRVUG9t7EF6zLx+zGtCnAQNfylmKn+G1ce5cFPWLwH3+dvEVyFCp4IBrmKtt34=
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr21169152wro.434.1634008205896;
 Mon, 11 Oct 2021 20:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGHUO10W0-MR4zPbbCZY96zXRTsRU4eKgb_0_1S+TLgcX=q4mg@mail.gmail.com>
 <CAKXUXMxHUfS76+YGBz820D_K=m4Y3LEP-1z+E=XGwDEMiNfrhA@mail.gmail.com>
In-Reply-To: <CAKXUXMxHUfS76+YGBz820D_K=m4Y3LEP-1z+E=XGwDEMiNfrhA@mail.gmail.com>
From:   Joseph Salisbury <josephtsalisbury@gmail.com>
Date:   Mon, 11 Oct 2021 23:09:55 -0400
Message-ID: <CAGHUO128-HFZBuwVth26-n8KK3GT96aTK+VVFbyHZjVvcJkJBg@mail.gmail.com>
Subject: Re: [RFC] Following RT Linux Upstream Development
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 11, 2021 at 1:54 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Mon, Oct 11, 2021 at 3:17 AM Joseph Salisbury
> <josephtsalisbury@gmail.com> wrote:
> >
> > Per the RTL Project wiki[0], patches for PREEMPT_RT should be sent to
> > LKML with the option to CC this mailing list.
> >
> > As most of you know, LKML receives a lot of mail everyday.  I'm
> > interested in following the RT Linux Project as closely as possible,
> > but I would like to filter out non RT related messages on LKML.  Has
> > anyone found a way to do this? Are there any suggestions to filter RT
> > Linux messages out of all the other LKML mail?
> >
> > Thanks,
> >
> > Joe
> >
>
> Joe,
>
> A quick answer: just subscribe to this mailing list and you will get a
> smaller list of patches in your inbox that are related to real-time
> Linux issues, but this is not really a complete list of ongoing work
> for mainlining.
>
> But further just to clarify this mportant point:
>
> RT Linux is not a much separate thing from the mainline Linux; most
> development of getting the last bits and pieces accepted just go to
> the needed lists, e.g., the printk rework (see
> https://lore.kernel.org/lkml/20210803131301.5588-1-john.ogness@linutronix.de/),
> was sent to LKML, but not to this list here. Maybe this is a good
> heuristics for you: If a complete view of patches under discussion and
> review is really important to you, you might just identify the names
> of the core Real-time Linux Team and filter all emails from this team
> on all linux-kernel mailing lists, which can be done quite easily with
> lore.kernel.org nowadays. Otherwise, try to identify all the topics
> under work for Real-time Linux, e.g., by looking at the remaining
> PREEMPT_RT patchset, and follow exactly those on the mailing list.
>
> Lukas
>
> >
> > [0] https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches

Thanks for the feedback, Lukas!  Your suggestions will really help.

Joe
