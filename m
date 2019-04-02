Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1EC10F00
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E5820856
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfDBNtl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:49:41 -0400
Received: from vdwege.eu ([141.105.121.30]:40986 "EHLO vdwege.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBNtk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 09:49:40 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 09:49:39 EDT
Received: from lucan (82-197-216-99.dsl.cambrium.nl [82.197.216.99])
        by vdwege.eu (Postfix) with ESMTPSA id D380E2F6283;
        Tue,  2 Apr 2019 15:40:09 +0200 (CEST)
Message-ID: <901576dfe112a046ba6677696f3a30a3d8cfcb78.camel@vdwege.eu>
Subject: Re: EFI and RT incompatible?
From:   Mart van de Wege <mart@vdwege.eu>
To:     Julien Grall <julien.grall@arm.com>,
        Mart van de Wege <mvdwege@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Date:   Tue, 02 Apr 2019 15:40:07 +0200
In-Reply-To: <23d961a6-b9a2-a4de-a754-b08f668f21fb@arm.com>
References: <20190402103822.31608037@gmail.com>
         <23d961a6-b9a2-a4de-a754-b08f668f21fb@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-04-02 at 14:23 +0100, Julien Grall wrote:

> Linux-rt is disabling EFI runtime by default because it may increase
> the latency of the system (see [1] for more details).
> 
> You can override the behavior by adding "efi=runtime" on your kernel
> command line.
> 
Yeah, I saw the 22/3 thread too late. 

Thanks anyway,

Mart

