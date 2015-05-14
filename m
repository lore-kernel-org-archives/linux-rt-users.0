From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
Date: Thu, 14 May 2015 10:19:18 -0700
Message-ID: <CAMAWPa-G81bUNr5q1a0tpE3LswU2b0KBi4HagL_g0dG-Je0Z5g@mail.gmail.com>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
	<1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
	<20150514153937.GB13442@linutronix.de>
	<20150514154215.GE18984@arm.com>
	<CAMAWPa_UA3GgHGkcYkgUJUB8Y6KJS38z-2-=E6PKmGT=tGWh3A@mail.gmail.com>
	<20150514171056.GH18984@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Hilman <khilman@kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	"ayyappa.ch.linux@gmail.com" <ayyappa.ch.linux@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kevin.hilman@linaro.org" <kevin.hilman@linaro.org>
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51414 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161020AbbENRTW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 13:19:22 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 931B220499
	for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 17:19:21 +0000 (UTC)
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com [209.85.212.172])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1520B20460
	for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 17:19:20 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so25280161wic.0
        for <linux-rt-users@vger.kernel.org>; Thu, 14 May 2015 10:19:18 -0700 (PDT)
In-Reply-To: <20150514171056.GH18984@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 14, 2015 at 10:10 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, May 14, 2015 at 06:09:23PM +0100, Kevin Hilman wrote:

[...]

>> Which tree is at applied to?  I'm not seeing it in -next, and couldn't
>> find it in any branches of the arm64 tree[1].  Sorry to pester, I'm
>> just looking to cherry-pick it from it's proper upstream for testing
>> with a stable/3.18 based kernel.
>
> I don't think Catalin has started putting together our for-next/core branch
> yet, but I'd expect it to appear there when he picks it up.

Cool, thanks.

Kevin
