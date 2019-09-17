Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46873C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2321E206C2
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbfIQHQM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:16:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51748 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfIQHQM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 03:16:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1920558wme.1;
        Tue, 17 Sep 2019 00:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aofTgRmQAVkvOd8iQm6tEkFcxosnNzz7WnSpyZCbnMQ=;
        b=OK2CbXArPbh4Rdj7cFju86lvAPtrD00QFGYlO0N6stTH8qIx+N7RQx1NTcvUIRZkfR
         hgroPvmQoCahlM5k0ILQuzzVdonoVsWDN00iV/xV8/9bLvipIp+BavcZ3i5VJkg6+gyR
         A8sadgLhbFnACdf04ABl3DJQtzKpJimLngIMZFCKHGHYSxswqwJSYuQxEq7cKW8ZrE6H
         lAVQ73x7zj84JyzXM28EmBufoG1A0JWoNMLHfV3uswYmtd/GdV5hAuSzvGqQHp/GyeBF
         Zbi7kxf/9vJNwXltwi54ivVcyDsynJPbpQ+KGOzgqDIfPm5EThrazLD0FMtsTraYvNOo
         anUg==
X-Gm-Message-State: APjAAAXcb3ccDUy4Uyg29QbXdDsuEimA+0LdII1cHHk29mADEEBUndVu
        /XGrLfKWu/8ujzCC8ORTH/A=
X-Google-Smtp-Source: APXvYqzTS//zHyaXQ4q+Yq3PlqG/RIT//kLx1QrCII6mltGWtfjzBV7kykqS7+5iqkt6SK+v5ddmbg==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr1058939wmh.55.1568704569103;
        Tue, 17 Sep 2019 00:16:09 -0700 (PDT)
Received: from sultan-box (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id e6sm1178527wrp.91.2019.09.17.00.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:16:08 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:15:46 +0200
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h directly
Message-ID: <20190917071546.GA27627@sultan-box>
References: <20190903191321.6762-1-sultan@kerneltoast.com>
 <alpine.LFD.2.21.1909162356500.10273@planxty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1909162356500.10273@planxty>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Sep 16, 2019 at 11:57:32PM +0200, John Kacur wrote:
> Signed-off-by: John Kacur <jkacur@redhat.com>
> But please in the future
> 1. Don't cc lkml on this
> 2. Include the maintainers in your patch

Hi,

Thanks for the sign-off. I was following the instructions listed here:
https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches

I couldn't find any documentation of how to send patches for rt-tests. Is there
a different set of patch submission instructions on a wiki somewhere I missed?

Thanks,
Sultan
