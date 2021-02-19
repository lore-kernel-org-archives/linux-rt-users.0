Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C565C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BFF64DF0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBSQnq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:43:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBSQnn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:43:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17231ABAE;
        Fri, 19 Feb 2021 16:43:01 +0000 (UTC)
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
To:     John Kacur <jkacur@redhat.com>, Daniel Wagner <dwagner@suse.de>
Cc:     Peter Xu <peterx@redhat.com>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
 <acfe74c9-b629-6ca6-95bf-ab88fff7d92c@redhat.com>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <9df4b90f-a73c-0741-85ea-403c9340ce37@suse.de>
Date:   Fri, 19 Feb 2021 17:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <acfe74c9-b629-6ca6-95bf-ab88fff7d92c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 19.02.21 17:35, John Kacur wrote:
>> "rt-numa: Use mask size for iterator limit"
>> "rt-numa: Remove max_cpus argument from parse_cpusmask"
> 
> Are those actually bug fixes or just a different way of doing things?

max_cpus is just giving you the number of available CPUs. The loop 
assumes that all are in the range of [0..max_cpus] which is not 
necessarily true. You need to iterate over all possible CPUs. That is 
why passing in max_cpus is pretty useless.
