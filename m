Return-Path: <SRS0=a459=VB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F028C0651F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3408218A3
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGDRFX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:05:23 -0400
Received: from mail.windriver.com ([147.11.1.11]:39488 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGDRFX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jul 2019 13:05:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x64H54fR023073
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 4 Jul 2019 10:05:05 -0700 (PDT)
Received: from [128.224.20.235] (128.224.20.235) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul
 2019 10:05:04 -0700
Subject: Re: weird issue with CentOS RT kernel, hangs hard under particular
 load.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>
References: <c9786841-df3c-b022-3f94-5973f97086aa@windriver.com>
 <20190703112116.bnahv3wno7o475zt@linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <86245afa-736f-768b-4abf-5335401fc99e@windriver.com>
Date:   Thu, 4 Jul 2019 11:05:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703112116.bnahv3wno7o475zt@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.20.235]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/3/2019 5:21 AM, Sebastian Andrzej Siewior wrote:
> On 2019-06-28 13:35:51 [-0600], Chris Friesen wrote:
>> Hi all,
> Hi,
> 
>> Not sure who I should be talking to about this, but we're hitting a weird
>> issue with kernel-rt-3.10.0-957.12.2.rt56.929.el7.src.rpm from CentOS.
> 
> 3.10-rt56 is terribly old and unsupported [0].

Unfortunately I'm stuck with CentOS kernels in the near term.

>> Anyone got any suggestions on where to start debugging it?  Kernel options
>> to enable, extra debug logging, events to monitor?
> 
> You could try to enable MM debugging, lock debugging and so on.

Thanks...I've enabled CONFIG_PROVE_LOCKING, hard/soft watchdog, and 
netconsole.  Hopefully I'll get something. :)

Chris
