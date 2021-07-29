Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A6C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0219960525
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhG2Bvb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:51:31 -0400
Received: from ptr.189.cn ([183.61.185.104]:11154 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233162AbhG2Bvb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 21:51:31 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 21:51:30 EDT
HMM_SOURCE_IP: 10.64.8.31:34372.2072231552
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id BA9F8101D18;
        Thu, 29 Jul 2021 09:41:26 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-58c978dfc7-zdmrm with ESMTP id efb6fd3a85c24903bf5d9eb5380d5324 for jkacur@redhat.com;
        Thu Jul 29 09:41:26 2021
X-Transaction-ID: efb6fd3a85c24903bf5d9eb5380d5324
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [rteval PATCH] rteval: cyclictest.py: Fix config check
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
References: <20210728.202110.2259637121232602746.atsushi.nemoto@sord.co.jp>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <617402f2-2dd7-cc41-215a-b7ab9d3e935b@189.cn>
Date:   Thu, 29 Jul 2021 09:41:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728.202110.2259637121232602746.atsushi.nemoto@sord.co.jp>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mr. Nemoto,

If i understand it correctly, cyclictest.py is python cyclictest, is it? 
It's interesting and i would like to give it a try.

Could you please let me know where i can clone its code, i failed to 
find it in rt-tests.git.

many thanks.

BR

Song

ÔÚ 2021/7/28 ÏÂÎç7:21, Atsushi Nemoto Ð´µÀ:
> The self.__cfg itself is not a dictionary and "key in self.__cfg"
> does not work as expected.
> Use "key in self.__cfg.keys()" instead.
> 
> This bug was introduced by the commit fd3b732f714d ("rteval: 2to3
> transformations")
> 
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> ---
>   rteval/modules/measurement/cyclictest.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index b1755d4..8957dcb 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -265,7 +265,7 @@ class Cyclictest(rtevalModulePrototype):
>   
>   
>       def _WorkloadPrepare(self):
> -        self.__interval = 'interval' in self.__cfg and '-i%d' % int(self.__cfg.interval) or ""
> +        self.__interval = 'interval' in self.__cfg.keys() and '-i%d' % int(self.__cfg.interval) or ""
>   
>           self.__cmd = ['cyclictest',
>                         self.__interval,
> @@ -280,10 +280,10 @@ class Cyclictest(rtevalModulePrototype):
>               self.__cmd.append('-t')
>               self.__cmd.append('-a')
>   
> -        if 'threads' in self.__cfg and self.__cfg.threads:
> +        if 'threads' in self.__cfg.keys() and self.__cfg.threads:
>               self.__cmd.append("-t%d" % int(self.__cfg.threads))
>   
> -        if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
> +        if 'breaktrace' in self.__cfg.keys() and self.__cfg.breaktrace:
>               self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
>               self.__cmd.append("--tracemark")
>   
> @@ -300,7 +300,7 @@ class Cyclictest(rtevalModulePrototype):
>           self.__nullfp = os.open('/dev/null', os.O_RDWR)
>   
>           debugdir = self.__get_debugfs_mount()
> -        if 'breaktrace' in self.__cfg and self.__cfg.breaktrace and debugdir:
> +        if 'breaktrace' in self.__cfg.keys() and self.__cfg.breaktrace and debugdir:
>               # Ensure that the trace log is clean
>               trace = os.path.join(debugdir, 'tracing', 'trace')
>               fp = open(os.path.join(trace), "w")
> 
