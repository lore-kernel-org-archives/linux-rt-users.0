Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2582C31E4B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 19:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8341A20866
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFNTgT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:36:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39282 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNTgS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 15:36:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hbrzk-0001nd-LO; Fri, 14 Jun 2019 21:36:16 +0200
Date:   Fri, 14 Jun 2019 21:36:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alec Ari <neotheuser@gmail.com>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
Message-ID: <20190614193616.22w6gc56kobs2eaz@linutronix.de>
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
 <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com>
 <CAM5Ud7O2OtDLdJPArAAfw7A1xBm89dBSXk64vYsb-KY9N5RXUw@mail.gmail.com>
 <CAM5Ud7MTfpyv4ajVkuoe+_pjvq0t1ZWAGUUukrDK+xf5Rx0qiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM5Ud7MTfpyv4ajVkuoe+_pjvq0t1ZWAGUUukrDK+xf5Rx0qiQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-12 12:01:46 [-0500], Alec Ari wrote:
> EFI Stub is working now, thanks again. Latency isn't affected by EFI
> on this particular board (ASUS TUF B450M-Plus Gaming) with Ryzen 2200G
> and BIOS version 1003 (dated 2019/04/30 -- Latest as of this writing.)

Did you try to modify EFI variables?

> Alec

Sebastian
