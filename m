Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044DDC43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 11:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DECA20700
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 11:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="RX5RXGm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfC1LKJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:10:09 -0400
Received: from mail176c50.megamailservers.eu ([91.136.10.186]:41348 "EHLO
        mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfC1LKI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 07:10:08 -0400
X-Greylist: delayed 844 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 07:10:06 EDT
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1553770560;
        bh=eyOhB8wgHrlIoA7u+P+K7NLsO3S0voX7kuXhlKidNCM=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=RX5RXGm5Zjd1cBoFTd4PluJ8OYJd3hzHr5PdlBK6rfnWoZwYUhf6yrROw3QuA9Yi6
         8sMatMfOiF0RstpKTltaEK5Bc6zdKb4iBq+XQHP5rYWKmXYdYSBDG1AjOAU2DNTisM
         NE8F3jKlsnnLlT68Q6A2EwhRqyRmsFrD64sT2Nko=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x5d845ab5.dyn.telefonica.de [93.132.90.181])
        (authenticated bits=0)
        by mail37c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x2SAtwTX011114
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2019 10:56:00 +0000
Date:   Thu, 28 Mar 2019 11:55:59 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190328115559.275af3c3@archlinux>
In-Reply-To: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B020A.5C9CA840.0048,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=J+uEEjvS c=1 sm=1 tr=0 a=Fdxjfia4lOXO4wIx1HYRQQ==:117
        a=Fdxjfia4lOXO4wIx1HYRQQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=fGO4tVQLAAAA:8 a=ZXXleyNYYs3xnThidFwA:9
        a=CjuIK1q_8ugA:10
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 28 Mar 2019 10:29:54 +0100, Bernhard Landauer wrote:
>The following happens only with Manjaro's rt patched version of
>linux50. No issue with the regular version.
>
>When firefox tries to recover tabs of a previous session, they crash.
>Normal operation of firefox is not affected. Only these specific tabs
>are broken.
>
>Full journal with core dump here:
>
>https://pastebin.com/W1mTnQ6N

Hi,

does Manjaro use additional patches, maybe those used by linux-rt from
AUR?

I build 5.0.3_rt1-0 without the nf_tables-fix patch and using a
different config than linux-rt from AUR.

Apart from the name 5.0.3_rt1-1 is equal with linux-rt from AUR.

I needed to downgrade, because a windows guest in virtualbox became
unresponsive. I tried several times to use the guest, when booted into
the AUR kernel 5.0.3_rt1-1. There is no issue when using 5.0.3_rt1-0
without one patch and a different config.

[rocketmouse@archlinux ~]$ grep pussytoes\  /var/log/pacman.log | grep downgrade
[2019-03-27 06:33] [ALPM] downgraded linux-rt-pussytoes (5.0.3_rt1-1 -> 5.0.3_rt1-0)

Regards,
Ralf

-- 
pacman -Q linux{,-rt{-pussytoes,-securityink,-cornflower,}}|cut -d\  -f2
5.0.4.arch1-1
5.0.3_rt1-0
4.19.31_rt18-0
4.19.25_rt16-0
4.19.23_rt13-0.1
