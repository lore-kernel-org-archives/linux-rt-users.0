Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C0C61DA4
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Feb 2023 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjBWPDa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 10:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjBWPD1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Feb 2023 10:03:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C483DA
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Feb 2023 07:03:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e24so4855759ljj.3
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Feb 2023 07:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrX+Yxs54zjSMzfv2R4YjLMHZycc3fF+VfLE7hZvGMY=;
        b=BwjEOgwnArEQ+aFCiDIKDQs533PAqDw8g3bsrtPejeQ/YzW17kMi0BqT5zUrRSCUb4
         aGILeCz/Qu1RX7mTdRS6IxaQ/CY5bKsjHoil6NNsXBZ2zAXT3ZCSTDfSjNehfDNXgmrS
         z2GIckcVXoKAbPWtsLBE81gPe1cWRgwnvBHWj5PiZaYxiE9n1RZ6m9ueBXLmTHntMd4N
         dh7OPy498Q1rTPdaNTpDJg5nohv6tdFail9jAMkgA9n1jzRRAb2rySDmABLkvZ2KcFoP
         69JOOTANXA0hU0cQk4+J6fxtVzBOgk1ur9CKhoZHVu4xr1zdEryIpl7TdCIrQbPs+HX+
         mu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrX+Yxs54zjSMzfv2R4YjLMHZycc3fF+VfLE7hZvGMY=;
        b=pNE+m74vOoVL/8brgDGDQM0UaTrkHu1wKch8s2aBBDcHAH+BuCf9Vj/JpPxNvvzSg6
         tWwVTjByv7+9sgPB6s9sooaudyWwIlyynyouOGLWXvXadeCfP35kcYzoYlTM50o2qVhg
         SQSgTytshNAWOlG21RviXVm4qtNpAIsEy6L2u6qY4cE1iEzDrmBTS4iz2EMXsaLXIOF4
         RIYVm3kP14hqkb7qzI/V42hEEK7mskLOllhi9va5AmpUMvU3Utszo9by+IEkvo9FDv0h
         9tQl556onZZjehmU3rf80W4IwfHTch/m/3ooiVmpKzca/VCm3CkTWlmeDTu/8VLlCuFV
         qVpA==
X-Gm-Message-State: AO0yUKXn8uzigKlb5/PgxpS9ck2Hzhw7ocBEfFOMGqqHDdwTc0seHYRW
        hgIomyXKYZV2IZqFFnN9FD5aSCFht1F/0080RHsVTuQvtzM=
X-Google-Smtp-Source: AK7set+2mnR9SkBONC0wSJ6v8S8U9MSCnbb57rp7DPawkWYzOwpJAdl8ZzcZ7IjOMb3VrSV+jd+MLvWLGms72mTBys4=
X-Received: by 2002:a05:651c:b9b:b0:295:9dc0:f204 with SMTP id
 bg27-20020a05651c0b9b00b002959dc0f204mr776388ljb.9.1677164603638; Thu, 23 Feb
 2023 07:03:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Thu, 23 Feb 2023 16:03:12 +0100
Message-ID: <CA+cAkeoDrm-33JkuL6nQa7s7foqdCWvwt9Y9PZa5Qj58gATqtQ@mail.gmail.com>
Subject: Kernel lock during cryptsetup luksClose
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Subject: Kernel lock during cryptsetup luksClose

Hello,

I recently upgraded my system (Marvell Armada-3720) from linux 4.19.255-rt113 to
linux 4.19.271-rt120 and experienced a blocking issue with cryptsetup.

My sequence is roughly the following:
  - Boot an initramfs from PXE
  - Get back a ciphered image from a local HTTP server
  - Get back the ciphering key of this image (which is itself ciphered)
  - Decipher the key it via a TPM chip
  - Decipher the image via cryptsetup luksOpen
  - Partition the storage and install the image on it
  - Cleanup operation

The blocking I see is when I close the LUKS encrypted volume via
cryptsetup luksClose.
I manage to have some more traces of cryptsetup luksClose by adding
--debug to it.
Below is the correct sequence  in 4.19.255-rt113:

# cryptsetup 2.3.7 processing "cryptsetup --verbose --debug luksClose image"
# Running command close.
# Locking memory.
# Installing SIGINT/SIGTERM handler.
# Unblocking interruption on signal.
# Allocating crypt device context by device image.
# Initialising device-mapper backend library.
# dm version   [ opencount flush ]   [16384] (*1)
# dm versions   [ opencount flush ]   [16384] (*1)
# Detected dm-ioctl version 4.39.0.
# Detected dm-crypt version 1.18.1.
# Udev is not running. Not using udev synchronisation code.
# Device-mapper backend running with UDEV support disabled.
# dm status image  [ opencount noflush ]   [16384] (*1)
# Releasing device-mapper backend.
# Trying to open and read device /dev/loop0 with direct-io.
# Allocating context for crypt device /dev/loop0.
# Trying to open and read device /dev/loop0 with direct-io.
# Initialising device-mapper backend library.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm table image  [ opencount flush securedata ]   [16384] (*1)
# Trying to open and read device /dev/loop0 with direct-io.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm deps image  [ opencount flush ]   [16384] (*1)
# Crypto backend (OpenSSL 1.1.1s  1 Nov 2022) initialized in
cryptsetup library version 2.3.7.
# Detected kernel Linux 4.19.255-rt113-sigfox aarch64.
# PBKDF pbkdf2-sha256, time_ms 2000 (iterations 0).
# Reading LUKS header of size 1024 from device /dev/loop0
# Key length 32, device size 179761 sectors, header size 2050 sectors.
# Deactivating volume image.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm status image  [ opencount noflush ]   [16384] (*1)
# dm versions   [ opencount flush ]   [16384] (*1)
# dm table image  [ opencount flush securedata ]   [16384] (*1)
# Trying to open and read device /dev/loop0 with direct-io.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm remove image  [ opencount flush retryremove ]   [16384] (*1)
# image: Stacking NODE_DEL
# image: Processing NODE_DEL
# Removed /dev/mapper/image
# Releasing crypt device /dev/loop0 context.
# Releasing device-mapper backend.
# Closing read only fd for /dev/loop0.
# Unlocking memory.
Command successful.

And with 4.19.271-rt120:
# cryptsetup 2.3.7 processing "cryptsetup --verbose --debug luksClose image"
# Running command close.
# Locking memory.
# Installing SIGINT/SIGTERM handler.
# Unblocking interruption on signal.
# Allocating crypt device context by device image.
# Initialising device-mapper backend library.
# dm version   [ opencount flush ]   [16384] (*1)
# dm versions   [ opencount flush ]   [16384] (*1)
# Detected dm-ioctl version 4.39.0.
# Detected dm-crypt version 1.18.1.
# Udev is not running. Not using udev synchronisation code.
# Device-mapper backend running with UDEV support disabled.
# dm status image  [ opencount noflush ]   [16384] (*1)
# Releasing device-mapper backend.
# Trying to open and read device /dev/loop0 with direct-io.
# Allocating context for crypt device /dev/loop0.
# Trying to open and read device /dev/loop0 with direct-io.
# Initialising device-mapper backend library.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm table image  [ opencount flush securedata ]   [16384] (*1)
# Trying to open and read device /dev/loop0 with direct-io.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm deps image  [ opencount flush ]   [16384] (*1)
# Crypto backend (OpenSSL 1.1.1s  1 Nov 2022) initialized in
cryptsetup library version 2.3.7.
# Detected kernel Linux 4.19.271-rt120-sigfox aarch64.
# PBKDF pbkdf2-sha256, time_ms 2000 (iterations 0).
# Reading LUKS header of size 1024 from device /dev/loop0
# Key length 32, device size 179761 sectors, header size 2050 sectors.
# Deactivating volume image.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm status image  [ opencount noflush ]   [16384] (*1)
# dm versions   [ opencount flush ]   [16384] (*1)
# dm table image  [ opencount flush securedata ]   [16384] (*1)
# Trying to open and read device /dev/loop0 with direct-io.
# dm versions   [ opencount flush ]   [16384] (*1)
# dm remove image  [ opencount flush retryremove ]   [16384] (*1)


After that line the system is completely blocked.

I perform some dichotomy and found that the problematic commit is:
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.19-rt&id=7fcfa8b616d360ab9ea1da94c2200f0708e0188b
introduced in 4.19.255-rt114. Revert this commit on 4.19.271-rt220 makes
the blocking disappear.

I put the kernel max verbosity (logleve=8 ignore_loglevel for command
line parameters)
but I didn't see any kernel traces during this sequence (I have a lot of log
before loading the initramfs but as soon as it is loaded, it seems the kernel
became quiet).
I'll post a follow up if I manage to have more traces.

Does anyone know what could happen ?

I have a reproducible setup and can test several things if someone
tells me what to look at.

Thanks in advance for any insights you could give.
