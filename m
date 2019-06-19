Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8046CC31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4832187F
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="fT/P/j2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFSPxX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:53:23 -0400
Received: from mail156c50.megamailservers.eu ([91.136.10.166]:38396 "EHLO
        mail51c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbfFSPxX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:53:23 -0400
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1560959601;
        bh=Z2E9xKqv1pKsqJH7MsCfRYPDkTw+DeQQHsdMTTOTx/M=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=fT/P/j2PgiJI6qbFREeF3AkvEJhrGVzKyBYu/lTeLhIjRK5FgC2FHMZCtIw9gw0a3
         yaIIUwyqP+QiFbZu31wpjOaBGgD5XUuNlM4fZPFG2nPdQlRFRAsmbcSN9wduaBHiqw
         6u+mB32VD9sZGbt6gTVSloXi8uASlILaJ+fxqzq8=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x4e306ee4.dyn.telefonica.de [78.48.110.228])
        (authenticated bits=0)
        by mail51c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x5JFrJXF004644
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 15:53:21 +0000
Date:   Wed, 19 Jun 2019 17:53:20 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     <linux-rt-users@vger.kernel.org>
Subject: Re: kernel.org slow download speed
Message-ID: <20190619175320.2a9c51c2@archlinux>
In-Reply-To: <f6fae132-0288-14b6-43a7-4525db921e38@windriver.com>
References: <20190618114513.4e2cfa7f@archlinux>
        <f6fae132-0288-14b6-43a7-4525db921e38@windriver.com>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B0202.5D0A5A71.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=Z83C4kZA c=1 sm=1 tr=0 a=iZfk1/GLXApBNx3szEEm4A==:117
        a=iZfk1/GLXApBNx3szEEm4A==:17 a=VwQbUJbxAAAA:8
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=IxmO3M1tOlZxl3wFw2oA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 19 Jun 2019 09:13:02 -0600, Chris Friesen wrote:
>On 6/18/2019 3:46 AM, Ralf Mardorf wrote:
>
>> Is there an issue with the kernel.org server or is it more likely an
>> issue by my ISP, an IXP or whatsoever?  
>
>For what it's worth, I just got 13 MB/s.  Seems fine here.

Hi,

thank you. I got between 0 and very seldom up to 1000 KB/s, but in the
meantime I could download the sources. There was neither time to report
back that the downloads worked, nor to boot the new kernel.

Regards,
Ralf

-- 
pacman -Q linux{,-rt{-cornflower,,-pussytoes,-securityink}}|cut -d\  -f2
5.1.10.arch1-1
5.0.21_rt12-1
5.0.19_rt11-1
5.0.14_rt9-0
4.19.50_rt22-0
