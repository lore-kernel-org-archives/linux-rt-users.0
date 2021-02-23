Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A7C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F08864E41
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBVX7v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 18:59:51 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9230 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhBVX7n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 18:59:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603445460006>; Mon, 22 Feb 2021 15:59:02 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Feb
 2021 23:59:01 +0000
Received: from [172.17.173.69] (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Feb 2021 23:59:01 +0000
Subject: Re: sync system call failure
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-rt-users@vger.kernel.org>
References: <6ed96c7e-aa40-e8d9-6330-85dc84514a81@nvidia.com>
 <20210222134115.pjeiszuskg5kk23n@linutronix.de>
From:   Dipen Patel <dipenp@nvidia.com>
Message-ID: <bb5de1c8-c94a-60b6-9773-f342228f6f9e@nvidia.com>
Date:   Mon, 22 Feb 2021 16:02:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222134115.pjeiszuskg5kk23n@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614038342; bh=kEoAjdO7qpwavYIfLaJfTPlhbNNcZE5GblrTH2KDyhA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ac2qclK8/K/23Yev9VtPKn/30zMJaJxmmygnp27ucE0HuQHaNHK4u5KN5ceXD0qPi
         Jzgx37oqE5N9M/H1MVuV3VzIXpJM6oJ0KcGbSPadzWje098VlQOhuc1vJU3WZfLAEA
         jDu0y6VnhF8dcclj7BUZyaIX/pO28T5D3heZ+ov+/GxnhkLvJBYFOD0xTriNyQryrH
         piiqCS6okV+tqd9UadWHl5gec9Ct7rQ7ftP6vn4GsAxyxRU7uJBWr5I2Psm1GUKlbt
         /c0krGsw4mE8h5SQYw6jqarzbtILjZho1gnT+FXFYR1RkXuECMTMllzmldUlVhoBq7
         gWXgAaFSxgrUw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2/22/21 5:41 AM, Sebastian Andrzej Siewior wrote:
> On 2021-02-21 17:46:25 [-0800], Dipen Patel wrote:
>> Hi,
> Hi,
>=20
>> I encountered below crash during the sync system call possibly coming
>> from the stress threads spawned because of the --io options which does
> =E2=80=A6
>=20
>> Platform:
>> Nvidia Jetson AGX XAVIER, with 32GB eMMC 5.1 and 256 bit 32GB LPDDR4 RAM=
.
>>
>> Kernel:
>> 4.9.201-rt134
> =E2=80=A6
>> Call stack:
>>
>> [ 1813.814464] INFO: task stress blocked for more than 120 seconds.
>> [ 1813.814610]       Not tainted 4.9.201-rt134 #2
>=20
> This is not a crash. It is simply an information that a task was blocked
> for quite some time (as it says).
Correct, its not a crash but fact that I have hung task panic enabled, it
reboots the system where it is not the case for the non-rt kernel with same
version, so I am guessing there has to be something in RT that contributed
to this.

> The important information would be:
> - does it recover
Yes, I have to disable hung_task_panic otherwise it will restart the system=
. The system is responsive so I am assuming there is no deadlock.

>   - does the time in seconds always increase or does it also drop
It varies.

>   - does the message disappear if stress terminates.
Yes
>=20
> - does it occur on v5.11-RT.
I have not tried, I do not have other RT kernel versions besides 4.9.xxx.
>=20
> Sebastian
>=20
