Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD41C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 May 2022 23:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiEEXYP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 May 2022 19:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiEEXYL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 May 2022 19:24:11 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF02613C;
        Thu,  5 May 2022 16:20:29 -0700 (PDT)
Received: from [192.168.1.31] (097-089-247-249.biz.spectrum.com [97.89.247.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7FDD54107B;
        Thu,  5 May 2022 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651792827;
        bh=tM2bqpnWq3TURhjdPEpDnGm/7GFfCQ3VVx3FiW0azaQ=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=BZXX+xcSVCcCi8Gw4Dt9LNRoddJZ/j7pP5Zb45OhdkcMm9WSBwjK2GykoFXiWHZFY
         O8qMD0q1+19AfnMLm7CrKzOWORZWYr08AJLca59mImPxSYqKcc0SqN8fRrun76fCcF
         CbBmYXIar0RAsNSQCs6P9+tkfBnWE8lUtmTZd5P4gjOksV7qrt8pOkR7FVos3Y2NKH
         HocBMy7VVnJacqouyOyiUShkWTDtMMmBDHMKZo+Cnd060EM38pZB0Ij0AcRHIIIVpR
         Bijd9ZfVZHAtyTq/cA10tbWsnu34vbs9Mq8/DQ3uPwVpE9RHSjnu4iVbPeOdZcogpk
         /OZ+D9hFMoh0w==
Message-ID: <35c5a001-61b0-09d7-393c-b46836d0b676@canonical.com>
Date:   Thu, 5 May 2022 19:20:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Issue With real-time patches on 5.15.y
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
References: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
In-Reply-To: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/5/22 19:18, Joseph Salisbury wrote:
> Hello,
>
> I ran into a build failure after applying the rt40 real-time 
> patches[0] to an Ubuntu 22.04 kernel. The Ubuntu kernel is based on 
> upstream stable 5.15.y(5.15.34 currently).  I believe this patch is 
> the specific one that introduces the build issue: 
> 0086-locking-Allow-to-include-asm-spinlock_types.h-from-l.patch.
>
> After a bisect, the following commit was identified as the cause for 
> the build failure:
> b50854eca0e0 ("x86/pkru: Remove useless include")
>
> This commit was added to mainline as of 5.16-rc1 and not Cc'd to 
> stable, so it should not exist in 5.15.y.  However, it was purposely 
> added to the Ubuntu kernel to enable x86 AMX support[1].
>
> The real-time kernel build failure can be resolved by reverting commit 
> b50854eca0e0.  The failure seems to be due to the removal of an 
> include of xstate.h from pkru.h and caused spinlock_t to not be 
> defined.  The commit would only be reverted for the real-time kernel 
> and not any other kernels.  I wanted to see if reverting the commit is 
> the proper approach, or if cherry-picking additional commits might be 
> a better solution in preparation for additional changes that might be 
> coming in the future?
>
> Any suggestions would be greatly appreciated.
>
> Thanks,
>
> Joe
>
>
> [0] 
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15.34-rt40.tar.gz
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1967750
Also, the following is the build failure that happens:
arch/x86/include/asm/pgtable.h:55:8: error: unknown type name 'spinlock_t'
    55 | extern spinlock_t pgd_lock;
       |        ^~~~~~~~~~
