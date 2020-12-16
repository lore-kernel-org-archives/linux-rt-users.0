Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D600C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B0023130
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgLPIaw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:30:52 -0500
Received: from mail.numalliance.com ([90.84.246.155]:43475 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgLPIaw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 03:30:52 -0500
Received: from [192.168.0.64] (nomade78.numalliance.com [192.168.0.64])
        (Authenticated sender: sancelot@numalliance.com)
        by mail.numalliance.com (Postfix) with ESMTPSA id 7EC41243B5DA
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 09:30:10 +0100 (CET)
To:     linux-rt-users@vger.kernel.org
From:   Stephane ANCELOT <sancelot@numalliance.com>
Subject: enabling rt preempt
Message-ID: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
Date:   Wed, 16 Dec 2020 09:30:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I have downloaded latest LTS kernel 5.4 .

For unknown reasons, I dont understand why I can't enable full rt preempt,

I enabled Embedded system to enable expert mode.

But I have not the full rt option available.

Regards

Steph

