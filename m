Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C3CC4361B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73123AC1
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 14:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgLROmm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:42:42 -0500
Received: from mail.monom.org ([188.138.9.77]:50866 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgLROml (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 09:42:41 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8FA4D50056B;
        Fri, 18 Dec 2020 15:41:59 +0100 (CET)
Received: from [192.168.154.220] (unknown [94.31.99.195])
        by mail.monom.org (Postfix) with ESMTPSA id 4BA1550017E;
        Fri, 18 Dec 2020 15:41:59 +0100 (CET)
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
To:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20201218141935.24151-1-dwagner@suse.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <f252ba74-46de-ced1-5e77-a64ec51510ba@monom.org>
Date:   Fri, 18 Dec 2020 15:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201218141935.24151-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 18.12.20 15:19, Daniel Wagner wrote:
> As we have a hard dependency on libnuma we can simplify the code in
> cyclictest. This allows remove all the small helpers in rt_numa.h. And
> with this we can remove the header and reduce the confusion with
> rt-numa.h
> 
> While at it, I simplified the --smp vs --affinity vs --threads
> logic. There is no need for additional variables to keep state. With
> this we also make --affinity to behave as with the rest of
> rt-tests. That is a plan -a will be the same as with -S. There is no
> need for -S anymore but I think we should leave it in place for
> backwards compatibility. I suspect, there must be a lot of muscle
> memory out there :)

I just realized there are some programs which need the same treatment. 
Wait for v2...
