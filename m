Return-Path: <SRS0=4wEw=VN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C9C7618F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B221743
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 21:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scTJtW/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfGPVu5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:50:57 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:35002 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPVu5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jul 2019 17:50:57 -0400
Received: by mail-wm1-f52.google.com with SMTP id l2so20099744wmg.0
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2019 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42G/3BprKnOub7UwnHOYU1v4U6hgA8jcD4mYuzJL1lA=;
        b=scTJtW/BJVdtTxLIyggN7BdEGhNzi/Nb2t6gvLt5ij41uvFVLQTGDJjL6Dk9NJsVBt
         +py89SZaZ8KiJoJRoyxJ3NglwAhmMO7S/1UTT51Zdf4vX5sVEg8QEhwiye3JZT53oK0n
         MrK/WTeTrpQTo7zFDjATV6t6JocwS3BJ14LvRiUjmXWMKCcj5dy3JsRtg7qIQ3272bdK
         VzDoJXnXe8kwSvOUlR8tL7TPJfwi8HVPtKIKVVR89NkBCYxQu36nuDtkIsLnmDjcKGHp
         zN0SJupgsr3snhw7xzY0fLXIl1l1jIEPyszKZod71nyYYDUFBJ35A4JPhAIiFi2MRSXb
         amwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42G/3BprKnOub7UwnHOYU1v4U6hgA8jcD4mYuzJL1lA=;
        b=R6qaRA+wDPmacY1u6RpNGAFzGxq80GM3UTqfca/RancSnUsbJGDitn5YVKiL+PaWL/
         gJ3rgUuEuuJYjkLyK3s6tNZ4ZNHO4ln97LN89sYDedJbGcCtKFQJYAWsm6yBHKtme2KE
         bYd9n6zx7pX6cgTRPOkQRnP23GcwMikm2XDbC91MOslHSVrXndbLXoYjEcHbVZme/kUH
         yFAYKO0tqh1MPRD9oXbzk0lQvPm1/0Z3doovocKNkNw9xdlgtFw7XVgHTZyv3diwAT7f
         /fGZMpFza3eAPGkUmDCWBykGCHxKGgE9VMClT6JlozeceNL4hy/Qec/oB11JwDL2tr8z
         gkZg==
X-Gm-Message-State: APjAAAWiIKLAEY7iQ6qnsZAnx9CNSn7Uj1tRSDmkOOqq+OGJP+425vYl
        sP5NYoar+p14s3byJW5Y7GA1kMHmjYH3Z31iJxFpRdTJ
X-Google-Smtp-Source: APXvYqxVmfCDv/w0hdWSLPBAN41L1Mlnns27sM/f0emk0ehpxm5/8AZrvQ5dsS3ZtEMwHI8/onZAIE7NRiCdwWDicSA=
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr34306731wmh.1.1563313855478;
 Tue, 16 Jul 2019 14:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 16 Jul 2019 17:50:43 -0400
Message-ID: <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, dunc.mcphie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> > We do have trace data for a instance where cyclictest hit 5000 uS, but
> > the file is large 11MB, and I wasn't sure if I should directly attach
> > it to the email. What is the best way to post or send this?
>
> Can you upload the trace to some place? If you don't have storage, just use
> bugzilla.kernel.org and open a bug, attach it and post a reference.

Hi Thomas,

I've put the last 60k line of the trace on the bug report here:
https://bugzilla.kernel.org/show_bug.cgi?id=204189

Just looking at the timestamp time of cyclicte-2778 I can see the last
two finish_task_switch calls are seperated by 5801 uS. Is just before
that the correct place to be looking?

-Paul
