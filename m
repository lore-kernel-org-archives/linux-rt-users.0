Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26175C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA01623370
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLPIkO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:40:14 -0500
Received: from mail.numalliance.com ([90.84.246.155]:50334 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLPIkO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 03:40:14 -0500
Received: from [192.168.0.64] (nomade78.numalliance.com [192.168.0.64])
        (Authenticated sender: sancelot@numalliance.com)
        by mail.numalliance.com (Postfix) with ESMTPSA id 178C120AA422;
        Wed, 16 Dec 2020 09:39:32 +0100 (CET)
Subject: Re: enabling rt preempt
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
References: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
 <CAKXUXMwihDVrw03JehiVSQADtqwXWDNV_CJT+tzudRPHxLBdyQ@mail.gmail.com>
From:   Stephane ANCELOT <sancelot@numalliance.com>
Message-ID: <a5414150-efa6-3502-bd51-fe83ea7750fc@numalliance.com>
Date:   Wed, 16 Dec 2020 09:39:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAKXUXMwihDVrw03JehiVSQADtqwXWDNV_CJT+tzudRPHxLBdyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Le 16/12/2020 à 09:36, Lukas Bulwahn a écrit :
> On Wed, Dec 16, 2020 at 9:31 AM Stephane ANCELOT
> <sancelot@numalliance.com> wrote:
>> Hi,
>>
>> I have downloaded latest LTS kernel 5.4 .
>>
>> For unknown reasons, I dont understand why I can't enable full rt preempt,
>>
> Well, PREEMPT_RT is not available on v5.4 without the PREEMPT_RT patch set.
Sorry, I thought it was now part of the mainstream kernel. I have not 
understand :-\
> You can check that there is no architecture support for PREEMPT_RT on
> the stable kernel. Just look at the Kconfig files defining those
> config symbols.
>
> Lukas
