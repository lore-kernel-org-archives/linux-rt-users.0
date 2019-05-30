Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A7AC28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 02:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99AB24430
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfE3CTg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 May 2019 22:19:36 -0400
Received: from mail1.windriver.com ([147.11.146.13]:65219 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE3CTg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 May 2019 22:19:36 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x4U2JIjn006821
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 29 May 2019 19:19:19 -0700 (PDT)
Received: from [128.224.162.135] (128.224.162.135) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 29 May
 2019 19:19:18 -0700
Subject: Re: rt kernel break printf command's parent process
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
References: <205dd879-fedc-2edf-92b3-0bd8a3ee1870@windriver.com>
 <20190528143329.yxpzhu2ov5piiceb@linutronix.de>
 <20190528160440.nbrhmchexbz2jh5s@linutronix.de>
From:   ddu <dengke.du@windriver.com>
Message-ID: <41f5ed4e-5f96-1eeb-b71d-7172c19218d6@windriver.com>
Date:   Thu, 30 May 2019 10:19:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528160440.nbrhmchexbz2jh5s@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.135]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks, after I update to -rt9, this have been fixed.

//dengke

在 2019/5/29 上午12:04, Sebastian Andrzej Siewior 写道:
> On 2019-05-28 16:33:29 [+0200], To ddu wrote:
>> On 2019-05-27 17:47:04 [+0800], ddu wrote:
>>> Hi all
>> Hi,
>>
>>> I use yocto rt-kernel which rebase on rt kernel:
>>>
>>> http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/log/?h=v5.0/standard/preempt-rt/intel-x86
> That tree has -rt3. Please update to -rt9.
>
> Sebastian
>
