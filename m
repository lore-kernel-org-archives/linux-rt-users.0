From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
Date: Fri, 15 May 2015 14:08:10 +0200
Message-ID: <20150515120810.GA10988@8074w.roxell.se>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
 <20150514155723.GD13442@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ayyappa.ch.linux@gmail.com, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36064 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325AbbEOMIP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 May 2015 08:08:15 -0400
Received: by lagv1 with SMTP id v1so116124536lag.3
        for <linux-rt-users@vger.kernel.org>; Fri, 15 May 2015 05:08:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150514155723.GD13442@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-05-14 17:57, Sebastian Andrzej Siewior wrote:
> * Anders Roxell | 2015-04-27 22:53:10 [+0200]:
> 
> >arm64 is missing support for PREEMPT_RT. The main feature which is
> >lacking is support for lazy preemption. The arch-specific entry code,
> 
> I'm taking this but I am renaming the subject. Lazy preempt is not
> required by -RT but supporting it benefits it. That means you could run
> arm64 without it.

Thanks for picking up the patch and fixing the subject,
though I was surprised to see the ownership changed.

Cheers,
Anders
