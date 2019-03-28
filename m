Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD6FC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F2221773
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 08:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfC1Ic1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:32:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfC1Ic1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 04:32:27 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9QSW-0005gw-QO; Thu, 28 Mar 2019 09:32:24 +0100
Date:   Thu, 28 Mar 2019 09:32:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Budiman JoJo <budimanjojo@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [BUG] /sys/firmware/efi/efivars: unknown filesystem type
 'efivars'
Message-ID: <20190328083224.2ilcupnxfsal4274@linutronix.de>
References: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-22 23:01:07 [+0700], Budiman JoJo wrote:
> Hello, I get this error message on boot only with Linux-rt kernels:
> /sys/firmware/efi/efivars: unknown filesystem type 'efivars'
> I'm on UEFI System but Linux-rt can't seem to mount the efivarfs
> properly, resulting in my system booting into BIOS mode instead of
> UEFI mode. Tried setting both CONFIG_EFI_VARS=y or # CONFIG_EFI_VARS
> is not set. When I switch to regular kernel, then the error message is
> gone and I can list the files in my /sys/firmware/efi/efivars. I'm
> using Manjaro Linux.
> Tested on linux-4.18-rt, linux-4.19-rt, linux 5.0-rt Thank you.

Does it work if you add
	efi=runtime

to the commandline?

Sebastian
