Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A935C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2F61008
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 07:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhHEH4T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:56:19 -0400
Received: from gateway20.websitewelcome.com ([192.185.63.14]:38853 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236977AbhHEH4S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 03:56:18 -0400
X-Greylist: delayed 1394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2021 03:56:18 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 1288E400D0D91
        for <linux-rt-users@vger.kernel.org>; Thu,  5 Aug 2021 02:16:21 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id BXs0mbDwa7sOiBXs0mB2NH; Thu, 05 Aug 2021 02:32:48 -0500
X-Authority-Reason: nr=8
Received: from host-95-239-202-226.retail.telecomitalia.it ([95.239.202.226]:38688 helo=x1.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mBXrz-004KWc-PN; Thu, 05 Aug 2021 02:32:47 -0500
Subject: Re: [ANNOUNCE] v5.14-rc4-rt5
To:     Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210804165017.nizmbj3m7hkqzqop@linutronix.de>
 <20210805063123.mj4rggncauziryv4@beryllium.lan>
 <20210805065351.c7eieltqihduwisr@beryllium.lan>
 <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
Message-ID: <07fff459-375b-38ef-ec4d-647beb268731@kernel.org>
Date:   Thu, 5 Aug 2021 09:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805070008.nvhzjp56lbx5uwk2@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.239.202.226
X-Source-L: No
X-Exim-ID: 1mBXrz-004KWc-PN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-239-202-226.retail.telecomitalia.it (x1.bristot.me) [95.239.202.226]:38688
X-Source-Auth: kernel@bristot.me
X-Email-Count: 5
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/5/21 9:00 AM, Daniel Wagner wrote:
> On Thu, Aug 05, 2021 at 08:53:53AM +0200, Daniel Wagner wrote:
>> On Thu, Aug 05, 2021 at 08:31:23AM +0200, Daniel Wagner wrote:
>>> Just a heads up. I get these build errors:
>>
>> I suppose this should be:
> 
> and while at it, there are two more compile errors. The first one is
> obvious, the second one is just guessing.
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index c05a33a2f865..41e3d63160a7 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1896,14 +1896,14 @@ static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
>                 if (locked >= 0) {
>                         /* Requeue succeeded. Set DONE or LOCKED */
>                         WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
> -                                    old != Q_REQUEUE_PI_WAIT)
> +                                    old != Q_REQUEUE_PI_WAIT);
>                         new = Q_REQUEUE_PI_DONE + locked;
>                 } else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
>                         /* Deadlock, no early wakeup interleave */
>                         new = Q_REQUEUE_PI_NONE;
>                 } else {
>                         /* Deadlock, early wakeup interleave. */
> -                       WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_WAIT);
> +                       WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
>                         new = Q_REQUEUE_PI_IGNORE;
>                 }
>         } while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
> 

same problems, same fixes here.

-- Daniel
