Return-Path: <SRS0=ajRN=Z7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DCDC43603
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6E20663
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 09:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfLIJkb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:40:31 -0500
Received: from mail.monom.org ([188.138.9.77]:44940 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfLIJkb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Dec 2019 04:40:31 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id ADCB2500796;
        Mon,  9 Dec 2019 10:40:29 +0100 (CET)
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 73484500243;
        Mon,  9 Dec 2019 10:40:29 +0100 (CET)
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick also
 for all !x86 archs
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20191208210625.5999-1-ukleinek@debian.org>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <18a0be03-74dd-54f1-a0f0-4f4acdd061ad@monom.org>
Date:   Mon, 9 Dec 2019 10:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191208210625.5999-1-ukleinek@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Uwe,

On 2019-12-08 22:06, Uwe Kleine-König wrote:
> This fixes a build error on arm64, mips*, ppc and several others

Just wondering if the tool should print a warning if the fallback is 
used? IIRC, the code wants to use the TSC and clock_gettime is probably 
not so precise.

Thanks,
Daniel
