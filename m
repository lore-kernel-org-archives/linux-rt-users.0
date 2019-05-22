Return-Path: <SRS0=tVcw=TW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE067C282CE
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10D4217D4
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 May 2019 12:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEVMK0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 May 2019 08:10:26 -0400
Received: from mail.numalliance.com ([90.84.246.155]:59636 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfEVMK0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 May 2019 08:10:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.numalliance.com (Postfix) with ESMTP id 7B13F23F178B
        for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2019 14:10:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.numalliance.com
Received: from mail.numalliance.com ([127.0.0.1])
        by localhost (mail.numalliance.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4Tyhk72j68Qy for <linux-rt-users@vger.kernel.org>;
        Wed, 22 May 2019 14:10:16 +0200 (CEST)
Received: from [192.168.0.139] (retd17.numalliance.com [192.168.0.139])
        (Authenticated sender: sancelot@numalliance.com)
        by mail.numalliance.com (Postfix) with ESMTPSA id 4F6A923F1782
        for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2019 14:10:16 +0200 (CEST)
From:   =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: intel j1900 and i915 realtime problems
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <bf7df0b0-64b4-910f-137e-1eba406d3f52@numalliance.com>
Date:   Wed, 22 May 2019 14:10:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I have got a problem with a celeron j1900 platform and i915 driver.

I have 3 realtime tasks that are launched sequentially.

task1 is clocked periodically at 3ms.

task1 wakes up task2 and takes 2 wakes up task 3 using priority 
scheduling (and SCHED_FIFO mechanism).

everything works well, until I am using graphic applications with 
activity (hide/show gui programs...,widgets creation /refresh etc).

The task1 always start periodically each 3ms, but the other threads 
execution time are delayed.

I mean normally, the whole computing processing timing 
(task1+task2+task3) takes normally around 800us time execution.

When I stress the graphic pages, This time becomes up to 1.6ms.

The 3 tasks are isolated on a cpu. I don't think the problem is involved 
by the CPU, but more by i915 driver and memory.

I have not managed to identify the right reason with perf utility.

One thing I am sure :

if I run the same gui pages through an ssh shell, the problem has not 
appeared. realtime is not "broken"

I know that the intel driver is involved.

I would need some help to identify the right problem and for finding 
solutions.ideas.

Regards,

S.Ancelot

