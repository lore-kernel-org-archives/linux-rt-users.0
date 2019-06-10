Return-Path: <SRS0=SGFR=UJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC827C4321A
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA24D2086A
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 23:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbfFJXhH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390524AbfFJXhH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jun 2019 19:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 483E586658;
        Mon, 10 Jun 2019 23:37:07 +0000 (UTC)
Received: from ovpn-116-61.phx2.redhat.com (ovpn-116-61.phx2.redhat.com [10.3.116.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC62B1001B03;
        Mon, 10 Jun 2019 23:37:06 +0000 (UTC)
Message-ID: <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
From:   Scott Wood <swood@redhat.com>
To:     Alec Ari <neotheuser@gmail.com>, linux-rt-users@vger.kernel.org
Date:   Mon, 10 Jun 2019 18:37:06 -0500
In-Reply-To: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 10 Jun 2019 23:37:07 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-06-10 at 15:46 -0500, Alec Ari wrote:
> Hi,
> 
> I'm running Debian on a test system, CSM has been disabled. if I boot
> the stock non-RT Debian kernel, I can use efibootmgr. When I try
> booting the PREEMPT_RT package (linux-image-rt-amd64) or a custom
> PREEMPT_RT kernel with the following config options enabled:

It's disabled by default on PREEMPT_RT due to latency concerns.  You can
override it with "efi=runtime" on the kernel command line.

-Scott


