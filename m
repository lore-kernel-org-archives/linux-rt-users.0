From: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Sat, 16 May 2015 12:08:53 +0530
Message-ID: <CAPyr0yL8xJt4bj7poLFrauR0wtfKB7nPg+uy4A+R0dTT-eM3Qw@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
	<20150506193803.GC32577@8074w.roxell.se>
	<CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
	<20150508000929.GE31914@8074w.roxell.se>
	<CAPyr0yLq7PsMW45G+oJzJLbQ-be6Xx9n2S2SU2CiV+AMH9jJ8Q@mail.gmail.com>
	<20150514160733.GE13442@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anders Roxell <anders.roxell@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36409 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbEPGiy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 May 2015 02:38:54 -0400
Received: by qcir1 with SMTP id r1so1377477qci.3
        for <linux-rt-users@vger.kernel.org>; Fri, 15 May 2015 23:38:53 -0700 (PDT)
In-Reply-To: <20150514160733.GE13442@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Yes. Due to preemt_disable and preempt_enable is causing the delay.

As cyclic log is really big , i will be sending it to you separately.

After this fix , cyclic test is completed succesfully.

On Thu, May 14, 2015 at 9:37 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Ayyappa Ch | 2015-05-11 11:02:56 [+0530]:
>
>>Hello Anders Roxell,
>>
>>Many thanks for your inputs.
>>
>>But as per my observation after this change , Cyclic test did not failed.
>>
>>As logs are huge size , sent only to you.
>>
>>Can you please check the logs and let us know your view ?
>
> fpsimd_save_state() is almost the fpsimd_save macro which saves 32
> 16byte registers. And *this* takes really that long? You max says 100116
> which means 100ms.
>
>>Thanks and regards,
>>Ayyappa.Ch
>
> Sebastian
