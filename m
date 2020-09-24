Return-Path: <SRS0=aBkN=DB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A50C4363D
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F602396E
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Sep 2020 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIXKEu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:04:50 -0400
Received: from mail.numalliance.com ([90.84.246.155]:42829 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKEt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Sep 2020 06:04:49 -0400
Received: from [192.168.0.68] (retd17.numalliance.com [192.168.0.68])
        (Authenticated sender: sancelot@numalliance.com)
        by mail.numalliance.com (Postfix) with ESMTPSA id D3E7F20AA426
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2020 12:04:48 +0200 (CEST)
From:   =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: running it in an hypervisor
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <bed0a3c7-6b1e-117b-0dd6-f91230161bd3@numalliance.com>
Date:   Thu, 24 Sep 2020 12:04:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I would like to know which hypervisor are known to work with rt-preempt ?

In parallel I  would like to run hmi in a windows environment with 3D .

Regards,

S.Ancelot


