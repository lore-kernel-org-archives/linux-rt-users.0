Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A541C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E342187F
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFSPfw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:35:52 -0400
Received: from mail5.windriver.com ([192.103.53.11]:54366 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSPfw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:35:52 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5JFD1xm027838
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Jun 2019 08:13:17 -0700
Received: from [172.25.39.5] (172.25.39.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 08:13:03 -0700
Subject: Re: kernel.org slow download speed
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        <linux-rt-users@vger.kernel.org>
References: <20190618114513.4e2cfa7f@archlinux>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <f6fae132-0288-14b6-43a7-4525db921e38@windriver.com>
Date:   Wed, 19 Jun 2019 09:13:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618114513.4e2cfa7f@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.39.5]
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/18/2019 3:46 AM, Ralf Mardorf wrote:

> Is there an issue with the kernel.org server or is it more likely an
> issue by my ISP, an IXP or whatsoever?

For what it's worth, I just got 13 MB/s.  Seems fine here.

Chris
