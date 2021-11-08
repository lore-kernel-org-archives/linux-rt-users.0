Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6FFC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Nov 2021 10:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F75611C4
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Nov 2021 10:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhKHKbN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:31:13 -0500
Received: from gecko.sbs.de ([194.138.37.40]:35673 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237498AbhKHKbL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Nov 2021 05:31:11 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A8ASGJr010192
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 11:28:16 +0100
Received: from [139.22.43.76] ([139.22.43.76])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1A8ASF5R009174;
        Mon, 8 Nov 2021 11:28:15 +0100
To:     linux-rt-users@vger.kernel.org
Cc:     "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
        bigeasy@linutronix.de,
        SCHILD HENNING Z003BPMR <henning.schild@siemens.com>
From:   Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Questions to CI Testing the RT-Kernel
Message-ID: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
Date:   Mon, 8 Nov 2021 11:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear all,

we are currently looking to setup a test lab based on LAVA[1] for 
CI-testing the RT-Kernel.

Kernelci executes the combination cyclictest with hackbench in the 
background[2].

Our questions are:

 From what I found the RT-Project also uses the combination of 
cyclictest with hackbench for testing or are there currently any other 
tests specifically for real-time executed?

Are there recommended tests that should be added to the CI testing of a 
RT-Kernel?

[1]: https://docs.lavasoftware.org/lava/index.html
[2]: 
https://github.com/kernelci/kernelci-core/blob/main/config/lava/preempt-rt/preempt-rt.jinja2

-- 

With best regards,
Quirin Gylstorff

Siemens AG
