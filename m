From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
Date: Mon, 18 May 2015 09:18:26 +0200
Message-ID: <55599242.4020803@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org> <1430167990-12333-4-git-send-email-anders.roxell@linaro.org> <20150514155723.GD13442@linutronix.de> <20150515120810.GA10988@8074w.roxell.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: ayyappa.ch.linux@gmail.com, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47546 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbERHS2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 May 2015 03:18:28 -0400
In-Reply-To: <20150515120810.GA10988@8074w.roxell.se>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/15/2015 02:08 PM, Anders Roxell wrote:
> On 2015-05-14 17:57, Sebastian Andrzej Siewior wrote:
>> * Anders Roxell | 2015-04-27 22:53:10 [+0200]:
>>
>>> arm64 is missing support for PREEMPT_RT. The main feature which is
>>> lacking is support for lazy preemption. The arch-specific entry code,
>>
>> I'm taking this but I am renaming the subject. Lazy preempt is not
>> required by -RT but supporting it benefits it. That means you could run
>> arm64 without it.
> 
> Thanks for picking up the patch and fixing the subject,
> though I was surprised to see the ownership changed.

Oh. The ownership ship changed only in #3 by mistake. I will fix it,
sorry for that.

> Cheers,
> Anders

Sebastian
