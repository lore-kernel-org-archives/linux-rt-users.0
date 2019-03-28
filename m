Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9EC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE82075E
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 09:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfC1JfD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:35:03 -0400
Received: from mail.manjaro.org ([176.9.38.148]:45800 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfC1JfD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 05:35:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 1E52230F393B;
        Thu, 28 Mar 2019 10:16:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vJ6bnZbYg3oG; Thu, 28 Mar 2019 10:16:51 +0100 (CET)
Subject: Re: [BUG] /sys/firmware/efi/efivars: unknown filesystem type
 'efivars'
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Budiman JoJo <budimanjojo@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
References: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
 <20190328083224.2ilcupnxfsal4274@linutronix.de>
From:   Bernhard Landauer <bernhard@manjaro.org>
Message-ID: <6aab9751-2bd8-f6ec-7b56-8d3139a7d71f@manjaro.org>
Date:   Thu, 28 Mar 2019 10:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190328083224.2ilcupnxfsal4274@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

For me this does get rid of the boot error message. +1

On 28.03.19 09:32, Sebastian Andrzej Siewior wrote:
> On 2019-03-22 23:01:07 [+0700], Budiman JoJo wrote:
>> Hello, I get this error message on boot only with Linux-rt kernels:
>> /sys/firmware/efi/efivars: unknown filesystem type 'efivars'
>> I'm on UEFI System but Linux-rt can't seem to mount the efivarfs
>> properly, resulting in my system booting into BIOS mode instead of
>> UEFI mode. Tried setting both CONFIG_EFI_VARS=y or # CONFIG_EFI_VARS
>> is not set. When I switch to regular kernel, then the error message is
>> gone and I can list the files in my /sys/firmware/efi/efivars. I'm
>> using Manjaro Linux.
>> Tested on linux-4.18-rt, linux-4.19-rt, linux 5.0-rt Thank you.
> Does it work if you add
> 	efi=runtime
>
> to the commandline?
>
> Sebastian
