Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0EC4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Dec 2022 23:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLOXjw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Dec 2022 18:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOXju (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2022 18:39:50 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD662E82
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2022 15:39:48 -0800 (PST)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E4D144358C;
        Thu, 15 Dec 2022 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671147587;
        bh=Wheych2o/I85u2dPTjJcgp+ZFDcm+ebFupNQQWN85Rg=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=OeG330RoZEpH9laBJ1RGIXXbE5W0FWSBdp5aszKNBX3hZkRvcVLazVroqPa6Vyb87
         lMDXPj/LAl4mUN/htngYJNVs5n90IdMg5H6jJ8OIh9NYyTBjykin/AZOU5dao2QRQJ
         hZTnqyvCLFAvNkQpNt4iy05n+IEmSZLr1TMTbyRmakcXPVM979QTqhn2iLKNoyZEUH
         iustxwk/pxv7E96zW0FiBX6DzRsEcvZNGkiFu6cpxNeGkgvu5Rna5PckFxcln0QTHB
         OicapNCz808jGTlDrWkweFSbHGWVEGGayAkzjCGtO3UpRs8nyFbcvdrscVU25hyS+k
         wwaa0eEKH2mSA==
Message-ID: <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
Date:   Thu, 15 Dec 2022 18:39:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
In-Reply-To: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 12/15/22 13:39, Joseph Salisbury wrote:
> Hello,
>
> A bug has been reported[0] against a linux-5.15.y based Ubuntu kernel 
> that has the 5.15.79-rt54 real-time patch set applied.
>
> This bug is causing a system hang when running disk tests with the 
> stress-ng[1] test suite.  A 'hung task' call trace is being 
> generated[2] just prior to the system hanging.  It appears the hang is 
> happening during a call to schedule.
>
> To see if this was a regression, I also tested prior real-time patch 
> sets, going as far back to rt38 and all versions exhibit this bug. I 
> will test back further to see if this is in fact a regression and a 
> kernel bisect can be done.  I also confirmed the same kernel without 
> the rt54 patch set applied does not exhibit this bug.
>
> I will continue to debug this issue, but I wanted to send this message 
> upstream in case anyone else runs into it.  Any specific tests, 
> tracing or debugging steps would be greatly appreciated. Otherwise, 
> I'll report back to this thread with any findings.
>
> Thanks,
>
> Joe
>
>
> [0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1998536
> [1] https://github.com/ColinIanKing/stress-ng
> [2] https://launchpadlibrarian.net/637058129/dmesg_dl110_rt_kernel.txt

I should have also mentioned, I will also test the latest available 
patch set (6.1-rc7-rt5) to see if it also exhibits the bug.


