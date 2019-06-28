Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1ACC4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B8206E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 08:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="kevgX0bG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF1Iep (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:34:45 -0400
Received: from mail221c50.megamailservers.eu ([91.136.10.231]:49176 "EHLO
        mail33c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbfF1Iej (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 04:34:39 -0400
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1561710877;
        bh=nnO2uaMSMp75LfmO9ORbyCsc3g/4BYfUSnVtu4Pd1M8=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=kevgX0bGwf+LP4fhg17wY5ao8owPPKknejsr9olBtUF3w2l8N3vZTb+5H9T5nUdJO
         ZTQoVE8nHbcSNfuRV7rNeVDJpr4BuiDJWskI3JTJ/jwXejuirnMAGjTJIGih1Cxvpz
         qqtU1Mr9DhbBvf5WynoT2XymWaJ5cOIAtDkZINdc=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (x4e31604e.dyn.telefonica.de [78.49.96.78])
        (authenticated bits=0)
        by mail33c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x5S8YZdn005539
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2019 08:34:36 +0000
Date:   Fri, 28 Jun 2019 10:34:35 +0200
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
Message-ID: <20190628103435.0d95ebe8@archlinux>
In-Reply-To: <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
        <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A0B020F.5D15D11D.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=Ioswjo3g c=1 sm=1 tr=0 a=Sdy8UPBtZ110XTA5kkZ23w==:117
        a=Sdy8UPBtZ110XTA5kkZ23w==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=jkrjzP7BTNXIm8qfY_IA:9 a=CjuIK1q_8ugA:10
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 28 Jun 2019 08:05:12 +0200, Arve Barsnes wrote:
>I don't know if this helps

Hi,

I also don't know. However, you did not mention what hardware, even not
the architecture ;). It might make a difference, if it happens on a
"PC" or a "Raspberry".

It seems to be ok on my Intel based x86_64 machine.

[root@archlinux rocketmouse]# uname -a
Linux archlinux 5.0.21-rt14-0-rt-cornflower #1 SMP PREEMPT RT Wed Jun 26 20:13:44 CEST 2019 x86_64 GNU/Linux
[root@archlinux rocketmouse]# hwinfo --cpu | grep Model | sort -u
  Model: 6.60.3 "Intel(R) Celeron(R) CPU G1840 @ 2.80GHz"
[root@archlinux rocketmouse]# dmidecode -t 2 | grep -eManu -eName
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: B85M-D3H

Regards,
Ralf
