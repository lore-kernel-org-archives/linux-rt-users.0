Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDFC31E50
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 23:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41EA2184B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 23:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEu0F9GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNXTM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:19:12 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45768 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNXTM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 19:19:12 -0400
Received: by mail-ot1-f42.google.com with SMTP id x21so4148183otq.12
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Jun 2019 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aQULnPdlYciNTu0sBh8V7ZY6UVUnpnfmPrGlSQ77RAk=;
        b=AEu0F9GOU16TVEEqOAR7/FaDSMI9hnWR5+DAbTIt4/aDqVUTWqAS2ogTKU+huTyAyD
         59iuCcFrVIstw9mIOvQr9B3E0bgTOEM5rRurxA4hch097sIyUj84mmnvZItYwcz8t2bN
         MxJotuAL/hltoO7MYVdAj461d4RS7SumA7RWEMc3VpBAUg1NZMAhTP7U3gavjslwYKBw
         lfwgS0KeylW2BtQilmwfY4Zn+lOWHeFtjK/wLm8MCLGVRx8BQIjfjbFP9MYY5f7qBpkX
         6jEVyxpW7eTRvfkcs4opRwrkPwaOvt1k0EIC/pkd0HofAUNR1h8nsPjadmNiLhNCaJLo
         EDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aQULnPdlYciNTu0sBh8V7ZY6UVUnpnfmPrGlSQ77RAk=;
        b=brGWxGMcMhETUOVJGp5/dudqRZAeJDP6uDm9i5bFcxqPXxTh+Pd71b/o/fKVgAfWAd
         +bnI3EoK/LlgMjJL+HyBvyQ1JQcG+V77izJDZh7Hns5BF/1JQX0ZCeByi9TWtycdjRT4
         Vor3+iEZcDfXFdxf31u+LLxaN3uelmmzWhDerdjOmft3mIScUPTB8F+aCekEf3tIjoxn
         3T5TdJ81UrS3LfQ1M4p6AdhLMbGb850uh1U4GbXuWuHqKVYahuTj6BnBGMwBjyL7kCzr
         stXHjZrYVLeqewJ8WxrspMx3SP88bYeyXvt5KjmRZX71yM8XledmS06E6C0FSWgbHLwJ
         tutQ==
X-Gm-Message-State: APjAAAVlt/IKG9rWGs5sGk5vGM89z0+HmO2Q4FDMLYmdqEk3EaT8uFqy
        B9IorftnDprkP8urgrBzu5L8Sa8vkd5gjeh33BHZoicm
X-Google-Smtp-Source: APXvYqzjGV0j+XAWQReG1wj3OF59yzGAShmkfD8pTWqKoinqLy19iXnd5hz7bCXkEiyNCAZucF9ndi91JM6L9KFb+1w=
X-Received: by 2002:a9d:5a07:: with SMTP id v7mr2657317oth.38.1560554351720;
 Fri, 14 Jun 2019 16:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
 <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com>
 <CAM5Ud7O2OtDLdJPArAAfw7A1xBm89dBSXk64vYsb-KY9N5RXUw@mail.gmail.com>
 <CAM5Ud7MTfpyv4ajVkuoe+_pjvq0t1ZWAGUUukrDK+xf5Rx0qiQ@mail.gmail.com> <20190614193616.22w6gc56kobs2eaz@linutronix.de>
In-Reply-To: <20190614193616.22w6gc56kobs2eaz@linutronix.de>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Fri, 14 Jun 2019 18:19:32 -0500
Message-ID: <CAM5Ud7NmgQWMvQ_5dxi=0QQUNTveUrwfngKvECrf6tzM_rou+A@mail.gmail.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Yes,

All is fine with efi=runtime.

Alec

On Fri, Jun 14, 2019 at 2:36 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-06-12 12:01:46 [-0500], Alec Ari wrote:
> > EFI Stub is working now, thanks again. Latency isn't affected by EFI
> > on this particular board (ASUS TUF B450M-Plus Gaming) with Ryzen 2200G
> > and BIOS version 1003 (dated 2019/04/30 -- Latest as of this writing.)
>
> Did you try to modify EFI variables?
>
> > Alec
>
> Sebastian
