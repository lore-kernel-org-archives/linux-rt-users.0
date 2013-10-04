From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] slab+rt: Don't free locks twice in cpuup_canceled
Date: Fri, 04 Oct 2013 11:10:39 -0500
Message-ID: <524EE87F.9020906@mvista.com>
References: <1379700149-16400-1-git-send-email-minyard@acm.org> <52431132.9070209@caviumnetworks.com> <20131004144936.GI19953@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Corey Minyard <cminyard@caviumnetworks.com>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54562 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab3JDQKm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 12:10:42 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so4227388oag.11
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Oct 2013 09:10:42 -0700 (PDT)
In-Reply-To: <20131004144936.GI19953@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 09:49 AM, Sebastian Andrzej Siewior wrote:
> * Corey Minyard | 2013-09-25 11:37:06 [-0500]:
>
>> I forgot to mention that this was on 3.10.10-rt7.
> This looks valid. But SLAB still isn't working on -RT, right?
>
AFAIK SLAB is still not working on RT, but this breaks things if you
have RT disabled.

-corey
