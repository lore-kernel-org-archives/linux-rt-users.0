Return-Path: <SRS0=ajRN=Z7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077FC43603
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 10:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6E2077B
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="EVhWZPAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLIKKV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:10:21 -0500
Received: from mail155c50.megamailservers.eu ([91.136.10.165]:59352 "EHLO
        mail51c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726297AbfLIKKV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Dec 2019 05:10:21 -0500
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2019 05:10:20 EST
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1575885562;
        bh=0XJQKqSK0pGNrc1u5dp1Ba4csMPrAxIfDCZ5e3Ea4Y0=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=EVhWZPANTqYJXn97SHT3DD4Uon83PUIO8uo/+wGUqWFkG1JMKIQ8K0YDJ+XyM45CN
         XEoi72uL3NXyH0GYe/ZS3oqd97Dgx3ZOS6T3Y4dODuqswv3KVwON0NrZezwfpqNjOr
         JRjVe8oFCH2eTJvTJn/hSC4YiXplHq1E8xXiYMgk=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x5d84b911.dyn.telefonica.de [93.132.185.17])
        (authenticated bits=0)
        by mail51c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id xB99xKKR028518
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Mon, 9 Dec 2019 09:59:22 +0000
Date:   Mon, 9 Dec 2019 10:59:20 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: How to use PREEMPT_RT with kernel 5.4
Message-ID: <20191209105920.09e6eb65@archlinux>
In-Reply-To: <7f488716-f294-a21c-4588-6753ff9bd0df@linux.intel.com>
References: <7f488716-f294-a21c-4588-6753ff9bd0df@linux.intel.com>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B0214.5DEE1AFA.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=LO0Yv6e9 c=1 sm=1 tr=0 a=VZd9s53ubsiLLDzTMQh4Sw==:117
        a=VZd9s53ubsiLLDzTMQh4Sw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=OQQBgDgIElcw17YI0XQA:9 a=CjuIK1q_8ugA:10
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

just out of curiosity, why can't you use a rt patched 5.2 kernel
or either a non-patched 5.4 kernel with BOOT_IMAGE=...threadirqs...,
let alone a 4.x longterm rt patched kernel?

Regards,
Ralf
