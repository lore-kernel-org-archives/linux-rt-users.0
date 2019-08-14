Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB4C433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4C1206C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 13:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQBygWgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHNNZ4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:25:56 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39045 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfHNNZ4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 09:25:56 -0400
Received: by mail-wm1-f50.google.com with SMTP id i63so4452345wmg.4
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SdCqsQZxU9xu1stIh5Y+jiCX09hqPV2KZ4oCTLvaP/w=;
        b=BQBygWgugbZ+m7cRy+qY8M70oQwL3gd5dYePByJZUmFtTlOHrFDLgcYsP5zfRQmAu9
         7nQcjW8JMcN3GSFlc68a36YkHcD+BeIE9SoocWNrh/xHch/Imyse7ps9RjeNXEX9secw
         UL9/9+mMcUUHY34tahYlXW1mf3yUUIg9qra/CxW0bW/7SHPNZhF0X7BvXyE/geflGH7M
         PO1q9IDTIGuc7nkjdjUdVb/3lUjHGrCP41xXiCUBRHHxYiPOiCN8lyxCBh7GKjZZRT4U
         Be32XoMJdCv9n7yeBmnBD6pygGfzhFa/VOduFi/R+kmMkBHJXETVGVmB+pV8TS5yEmw4
         KXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=SdCqsQZxU9xu1stIh5Y+jiCX09hqPV2KZ4oCTLvaP/w=;
        b=tBVvzWk8FPU4h41nThzu/+iwyc8exZmZ6Lc5LrumZV1m2O9nuAVShu1DRKVhaoOAOn
         eA476HBc+RVHpIVu1/BnHWnYetGMbQmeE0bqrhS3J91uVbpsYVFokutco3KNk/qOn7t0
         orHtuQD7nGpcd/94DqcYne4/1Ni0Y1Pc758bxjrgHaouwAux3tAhjy7Bupr8pOAezc62
         1yzbPsrAC0iy+y6gP9mEfY1espRBv7z3INk82rap2k4kkWoUtlwZAfqt+braHfZoMMwV
         KD5IpkluRueTZbNxrelbYDNiTb6yDwrxQ1cX1mf5VMvpuH2qbbZkUetxb1tUsaMCjR7U
         Loew==
X-Gm-Message-State: APjAAAVghTBiwt5yDBTsZwylOcoQOlZZtwU/PKMnng3xifyRuw7M20z3
        tp+X7A5o+BLm31trh+2f+qg=
X-Google-Smtp-Source: APXvYqw2ebr19BZRkYtUWfnovp6sNIvi/ubNgJJByNDYF/Aa1aKhIw+fvxN1YNXi97ydHdln9oGSow==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr9111503wml.51.1565789154172;
        Wed, 14 Aug 2019 06:25:54 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id z2sm3240812wmi.2.2019.08.14.06.25.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:25:53 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:25:44 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Rachid Koucha <rachid.koucha@gmail.com>
cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: Little bug in cyclictest
In-Reply-To: <5d169fe2-b545-ae68-a946-4e36a613cbda@gmail.com>
Message-ID: <alpine.LFD.2.21.1908141524020.5420@planxty>
References: <5d169fe2-b545-ae68-a946-4e36a613cbda@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-2076305359-1565789153=:5420"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-2076305359-1565789153=:5420
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 14 Aug 2019, Rachid Koucha wrote:

> Hi,
> 
> First of all, many thanks for such useful tools.
> 
> In the source code of cyclictest, I can see a mistake concerning the
> error checking of pthread_setaffinity_np():
> 
> Upon error, pthread functions return an error ant not -1. So, the
> following code:
> 
>     if (par->cpu != -1) {
>         CPU_ZERO(&mask);
>         CPU_SET(par->cpu, &mask);
>         thread = pthread_self();
>         if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
>             warn("Could not set CPU affinity to CPU #%d\n",
>                  par->cpu);
>     }
> 
> should be fixed as follow:
> 
> int status;
> 
>     if (par->cpu != -1) {
>         CPU_ZERO(&mask);
>         CPU_SET(par->cpu, &mask);
>         thread = pthread_self();
>         if ((status = pthread_setaffinity_np(thread, sizeof(mask), &mask)) != 0)
>             warn("Could not set CPU affinity to CPU #%d: %s (%d)\n",                  par->cpu, strerror(status), status);
>     }
> 
> 
> Regards,
> 

Thanks, that looks correct. Please generate a patch and I'll apply it.

John Kacur
---1463804494-2076305359-1565789153=:5420--
