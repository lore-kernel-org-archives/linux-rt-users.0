Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF6C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605821900
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVspWheM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCVQBW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:01:22 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:41024 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfCVQBW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 12:01:22 -0400
Received: by mail-lf1-f47.google.com with SMTP id 10so1744105lfr.8
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Mar 2019 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gUUYV6wlwAN6TaJthdg92idKeDkQpzv5Vl0WvmWkJGo=;
        b=BVspWheMG7h4AElRaTqMOu/5jFR8GBJMQM6cn4UZEo9eeBNrnHHX//Lvq8PYptxbXZ
         zr/A3IM6TIcMjSzXoio4zcdBuB+FzN8g3b3KFindwnbPyxHjW5LmisZnWaIraNRZuU7J
         0laINGj5xGTBRWnkaa2C98rT/ds6qoS9gAEdf00cRu1RYcCr0ZDRTV856EVCFhoIci46
         6W6c7biqCvenC76lckCRPXdtF7jRR1pBJKxmdbnYQwFB5Ga99GGHI/JdFijig0dI7Vpz
         xelMiq52ns0BKkrFfmJrhZWNKRTSu12S+n4RlENSN+1kEpwic99FthCU/N6Wxe1foPBs
         sg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gUUYV6wlwAN6TaJthdg92idKeDkQpzv5Vl0WvmWkJGo=;
        b=Jsn2RkSoiqQEE+puyrlvb38rq3gwnHJsJvsopE+5uQDrhCaHLPRZP8cwV9wzxFrQLr
         d7h5rQfeV8rzW5q8oJnWjJC3XKqTLGcoAeL123kWpKFzchyGb2jb8nl789HSMiJH7SUR
         EGcMdLdJ0FabNLiCG+2ZL6zzi05maR8aMFapjlPj+h7/LBWCuACBSzcN8JXwGm0hoE0o
         vzx+wXS0Ui1AgB8WK1ULvyJY6TRxofy05dvUSup3HE6vUGaermJf9o52pCSDczHzQ62l
         erMjIntZWceL/xTuVyXA3+DT29Ni+5RNujCX1yU2Mz6E/U5Tjd0iQzlEZfEak3UHN7W+
         4q8A==
X-Gm-Message-State: APjAAAX+QMW6emzacZu/gg6f9XD9tNC96Ve5bGk3Oq9nYjxYAg6lD3Vo
        M6DEW+XrrDnuodwQwleh+V0ydiWyZKJNsQQiyk4WkCbLHzg=
X-Google-Smtp-Source: APXvYqzUBFr8gQH5zRmTa0L0tRWrcPjY4sh3NZ5Lk7WoHSGYeM0x/lZA5KF1614XKLRswyKIxwsuyOKuZO2jGszlMUM=
X-Received: by 2002:a19:7613:: with SMTP id c19mr5372063lff.105.1553270479194;
 Fri, 22 Mar 2019 09:01:19 -0700 (PDT)
MIME-Version: 1.0
From:   Budiman JoJo <budimanjojo@gmail.com>
Date:   Fri, 22 Mar 2019 23:01:07 +0700
Message-ID: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
Subject: [BUG] /sys/firmware/efi/efivars: unknown filesystem type 'efivars'
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello, I get this error message on boot only with Linux-rt kernels:
/sys/firmware/efi/efivars: unknown filesystem type 'efivars'
I'm on UEFI System but Linux-rt can't seem to mount the efivarfs
properly, resulting in my system booting into BIOS mode instead of
UEFI mode. Tried setting both CONFIG_EFI_VARS=y or # CONFIG_EFI_VARS
is not set. When I switch to regular kernel, then the error message is
gone and I can list the files in my /sys/firmware/efi/efivars. I'm
using Manjaro Linux.
Tested on linux-4.18-rt, linux-4.19-rt, linux 5.0-rt Thank you.
