Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A43C4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 19:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C10E208E3
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 19:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfF1Tf6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:35:58 -0400
Received: from mail.windriver.com ([147.11.1.11]:40367 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfF1Tf6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 15:35:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x5SJZrPW025300
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 12:35:53 -0700 (PDT)
Received: from [172.25.39.5] (172.25.39.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 12:35:52 -0700
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: weird issue with CentOS RT kernel, hangs hard under particular load.
Message-ID: <c9786841-df3c-b022-3f94-5973f97086aa@windriver.com>
Date:   Fri, 28 Jun 2019 13:35:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.39.5]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

Not sure who I should be talking to about this, but we're hitting a 
weird issue with kernel-rt-3.10.0-957.12.2.rt56.929.el7.src.rpm from CentOS.

Basically, while running containerized OpenStack on top of Kubernetes it 
just hangs after a while.  Without anything useful in the logs, and so 
hard that sysrq on the serial console doesn't work (and it does normally).

The equivalent non-RT kernel seems to work fine, does not show the same 
problem.

Also, reducing the number of OpenStack services running seems to 
increase stability even though the CPUs aren't super busy in the failure 
scenario.

Anyone got any suggestions on where to start debugging it?  Kernel 
options to enable, extra debug logging, events to monitor?

Thanks,
Chris
