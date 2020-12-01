Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E6C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748742084C
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 15:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbgLAP2F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 10:28:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390298AbgLAP2E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 10:28:04 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kk7Yo-00072f-TW; Tue, 01 Dec 2020 15:27:22 +0000
To:     linux-rt-users@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: =?UTF-8?Q?RT_long_hang_during_boot_on_ARM64_SynQuacer=e2=84=a2_96Bo?=
 =?UTF-8?Q?ards_Box=2c_v5=2e10-rc6-rt13?=
Message-ID: <892ffdfa-987a-baf8-c02a-6844fc019adb@canonical.com>
Date:   Tue, 1 Dec 2020 15:27:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi there,

I've been trying to get the 5.10-rcX RT kernels to boot on an 24 CPU
ARM64 SynQuacer box.  In single CPU non-SMP mode it boots immediately,
however with 24 CPUs I get a really long boot delay:

Oct 29 17:38:35 synquacer kernel: [    2.197037] evm: security.SMACK64EXEC
Oct 29 17:38:35 synquacer kernel: [    2.197039] evm:
security.SMACK64TRANSMUTE
Oct 29 17:38:35 synquacer kernel: [    2.197042] evm: security.SMACK64MMAP
Oct 29 17:38:35 synquacer kernel: [    2.197044] evm: security.apparmor
Oct 29 17:38:35 synquacer kernel: [    2.197046] evm: security.ima
Oct 29 17:38:35 synquacer kernel: [    2.197048] evm: security.capability
Oct 29 17:38:35 synquacer kernel: [    2.197051] evm: HMAC attrs: 0x1
Oct 29 17:38:35 synquacer kernel: [    3.970833] sched: RT throttling
activated
Oct 29 17:38:35 synquacer kernel: [ 1850.659285] Freeing unused kernel
memory: 7168K
Oct 29 17:38:35 synquacer kernel: [ 1850.807599] Checked W+X mappings:
passed, no W+X pages found
etc..

At first I thought it was a complete lockup, but this happens on each
boot - a 1800+ second boot delay.

The delay is related to the number of CPUs:

2 cpus - 507 secs
4 cpus - 1014 secs
8 cpus - 1813 secs
16 cpus -1838 secs
24 cps - 1850 secs

Any ideas?  I'm going to see if this occurs on earlier kernels next, but
I was wondering if this is a know issue.

Regards,

Colin
