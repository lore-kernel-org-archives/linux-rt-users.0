Return-Path: <SRS0=UpHf=U7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFCAC06510
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5D52082F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Jul 2019 16:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfGBQFX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:05:23 -0400
Received: from mail5.windriver.com ([192.103.53.11]:44242 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfGBQFX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Jul 2019 12:05:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x62G4F5e014480
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Tue, 2 Jul 2019 09:05:12 -0700
Received: from [128.224.21.5] (128.224.21.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 2 Jul
 2019 09:04:52 -0700
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: is magic-sysrq handling threaded in linux-RT?
Message-ID: <a9dfc474-3691-64bc-7b81-7e4e6d4acb71@windriver.com>
Date:   Tue, 2 Jul 2019 10:04:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.21.5]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm trying to debug an issue on a kernel with the RT patches, and it's 
causing a hang where magic-sysrq does not work.

I'd like to clarify something though...is the serial console interrupt 
threaded?  If it is, then something that prevents the scheduler from 
running could result in magic-sysrq not functioning, but if it isn't 
then I think that would point to an interrupt problem.

Anyone know for sure?

Thanks,
Chris
