Return-Path: <SRS0=5OsI=TO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDCC04AB4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640EF20881
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 May 2019 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfENUKM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 May 2019 16:10:12 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42007 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENUKL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 May 2019 16:10:11 -0400
Received: by mail-qk1-f180.google.com with SMTP id d4so44284qkc.9
        for <linux-rt-users@vger.kernel.org>; Tue, 14 May 2019 13:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCRGPAtlDv/Xl+n6QS7TNgm7PEXiTEv9Os1yuhfu/9M=;
        b=SIFJmQGpy6ZTf+1QxlRYMZoFZfaUI248VNo4bsnnSquAUXlfSTyQvnkSzsZzktepi9
         4baOXeS/6mQYL4ILNyP5TypwsTaN/PY6F2h8Xhb7oAv23lDDGJf4HfODXtnj3nzpneYj
         /QNebHeJagnODulyS3y2u4k/VGGhAQDmpaXEvt9wbTiYfomv1kmYb3h/9f6N0HJVlUOH
         eYNbLoZgK7WcJES75Qg1+ZSlJpJYR3D7Ms2HDdzecU/Gj27PVKzbO2CPfM059TxASjHy
         0NvMtYsUJ+uisoaeN8dnekFic9RoKQQ0H0DfJ0G8S8ISjtpSMfY2iALL3Nro876zGqU5
         4FFA==
X-Gm-Message-State: APjAAAVW/2jinwq12X+TLh+xyA8bsZJOxYZz4BbigTX7gNn1Lxk6rXzI
        EDakeC6I54xAnvotbg2efFuFmPe+l1A=
X-Google-Smtp-Source: APXvYqwWPenGnqCGNJexyBhJwPiaIDE9RhKnzro1mTdGPOymtjaUW0oTH2NevMXKLq35CRAxzYPi7g==
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr29475065qkg.347.1557864610634;
        Tue, 14 May 2019 13:10:10 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host36-54-dynamic.36-79-r.retail.telecomitalia.it. [79.36.54.36])
        by smtp.gmail.com with ESMTPSA id b27sm11081791qtb.53.2019.05.14.13.10.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 13:10:09 -0700 (PDT)
Subject: Re: Real-time micro-conference proposal for Linux Plumbers 2019
To:     Tiejun Chen <tiejunc@vmware.com>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
References: <5ef34142-2b55-28ff-612d-0ec7b0c521d1@redhat.com>
 <BYAPR05MB5878261BB896A489AA521A65C5320@BYAPR05MB5878.namprd05.prod.outlook.com>
 <02b2eb1e-b88b-3ade-1e0d-741bf92939b1@bristot.me>
 <BYAPR05MB5878B8AD281E40A522996975C5080@BYAPR05MB5878.namprd05.prod.outlook.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <19fcfc0f-ea80-1e60-7fb6-f2e40ccca957@redhat.com>
Date:   Tue, 14 May 2019 22:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB5878B8AD281E40A522996975C5080@BYAPR05MB5878.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 5/14/19 3:26 PM, Tiejun Chen wrote:
> Dear Daniel,
> 
> Not pretty sure if I will be there currently but I will try my best. I will work on the preparation of these topics.

Good! Let me know if have any update!

Thanks!
