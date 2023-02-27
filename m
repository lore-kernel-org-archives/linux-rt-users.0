Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F27C64ED8
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Feb 2023 09:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjB0JxQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0JxP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Feb 2023 04:53:15 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81F5FD2
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Feb 2023 01:53:13 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t14so5788678ljd.5
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Feb 2023 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/w8jKKleuy2zEskHI2b/KTcDVCp+wDhktFphP2VlKY=;
        b=pXSNjf8+XxQk+QGM4Hl+Cl2U3J0V7ypzPs915uk/mFkTz9z6hsNKjFp1zIRv/a3Cdu
         9JOB6gywmgz2qkeb+j8Dj8L+zNyoIb72sb/dSrVNuMneCk5/ao9XpccRMBH6uJon9MUH
         iXRu0iUywz0nFSO8lmmG0x/8qLQ7r2NAQxGLs8DUrtGYha+TreckYkiE8xQChg0oVFU/
         WqvqWKew4kaC0+JfTS4tj6A8Gx9w0lUdZszhZu/O64hYdjVCJm8p7ACbi0syrVUVE005
         bvHRBLUj1F9U+0SmvKRKBO4jak4RaHaiZ+5djSJ5ejzY83RztvagnhhAGfrXgkAiKkBH
         0KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/w8jKKleuy2zEskHI2b/KTcDVCp+wDhktFphP2VlKY=;
        b=ky3OE2GLacoXIUbNgs5KswJOtS6095oak5e0KvjE9BfbpJ5/esOvGyryDmBq5uh4UD
         HnqYxih1nhs2KAXCGAb8gzdRu7x1QorsYRHyQdnrFW7pFdLUCdKIJYE+kUO69V42IofL
         a9jjVXx6P2GNsTap+WDu/zBNMzyFq9MP+nR8VHl7fLFbU9CShjK3+t14UZ4CZnvWj90s
         zW+z/Ypa2ZTLhQyrG9knc8VAoBkooy+jMhdx2xteuGxttwoBwLavOeRjpdlJjdVYN3zN
         nWZklnaZBwPP07NgdA6gViX1X+Vbk0DBw12lsGP+3+8n+Vyv73EyuIs94Ut+ufdjFtRW
         D/aw==
X-Gm-Message-State: AO0yUKUyPdVWREh6OgXt0XGA/Q97ezsNaIlLv0fW7oR7tLGR8jTH+3Cg
        4rTONZCC2kTMa5q3VQZ7+O7liYSO9iOAMsA+feEfjY2Bnls=
X-Google-Smtp-Source: AK7set8NS40VXuN70xIjVm1VwXgMzht/ocgM7Uk4J5e74PrEzGVtRX3fd/nshYTSDk6ECG8mlcAOas/Ocv+a7iUhLPA=
X-Received: by 2002:a2e:a4b4:0:b0:295:a5cd:3baf with SMTP id
 g20-20020a2ea4b4000000b00295a5cd3bafmr2881181ljm.9.1677491591035; Mon, 27 Feb
 2023 01:53:11 -0800 (PST)
MIME-Version: 1.0
References: <CA+cAkeoDrm-33JkuL6nQa7s7foqdCWvwt9Y9PZa5Qj58gATqtQ@mail.gmail.com>
In-Reply-To: <CA+cAkeoDrm-33JkuL6nQa7s7foqdCWvwt9Y9PZa5Qj58gATqtQ@mail.gmail.com>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Mon, 27 Feb 2023 10:52:59 +0100
Message-ID: <CA+cAkeq+z8D3j7FQFrW4BxfS97a490B_U3yskYm8+oatYfxZAg@mail.gmail.com>
Subject: Re: Kernel lock during cryptsetup luksClose
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello, I manage to have more information about the issue by the use of
strace, the blocking call is an ioctl on /dev/mapper/control:

write(1, "# dm versions   [ opencount flus"..., 51# dm versions   [
opencount flush ]   [16384] (*1)) = 51
ioctl(3, DM_LIST_VERSIONS, {version=4.1.0, data_size=16384,
data_start=312, flags=DM_EXISTS_FLAG} => {version=4.39.0,
data_size=431, data_start=312, flags=DM_EXISTS_FLAG, ...}) = 0
write(1, "# dm remove luksDeviceTest  [ op"..., 75# dm remove
luksDeviceTest  [ opencount flush retryremove ]   [16384] (*1)) = 75
ioctl(3, DM_DEV_REMOVE, {version=4.0.0, data_size=16384,
name="luksDeviceTest", event_nr=4194304, flags=DM_EXISTS_FLAGS}

to be compare to the same call without
7fcfa8b616d360ab9ea1da94c2200f0708e0188b commit:

ioctl(3, DM_LIST_VERSIONS, {version=4.1.0, data_size=16384,
data_start=312, flags=DM_EXISTS_FLAG} => {version=4.39.0,
data_size=431, data_start=312, flags=DM_EXISTS_FLAG, ...}) = 0
write(1, "# dm remove luksDeviceTest  [ op"..., 75# dm remove
luksDeviceTest  [ opencount flush retryremove ]   [16384] (*1)) = 75
ioctl(3, DM_DEV_REMOVE, {version=4.0.0, data_size=16384,
name="luksDeviceTest", event_nr=4194304, flags=DM_EXISTS_FLAG} =>
{version=4.39.0, data_size=305, name="luksDeviceTest",
uuid="CRYPT-LUKS1-25edf7523ab4454590a7e2ac83050582-luksDeviceTest",
flags=DM_EXISTS_FLAG|DM_UEVENT_GENERATED_FLAG}) = 0
write(1, "# luksDeviceTest: Stacking NODE_"..., 36# luksDeviceTest:
Stacking NODE_DEL) = 36
write(1, "# luksDeviceTest: Processing NOD"..., 38# luksDeviceTest:
Processing NODE_DEL) = 38

The matching code line which block is
https://github.com/lvmteam/lvm2/blob/v2_03_06/libdm/ioctl/libdm-iface.c#L1890

I don't know how to go deeper to understand why preempt-rt is blocking
of this, any ideas ?
Another question is about the impact of reverting commit
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.19-rt&id=7fcfa8b616d360ab9ea1da94c2200f0708e0188b
, what are the risk of doing that ?
