Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE80C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3521773
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfC1KS3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:18:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1KS3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 06:18:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9S79-0001yv-6d; Thu, 28 Mar 2019 11:18:27 +0100
Date:   Thu, 28 Mar 2019 11:18:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Budiman JoJo <budimanjojo@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [BUG] /sys/firmware/efi/efivars: unknown filesystem type
 'efivars'
Message-ID: <20190328101826.lzsfhx43axctvvsd@linutronix.de>
References: <CACvxoyrqeP4=k43hf-vr2-SnGR4gW8e0UdsyMCQrAQPra5XRjg@mail.gmail.com>
 <20190328083224.2ilcupnxfsal4274@linutronix.de>
 <6aab9751-2bd8-f6ec-7b56-8d3139a7d71f@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aab9751-2bd8-f6ec-7b56-8d3139a7d71f@manjaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-28 10:16:50 [+0100], Bernhard Landauer wrote:
> For me this does get rid of the boot error message. +1

please don't top post and what boot error message?

Sebastian
