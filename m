Return-Path: <SRS0=KLW2=Z6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C7CC43603
	for <linux-rt-users@archiver.kernel.org>; Sun,  8 Dec 2019 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8A3206E0
	for <linux-rt-users@archiver.kernel.org>; Sun,  8 Dec 2019 13:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHNPg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:15:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:13839 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfLHNPg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 8 Dec 2019 08:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 05:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,291,1571727600"; 
   d="scan'208";a="202579954"
Received: from cvg-ubt08.iil.intel.com (HELO [143.185.152.138]) ([143.185.152.138])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2019 05:15:34 -0800
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Subject: How to use PREEMPT_RT with kernel 5.4
Message-ID: <7f488716-f294-a21c-4588-6753ff9bd0df@linux.intel.com>
Date:   Sun, 8 Dec 2019 15:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I need to build RT enabled kernel.

With kernels up to and including 5.2, there was fairly easy procedure
for building RT enabled kernel - apply patch, then RT features are
immediately available in "make xxxconfig".

Now, with 5.4. CONFIG_PREEMPT_RT is merged, but it depends_on 
ARCH_SUPPORTS_RT that, in turn, does not set for any architecture.

How should I proceed from here? Am I supposed to just set 
ARCH_SUPPORTS_RT for my architecture? Do I need any other patches to 
start? If yes, where to get it? I see not all patches in the 5.2 bundle 
are merged mainline.

Thanks, Vladimir
