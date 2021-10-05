Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F8CC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494B861039
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhJEKDd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:03:33 -0400
Received: from thoth.sbs.de ([192.35.17.2]:32908 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhJEKDQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Oct 2021 06:03:16 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 195A14R7007095
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 12:01:04 +0200
Received: from [167.87.39.245] ([167.87.39.245])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 195A12sX020396;
        Tue, 5 Oct 2021 12:01:04 +0200
Subject: Re: arm64: kvm + RT
To:     Marc Zyngier <maz@kernel.org>
References: <87h7dvg5mz.ffs@tglx>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4653e6b3-e038-6350-d07b-496ba53bc80b@siemens.com>
Date:   Tue, 5 Oct 2021 12:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87h7dvg5mz.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05.10.21 11:52, Thomas Gleixner wrote:
> Jan,
> 
> On Mon, Oct 04 2021 at 19:54, Jan Kiszka wrote:
>> what's the state of getting kvm working (again?) along RT? Seems
>> HAVE_POSIX_CPU_TIMERS_TASK_WORK is in conflict with KVM but a
>> precondition for RT on recent kernels. What's the story behind that?
> 
> the ARM64 KVM implementation is incorrect vs. TIF handling before
> VMENTER which breaks the posix cpu timers task work assumptions and also
> violates a few other expectations. AFAICT the arm64 folks are working on
> that, but you have to ask them directly what the state of this is.
> 

Thanks, then let's try this: Marc, what is the status of this?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
