From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 3/3] arch/arm64: Enable PREEMPT_RT_FULL
Date: Thu, 14 May 2015 17:57:23 +0200
Message-ID: <20150514155723.GD13442@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ayyappa.ch.linux@gmail.com, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38070 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161051AbbENP5Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 11:57:24 -0400
Content-Disposition: inline
In-Reply-To: <1430167990-12333-4-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2015-04-27 22:53:10 [+0200]:

>arm64 is missing support for PREEMPT_RT. The main feature which is
>lacking is support for lazy preemption. The arch-specific entry code,

I'm taking this but I am renaming the subject. Lazy preempt is not
required by -RT but supporting it benefits it. That means you could run
arm64 without it.

Sebastian
