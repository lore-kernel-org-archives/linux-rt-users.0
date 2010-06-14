From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 15:14:46 +0530
Message-ID: <AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Maksym Parkachov <lazy.gopher@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54539 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0FNJvd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 05:51:33 -0400
Received: by vws14 with SMTP id 14so443494vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 02:51:33 -0700 (PDT)
In-Reply-To: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> CONFIG_PREEMPT_RCU=y
> # CONFIG_PREEMPT_RCU_TRACE is not set

Why is RCU being set to y?

> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT_DESKTOP is not set

Fine.

> CONFIG_PREEMPT_RT=y

This is correct.

> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y

I think this part is susceptible.

Thanks,
Sujit
