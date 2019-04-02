Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F06C4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C8207E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 13:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfDBNXs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:23:48 -0400
Received: from foss.arm.com ([217.140.101.70]:51212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfDBNXs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 09:23:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A995C16A3;
        Tue,  2 Apr 2019 06:23:47 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32CA03F690;
        Tue,  2 Apr 2019 06:23:47 -0700 (PDT)
Subject: Re: EFI and RT incompatible?
To:     Mart van de Wege <mvdwege@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
References: <20190402103822.31608037@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <23d961a6-b9a2-a4de-a754-b08f668f21fb@arm.com>
Date:   Tue, 2 Apr 2019 14:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402103822.31608037@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 02/04/2019 09:38, Mart van de Wege wrote:
> Hi,

Hello Mart,

> 
> I compiled 5.0.5-rt3 last week, and after rebooting I found that
> efivarfs failed to mount. Loading the efivarfs module gave me
> a 'device not found' error.
> 
> Rebooting into 5.0.0 (no rt) and efivarfs automounted as usual.
> 
> Trouble is, I have no experience with bisecting between two different
> branches, so I have no clue on how to start debugging this. Anybody
> want to throw me some pointers?

Linux-rt is disabling EFI runtime by default because it may increase the latency 
of the system (see [1] for more details).

You can override the behavior by adding "efi=runtime" on your kernel command line.

Cheers,

[1] https://marc.info/?l=linux-rt-users&m=155379809327926&w=2

> 
> Mart
> 

-- 
Julien Grall
