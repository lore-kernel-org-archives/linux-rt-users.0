Return-Path: <SRS0=v45L=ZO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86703C432C0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Nov 2019 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5114620658
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Nov 2019 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKVTjm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:39:42 -0500
Received: from mail.softplc.com ([206.126.248.66]:16459 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfKVTjl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Nov 2019 14:39:41 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Fri, 22 Nov 2019 14:39:40 -0500
  id 00000000001E0008.000000005DD8397C.00007F3B
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Dick Hollenbeck <dick@softplc.com>
Subject: wait_event_interruptible_timeout() not sleeping accurately
Message-ID: <d2127c27-f53d-8b0c-5a44-6bdd6edd2204@softplc.com>
Date:   Fri, 22 Nov 2019 13:39:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


In a user thread I block on wait_event_interruptible_timeout() for about 3300 usecs or
until my threaded interrupt handler calls wake_up_interruptible() when the hardware event
happens.

This seems to work fine for the case when the event actually happens.  But for the timeout
case, the function wait_event_interruptible_timeout() is sleeping 9000 usecs or so rather
than 3300 usecs as requested.  I confirmed this by toggling a GPIO pin before and after
the call and feeding that signal to a logic analyzer.

The user thread is RT round robin at about a priority 5.

Am I doing something disallowed under PREEMPT_RT?
What could be the reason for the inaccurate wait_event_interruptible_timeout() timeout?


			ret = wait_event_interruptible_timeout(bh->rx_waitq,
				bh->rx_intr_flag,
				usecs_to_jiffies(aTimeoutUSecs) );

