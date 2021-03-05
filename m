Return-Path: <SRS0=Pnk0=ID=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ECFC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E286508D
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 15:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEPle (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:41:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhCEPlW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 10:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51610ACBF;
        Fri,  5 Mar 2021 15:41:20 +0000 (UTC)
Subject: Re: [PATCH rt-tests v2 00/14] JSON cleanups and more tests updated
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20210305073500.17926-1-dwagner@suse.de>
 <20210305074138.lobxlbt7sirtj7lb@beryllium.lan>
 <bc668ca5-2f1b-fc36-4aa6-36917d0b6a@redhat.com>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <a9461cb8-95ba-e603-beae-586b16a1f4d1@suse.de>
Date:   Fri, 5 Mar 2021 16:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bc668ca5-2f1b-fc36-4aa6-36917d0b6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05.03.21 16:29, John Kacur wrote:
> How about --json ?
> Description, "Optionally output final results to FILENAME in JSON format"

Ah, that reminds me why I opted for output initially. We had the 
discussion to support different output formats. But if we just stick 
with JSON, --json is way better.

What about finishing this series first and then I send the output -> 
json cleanup?

