Return-Path: <SRS0=SGFR=UJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7ADC43218
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC722082E
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNquKHdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfFJUqQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:46:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUqQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jun 2019 16:46:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so9666975otq.6
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2019 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H5BqlNj5Oks4MT+y6qJjHWIuTrpcCkmbskqNZ6fG364=;
        b=TNquKHdXU47EyBhjuXpsULILiDcZx0DfiyjYX0C1uAmRTNev0jhJsCUZMT6QDkVoia
         WJ4yRtqTXtNCcdojofcO/5IM5KHuh401lVGq77YLyGCkdB5A8XXBgmC+xpYiotZlRRXE
         YMALhzkEZhg2Mwrkkr13zbOd+kvBeXBAN/Z1G64vHiNLDOsWI12xQdIXhgOFS2dQY32S
         voqx7sw65Tjfq3pW2DNilSJ5uY71UoLa5/pihcysZcN9QXGQGJZ+x+oybadxPqv4q2Dv
         dCsChZUuVbZrxQNpdWSwcp6VaupXy9xO7XF3penas6wYJ7Xojqhk9DUyZ0bPQmSiJ+nU
         Rw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H5BqlNj5Oks4MT+y6qJjHWIuTrpcCkmbskqNZ6fG364=;
        b=BsD2E17xJXOwZFlsukwhhuh/F/LTYl3KiwLaCx2pqM0cuoFsh7TMwZS/LUVW2HdfaR
         VZtrgLYzOI4ji7xb2Mv9PUr3XCa3qjtH9jW8t4U+RPp6AQDCOpkcN8P+TH25RwpgA+GL
         BP1jUDmPNVbEQa+iTloKKnReSUDS+NshuwWlfiuDFliTesUxjIfefNiN9WxuXbjiIKuH
         zx0vt1H4+n4OKALT2oZb2hUgyHntXaFjW1X6FHKpW1AceVGA5WxhguSqbw18L5f96EWB
         pkLAvnSXYY/r+dNVhEDUBXb6dP9vnJbDGWlqMGn+Un+BROZkJqdUphz+fscsqOaoYaaX
         Oubg==
X-Gm-Message-State: APjAAAVsmimBrHWwQwumBE4L9cPEBJkUvRAn25Dz2ZyKAOIPyAFVc12c
        2w73mUK/qjnhutExnL5wMPlkdDsvbuEoHxw9AlxtualWd9s=
X-Google-Smtp-Source: APXvYqxzK0ck4U+st0YPYcJ2cINcPQR/FhfUEahihTXdlOqX4y/PAyH7GwHJTiX8XTnP9zLXJZqEo5ivR4RpfzdHHtU=
X-Received: by 2002:a9d:2225:: with SMTP id o34mr30281497ota.38.1560199575228;
 Mon, 10 Jun 2019 13:46:15 -0700 (PDT)
MIME-Version: 1.0
From:   Alec Ari <neotheuser@gmail.com>
Date:   Mon, 10 Jun 2019 15:46:04 -0500
Message-ID: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
Subject: EFI_STUB doesn't work if PREEMPT_RT
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm running Debian on a test system, CSM has been disabled. if I boot
the stock non-RT Debian kernel, I can use efibootmgr. When I try
booting the PREEMPT_RT package (linux-image-rt-amd64) or a custom
PREEMPT_RT kernel with the following config options enabled:

CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
# EFI (Extensible Firmware Interface) Support
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_PARTITION=y
CONFIG_FB_EFI=y
CONFIG_EFIVAR_FS=y
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y

I get this message:

EFI variables are not supported on this system.

Mount and everything looks the same as it does in the non-RT kernel:

/dev/sda2 on /boot/efi type vfat
(rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro)

Adding `add_efi_memmap` to kernel params doesn't fix this either. When
using a non-PREEMPT_RT kernel, everything with EFI works.

Any idea? Is this a known issue with PREEMPT_RT?

Alec
