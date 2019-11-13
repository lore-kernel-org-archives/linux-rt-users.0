Return-Path: <SRS0=be3R=ZF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EEBC432C3
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED37206CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Nov 2019 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKMSCO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:02:14 -0500
Received: from mail.softplc.com ([206.126.248.66]:55933 "EHLO mail.softplc.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfKMSCO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Nov 2019 13:02:14 -0500
Received: from [192.100.100.3] ([::ffff:107.174.231.239])
  (AUTH: PLAIN dick@softplc.com, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mail.softplc.com with ESMTPSA; Wed, 13 Nov 2019 13:02:13 -0500
  id 00000000001E0003.000000005DCC4525.000075A7
Subject: Re: Need help building for aarch64 kernel 5.2
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
References: <a0a64a18-5805-de3b-c4f7-537de8fa0508@softplc.com>
 <CAD56B7cgt704nWrowch8KrcT7e6ASr5Hi9FQ8-xmgztYcdceyA@mail.gmail.com>
From:   Dick Hollenbeck <dick@softplc.com>
Message-ID: <adcdeaa2-69e0-9f61-35c9-888e2a281f37@softplc.com>
Date:   Wed, 13 Nov 2019 12:02:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7cgt704nWrowch8KrcT7e6ASr5Hi9FQ8-xmgztYcdceyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/12/19 2:33 PM, Paul Thomas wrote:
> I hope this helps. Good luck!
> 
> -Paul


[PATCH] needed

Hi Paul,

A+ for your help.  Thanks very much for your valuable time and excellent post.

The problem is two fold:

1) the configuration variable CONFIG_HOTPLUG_CPU controls the existence of the
*definition* of 'takedown_cpu_task' at kernel/cpu.c line 880.  (The *declaration* is in a
header file.) But there's a usage at kernel/sched/core.c line 7399 and following line
which is not conditioned on that same CONFIG_HOTPLUG_CPU config variable.

3) The linker message is misleading.  All they had to say was that the symbol was
undefined.  The continued detail about this being an offset out of range issue created
ambiguity as to whether this was out of range first and foremost, leading to the undefined
status.  Clearly now it is simply an undefined usage.

I am looking for a low latency transfer of control from a GPIO interrupt handler that I
wrote in one of my drivers, all the way to a high RT priority wait_queue blocked user
thread.  And stock (non-RT) 5.1 kernel was atrocious, simply unbelievably bad.  Somewhere
along the way during the great hunt for improvement I turned off CONFIG_HOTPLUG_CPU just
to try a simpler config.


BTW cyclictest on that same stock 5.1 kernel was showing an intermittent 4 msecs of delay.
 Yes msecs, not usecs.


I would have submitted a patch for this but since its so trivial, it seems somebody with
commit rights could make this change faster than applying a patch.


Thanks all,

Dick
