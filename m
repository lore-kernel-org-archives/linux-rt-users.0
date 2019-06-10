Return-Path: <SRS0=SGFR=UJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202BC43218
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 21:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7BE2089E
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 21:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsPGiF9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfFJVDI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:03:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42270 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388311AbfFJVDI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jun 2019 17:03:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so9682429otn.9
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2019 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PYdG4Bh3IMiwp4KryMz0cafbKHYzSCZLnKq+8KEAH9c=;
        b=OsPGiF9RxEVs5nh3qcaMe5qVNQKVwT6/28n3cr1apB/VfklztKuJFrOuz2NHj2id8l
         eVFRmYgNnCO+TdN9wqNhA0MgYEcou2rBv8Fp3gaPkXArjv41GB8dba7HAVBnSyaWWGYj
         eb7tPdTR9W1yCj2foLZ8jKQn7gIkD/Um4anW0sAt4GR+9puOGUzVJKiKTfKEzdQ6NGB3
         HDHbZ3ZZUUIQUbskbrJxuc9G7ZGT19Z7mowacrSDwosQL1sz4YlEfOd7oMwGT9WcpFO6
         PY1jr2TLW/FUPl0Gp+U4czt29vi1CcLxnb8FTplSaKublaZiWMApWpYAM46/f3M86FNx
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PYdG4Bh3IMiwp4KryMz0cafbKHYzSCZLnKq+8KEAH9c=;
        b=aauq3JiFH83RFBurjknOQRZZHZ0ixgdIMO3Mz9Z1zspT4OS7GKi9J4sgb3gm6IVKaO
         KCXMzUrwabsiAwba2VxSmd4Ap1m+iH7L2LUIBF67+ry3dsvJBaj/33vmxIF3uMuC4QLh
         MD3gcuKRQoSe4T51l9UVZ5Ecpe1BDXtmtyAuYoNbpXvU4mblYIfbF/YQnbSJ4oE5O9d3
         yJAG3Vo0kiZEHFfeJ8wqRfDalCwHdSk4mPwn91x6dxVMv0SbCUP2MR2YDNuMSUeblKjg
         z/8b2JqYDm6kjsIZpWHDHJ68AQOuXKd08h008eTw562nYReN/Jc/QqkYHpa22eOV2IZH
         dnnw==
X-Gm-Message-State: APjAAAV0YyKL3A308PJBu+9657GGAFzY9NpHM9LkQF9jL4SFNPdubEbo
        bkzcm4O8KpPq0AS40vXJ7UmDU5ix/8Htztb9n6bxArNVBKs=
X-Google-Smtp-Source: APXvYqyf2rpmdYw9q8GKuaYXBQ4aQFNwikm/rY7U2lknLzLQcXPw3YET3VjHDLUiNlLf3qHt+cje1Q7SyIjkfssGZ0k=
X-Received: by 2002:a9d:2967:: with SMTP id d94mr32101460otb.12.1560200587001;
 Mon, 10 Jun 2019 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
 <CAM5Ud7OHEJd6ec798ryWH2LbQz3AYu+Zb68BY4GL_KF+toJfcQ@mail.gmail.com>
In-Reply-To: <CAM5Ud7OHEJd6ec798ryWH2LbQz3AYu+Zb68BY4GL_KF+toJfcQ@mail.gmail.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Mon, 10 Jun 2019 16:02:55 -0500
Message-ID: <CAM5Ud7PO3R=RMdN2wru9fJDoMtUNLNW9zuei7_BbZTgwFuPz5A@mail.gmail.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

One more thing, I think this is all related to this message when
booting the Debian PREEMPT_RT kernel:

[    0.556708] efi: EFI_MEMMAP is not enabled.

When compiling the EFI options into kernel (Y) instead of a module (M)
the message disappears but the problem remains. Switching between the
signed and unsigned preempt_rt kernel packages have no effect.

Sorry for the noise.

Alec
