Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA4C43460
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6284A6121E
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 May 2021 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbhETOEz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 May 2021 10:04:55 -0400
Received: from freeby.mesanet.com ([108.95.56.89]:62688 "EHLO
        freeby.mesanet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhETODh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 May 2021 10:03:37 -0400
X-Greylist: delayed 1618 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2021 10:03:37 EDT
Received: from localhost (IDENT:pcw@localhost [127.0.0.1])
        by freeby.mesanet.com (8.14.3/8.11.0) with ESMTP id 14KDZGIE017826;
        Thu, 20 May 2021 06:35:16 -0700 (PDT)
Date:   Thu, 20 May 2021 06:35:16 -0700 (PDT)
From:   "Peter C. Wallace" <pcw@mesanet.com>
To:     Christoph Mathys <eraserix@gmail.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: Network latency on 5.4 and 5.10
In-Reply-To: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
Message-ID: <Pine.NEB.4.64.2105200631300.26202@freeby.mesanet.com>
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 20 May 2021, Christoph Mathys wrote:

> Date: Thu, 20 May 2021 09:36:46 +0200
> From: Christoph Mathys <eraserix@gmail.com>
> To: linux-rt-users@vger.kernel.org
> Subject: Network latency on 5.4 and 5.10
> 
> Hi all!
>
> I'm trying to upgrade from 4.9-rt to 5.4-rt (also tried 5.10). I'm having a 
> hard time getting networking to perform on the same level as 4.9 (latency 
> wise). We drive an EtherCAT bus at 4kHz using the igb driver.
>
> On 4.9, I just had to disable coalescing on the nic and increase the priority 
> of the irg threads and it performed as desired (more or less according to [1] 
> for 3.6+ without task pinning)
>
> Doing the same on 5.4/5.10 does not seem to suffice any more. I get a lot of 
> warnings from our code that packets have not been sent or received in time 
> for the next control loop iteration.
>
> Any suggestions on what I could try to improve the nic response?
>
> Thanks!
> Christoph
>
> [1] 
> https://www.osadl.org/Real-time-Ethernet-UDP-worst-case-roun.qa-farm-rt-ethernet-udp-monitor+M514ebdffa90.0.html
>

No, help but I have seen the same thing with our real time UDP connected 
Ethernet devices. 4.X seems to have much better latencies that 5.X. I've tried 
up to 5.11.

Peter Wallace
Mesa Electronics

