Return-Path: <SRS0=0+XQ=SZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9928C282DD
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 08:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64820645
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Apr 2019 08:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfDWI11 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:27:27 -0400
Received: from mail5.windriver.com ([192.103.53.11]:36144 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWI10 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Apr 2019 04:27:26 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3N8Qcl1026349
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 01:26:49 -0700
Received: from [128.224.162.188] (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Apr
 2019 01:26:28 -0700
Subject: Re: Bug report: A commit about serial8250 cause the output disorderly
 at the phase of startup
To:     John Ogness <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        <bigeasy@linutronix.de>
References: <5f1398dd-d505-dd8a-0ea1-8186618d56d3@windriver.com>
 <82793501-9ddf-11ec-3f91-73872bf3bd54@windriver.com>
 <871s1tusi8.fsf@linutronix.de>
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
Message-ID: <d1b07448-6518-18ad-9025-125290c5c1c1@windriver.com>
Date:   Tue, 23 Apr 2019 16:26:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871s1tusi8.fsf@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.188]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 4/23/19 2:48 PM, John Ogness wrote:
> On 2019-04-22, Hongzhi, Song <hongzhi.song@windriver.com> wrote:
>> Anyone notice this issue?
> Yes, I am aware of the issue. It is actually a feature, not a bug. ;-)
> Individual LOG_CONT messages, when classified as emergency messages, are
> printed immediately to the console.

Yes, this is what I have acquired from commit log and code.

The emergency mechanism is a good way.


>   This makes them appear
> "disorderly". It is not yet clear how best to deal with LOG_CONT
> emergency messages.


Extracting a part of log from my LOG_CONT message,

[    0.761635] 000:  (family: 0x6, model: 0xf
[    0.761635] 000: , stepping: 0xb)

It obviously separates a full line. Maybe it is not related to LOG_CONT. ^_^


The counterpart source code:

1499     pr_cont(" (family: 0x%x, model: 0x%x", c->x86, c->x86_model);
1500
1501     if (c->x86_stepping || c->cpuid_level >= 0)
1502         pr_cont(", stepping: 0x%x)\n", c->x86_stepping);
1503     else
1504         pr_cont(")\n");


I don't know if the issue exists in other place except LOG_CONT.

But it indeed influences customer's judgement.


Thanks for you reply.

--Hongzhi


> But I suppose we should introduce a config option to
> disable atomic consoles altogether if users preferred buffered/delayed
> printk output.




>
> John Ogness
>
>
>> On 4/19/19 10:24 AM, Hongzhi, Song wrote:
>>> 1. Issue description:
>>>
>>> Boot kernel( >= linux-rt-devel-v5.0.3 ) with qemu.
>>> Then qemu will print following disorderly messages.
>>>
>>> At the beginning, the messages are disorderly. But then it becomes
>>> normally from printing "[    0.000000] 000: Linux version..."
>>>
>>> --------------------------------------------------
>>> [    0.019000] 000: tsc: Unable to calibrate against PIT
>>> [    0.002583] 000: 6199.83 BogoMIPS (lpj=3099918)
>>> [    0.521247] 000: Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz
>>> [    0.521247] 000:  (family: 0x6, model: 0xf
>>> [    0.521247] 000: , stepping: 0xb)
>>> [    0.533126] 000: unsupported p6 CPU model 15
>>> [    0.533318] 000: no PMU driver, software events only.
>>> [    0.765082] 000: 1 ACPI AML tables successfully acquired and loaded
>>> [    0.765274] 000:
>>> [    0.785903] 000: Enabled 2 GPEs in block 00 to 0F
>>> [    0.786128] 000:
>>> [    0.835675] 000: acpi PNP0A03:00: fail to add MMCONFIG
>>> information, can't access extended PCI configuration space under
>>> this bridge.
>>> [    0.892056] 000:  5
>>> [    0.892289] 000:  *10
>>> [    0.892416] 000:  11
>>> [    0.892527] 000: )
>>> [    0.892661] 000:
>>>
>>> /* skip some repeated contents */
>>>
>>> [    5.052149] 000: , 512kB Cache
>>> [    0.000000] 000: Linux version 5.0.3-yocto-preempt-rt+
>>> (hsong@pek-lpggp1) (gcc version 8.3.0 (GCC)) #24 SMP PREEMPT Thu Apr
>>> 18 03:29:58 EDT 2019
>>> [    0.000000] 000: Command line: root=/dev/vda rw highres=off
>>> console=ttyS0 mem=256M ip=192.168.7.4::192.168.7.3:255.255.255.0
>>> vga=0 uvesafb.mode_opti0
>>> [    0.000000] 000: x86/fpu: x87 FPU will use FXSAVE
>>> [    0.000000] 000: BIOS-provided physical RAM map:
>>> [    0.000000] 000: BIOS-e820: [mem
>>> 0x0000000000000000-0x000000000009fbff]
>>> [    0.000000] 000: BIOS-e820: [mem
>>> 0x000000000009fc00-0x000000000009ffff]
>>> [    0.000000] 000: BIOS-e820: [mem
>>> 0x00000000000f0000-0x00000000000fffff]
>>> [    0.000000] 000: BIOS-e820: [mem
>>> 0x0000000000100000-0x000000000ffdbfff]
>>>
>>> --------------------------------------------------
>>>
>>> 2. Reproduce:
>>> (1)build kernel: (Attachment is my .config)
>>> make ARCH=x86_64
>>> CROSS_COMPILE=[path-to-my-cross-toolchain]/x86_64-wrs-linux-
>>>
>>> (2)boot kernel with qemu:
>>>
>>> qemu-system-x86_64 \
>>> -drive file=qemux86-64.rootfs.ext4,if=virtio,format=raw \
>>> -nographic \
>>> -kernel arch/x86/boot/bzImage \
>>> -append 'root=/dev/vda rw highres=off  console=ttyS0 mem=256M ip=dhcp'
>>>
>>> 3. Analysis:
>>> I find the following commit from >=linux-rt-devel-v5.0.3. cause the
>>> issue.
>>>
>>> b9d460e serial: 8250: implement write_atomic
