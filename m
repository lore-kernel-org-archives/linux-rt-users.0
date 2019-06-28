Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5AC4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1705208E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 09:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srGCfkEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF1J2l (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:28:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44115 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfF1J2l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 05:28:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id p144so4198229qke.11
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3xHPcOgrut4eaIcNwmt7dmVcIZ7FH9sC9pJlaatthkw=;
        b=srGCfkEdB7Kt438X8OtrZ+NHYbgC4RN87lHFhlUoGvF6U1uy0/aseHh68S6EBsZ4m8
         Kpn7YQItc42mmIBlzanFzqQJDVDMoBqN1k/c+9d+t/siyimNSWlThIijx24sPdl3RihK
         Tki0X41XZR0MlO2kJdeKfgO+Si0JPIwbydP+L8pehcwgsyOPr8GxDKAxBK4sVwnM78DT
         Q3rSQzqrxzZbHZR8/jokj2vu7KKNbcIH5NK38wr1J+oohn0q+G4c/57oJrx+heN71mkd
         aQvv22uMvRZK/oYJwzVqloRDJ01ylcNSdkexNfngimXDQmAPupsRz8yrbhfwCBHQQ8+G
         PszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3xHPcOgrut4eaIcNwmt7dmVcIZ7FH9sC9pJlaatthkw=;
        b=S0czpMo2PqMkRJnNqTpgTbs0lqXMyjx+pUSX4HVqZBXOpFNxZhg2S3MfhLn//eDK4U
         pQSvXIyp0Q7sY1NkREVqjJe8pd1gNP/lDsxRrIdFszBfPxZVYb1VM0gDwoN4cuBiqVkA
         SJQ1jcuZ8rnSbRPV2q1UcEKug+8M0xe7iRiV8529Q1hPeUjhgXJ+O0EmraQhiOPWhNXn
         cm/g6WE/bbh/UQXiZLqfYP3mwAF0PBhmg7VfrkIpnv9DMA9tBKtXWwKm/DsAhgrKyUFP
         lD9IJsfe4V7MK8IQIc6as61cu1spMbpb6BM0/BO+gIgRTGZuxDeUXxjFlHQCAi57YRiZ
         XsTw==
X-Gm-Message-State: APjAAAV4PRQBuE7wk3SAI7scIizodKCKBjUri4kwHAQVjWVRSZvd8XMA
        QBNd7mSPiQCu4ftW2E8sBar5sexT4Fg//qCaRqoeDMgn
X-Google-Smtp-Source: APXvYqxhkj1Fo7a5wQp5yKpzjJoqtqfstqImeSHRj1XS3SSntZSFqmwrJ6IKbtEhcJNEOeDYKV10NtvbxTiumvg/HJs=
X-Received: by 2002:a37:9042:: with SMTP id s63mr7465975qkd.344.1561714120065;
 Fri, 28 Jun 2019 02:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
 <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com> <20190628103435.0d95ebe8@archlinux>
In-Reply-To: <20190628103435.0d95ebe8@archlinux>
From:   Arve Barsnes <arve.barsnes@gmail.com>
Date:   Fri, 28 Jun 2019 11:28:27 +0200
Message-ID: <CAJjrzcUBU5PPSzwXwm6wD8vT_mAakE-mepN1+CQuCoPNMWwgzw@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 28 Jun 2019 at 10:35, Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:
>
> On Fri, 28 Jun 2019 08:05:12 +0200, Arve Barsnes wrote:
> >I don't know if this helps
>
> Hi,
>
> I also don't know. However, you did not mention what hardware, even not
> the architecture ;). It might make a difference, if it happens on a
> "PC" or a "Raspberry".
>
> It seems to be ok on my Intel based x86_64 machine.
>
> [root@archlinux rocketmouse]# uname -a
> Linux archlinux 5.0.21-rt14-0-rt-cornflower #1 SMP PREEMPT RT Wed Jun 26 20:13:44 CEST 2019 x86_64 GNU/Linux
> [root@archlinux rocketmouse]# hwinfo --cpu | grep Model | sort -u
>   Model: 6.60.3 "Intel(R) Celeron(R) CPU G1840 @ 2.80GHz"
> [root@archlinux rocketmouse]# dmidecode -t 2 | grep -eManu -eName
>         Manufacturer: Gigabyte Technology Co., Ltd.
>         Product Name: B85M-D3H

It should be a fairly standard PC :)
$ uname -a
Linux gentoo 5.0.21-rt13 #1 SMP Tue Jun 25 13:06:55 CEST 2019 x86_64
Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz GenuineIntel GNU/Linux

I don't have those other commands installed, but outside of my trouble
with -rt14, it's interesting that my uname output does not mention
PREEMPT RT.

Regards,
Arve
