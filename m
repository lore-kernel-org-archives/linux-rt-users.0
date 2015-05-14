From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
Date: Thu, 14 May 2015 10:09:23 -0700
Message-ID: <CAMAWPa_UA3GgHGkcYkgUJUB8Y6KJS38z-2-=E6PKmGT=tGWh3A@mail.gmail.com>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
	<1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
	<20150514153937.GB13442@linutronix.de>
	<20150514154215.GE18984@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	"ayyappa.ch.linux@gmail.com" <ayyappa.ch.linux@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kevin.hilman@linaro.org" <kevin.hilman@linaro.org>
To: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50413 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbbENRJa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 13:09:30 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 973FB20497
	for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 17:09:28 +0000 (UTC)
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com [209.85.212.171])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id CE4FC20451
	for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 17:09:24 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so19718295wic.0
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 10:09:23 -0700 (PDT)
In-Reply-To: <20150514154215.GE18984@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 14, 2015 at 8:42 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, May 14, 2015 at 04:39:37PM +0100, Sebastian Andrzej Siewior wrote:
>> * Anders Roxell | 2015-04-27 22:53:08 [+0200]:
>>
>> >Mark the PMU interrupts as non-threadable, as is the case with
>> >arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD
>> >
>> >Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Could this please go via the arm64 tree?
>
> I already acked it:
>
>   https://lkml.org/lkml/2015/4/23/161
>
> so it will be picked up for 4.2.

Which tree is at applied to?  I'm not seeing it in -next, and couldn't
find it in any branches of the arm64 tree[1].  Sorry to pester, I'm
just looking to cherry-pick it from it's proper upstream for testing
with a stable/3.18 based kernel.

Thanks,

Kevin

[1] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/
