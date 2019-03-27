Return-Path: <SRS0=WElg=R6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E21C43381
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1E6206BA
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Mar 2019 21:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SFml0bLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC0Vf6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:35:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10116 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0Vf6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Mar 2019 17:35:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9becc10000>; Wed, 27 Mar 2019 14:36:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 14:35:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Mar 2019 14:35:57 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 21:35:57 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 21:35:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 21:35:57 +0000
Received: from nvidia.com (Not Verified[172.17.136.34]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES128-GCM-SHA256)
        id <B5c9becbd0000>; Wed, 27 Mar 2019 14:35:57 -0700
Date:   Wed, 27 Mar 2019 14:35:55 -0700
From:   Allen Martin <amartin@nvidia.com>
To:     <zanussi@kernel.org>
CC:     <linux-rt-users@vger.kernel.org>, <anup.pemmaiah@gmail.com>,
        <bigeasy@linutronix.de>
Subject: ARMv8 fp register corruption in 4.14 PREEMPT_RT series
Message-ID: <20190327213555.GA16845@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
User-Agent: Mutt/1.5.24 (2015-08-30)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553722561; bh=TMrM/xBk3OBjRTlEZuB5TT5goIQRLwrjBoDwsHR178E=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:MIME-Version:
         X-NVConfidentiality:User-Agent:Content-Type:Content-Disposition;
        b=SFml0bLzOYTSwzG4qwbRFdCb1SGLSZpslYAtQJPXdcLYY0m/W+Cs4DulsAKR++IXw
         Tk7YhT8f0dT91saNnASqd4+OFGSGxn6k03SQA1fRy/+YfxGdeU0JKFSNFIeYz9zde3
         82Hk8YdB4OrvuUMEt5JcsgjP9rxBe/FAPtYNiLoq/tSTFmQYYwR442LlwFaLZ75QsN
         Mzdv6R53ySiSjOzfzSVmibzEgNn5MnVM5ChlxkPq0gbTDrCF2tKY9BxCDDOIP8drFc
         7nUCz4VFByLmE1gjRhEEBVICAFg/3gNJ/p3xKRFNb4jzl+QAlJ8B55iiTCgNi+Cc8S
         SjCyTglVzWeZw==
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom, I can confirm the ARMv8 fp register corruption reported here:

https://marc.info/?l=linux-rt-users&m=153930857708206&w=2

still exists in 4.14.106-rt56.  I was able to reproduce this on both
A57 and Carmel ARMv8 CPUs using the float_bessel subtest of LTP.  This
fix was to backport the following patch from 4.18.y-rt to 4.14-rt:

  3afdfe419c33c1655d0763e070350aad44416594
  arm64: fpsimd: use preemp_disable in addition to local_bh_disable()

Are you able to pick up this patch into 4.14-rt?  I'm sure Anup and I
are not the only ones who are hitting this.

-Allen
