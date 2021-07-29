Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E0C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43026103B
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhG2CGd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:06:33 -0400
Received: from ptr.189.cn ([183.61.185.102]:13100 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233162AbhG2CGc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 22:06:32 -0400
HMM_SOURCE_IP: 10.64.8.31:45144.1345021144
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 1DA931006F7;
        Thu, 29 Jul 2021 10:06:28 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-58c978dfc7-zdmrm with ESMTP id d302e41bdc2b4a43a653bebe01b9c2cf for jkacur@redhat.com;
        Thu Jul 29 10:06:29 2021
X-Transaction-ID: d302e41bdc2b4a43a653bebe01b9c2cf
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [rteval PATCH] rteval: cyclictest.py: Fix config check
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Cc:     linux-rt-users@vger.kernel.org, jkacur@redhat.com
References: <20210728.202110.2259637121232602746.atsushi.nemoto@sord.co.jp>
 <617402f2-2dd7-cc41-215a-b7ab9d3e935b@189.cn>
 <20210729.105521.488353044950955983.atsushi.nemoto@sord.co.jp>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <ea9a3786-b59d-a0dd-d575-22485a8f4268@189.cn>
Date:   Thu, 29 Jul 2021 10:06:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210729.105521.488353044950955983.atsushi.nemoto@sord.co.jp>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

got it, thanks again.

Song

ÔÚ 2021/7/29 ÉÏÎç9:55, Atsushi Nemoto Ð´µÀ:
> On Thu, 29 Jul 2021 09:41:09 +0800, "chensong_2000@189.cn" <chensong_2000@189.cn> wrote:
>> If i understand it correctly, cyclictest.py is python cyclictest, is it? It's interesting and i would like to give it a try.
> 
> No.  It is a part of the rteval tool.
> 
>> Could you please let me know where i can clone its code, i failed to find it in rt-tests.git.
> 
> https://git.kernel.org/pub/scm/utils/rteval/rteval.git
> 
> ---
> Atsushi Nemoto
> 
