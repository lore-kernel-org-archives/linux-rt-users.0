Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C6C4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC612084C
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 08:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ8+yibG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfDBIi1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:38:27 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39619 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfDBIi1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 04:38:27 -0400
Received: by mail-ed1-f49.google.com with SMTP id p20so10855808eds.6
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Apr 2019 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=/1MgZnPHvsBHj03CStUMXNcIpwKSqo0xE2/WEOq88H0=;
        b=MZ8+yibGR36yOXVGGZ7uU9U1eJTSyg8aX9U31u5y8KDCj76+5mZacg/Gg9+ULosGft
         7rkIIRZOhK9of5sr1AWaaWGMTKO6i7erS1EjH51yh8HJPTsV09Hc8HUFEb83izdRhcaF
         Vx3LeJH5MeT2Q3s86iwkX6LbhsTO9x9HDXi+TZ6tNWG/Ar5iKDryaC+BFX3HP3sSEK4k
         7e+cyDrr9yKvFIaD4+cxpxS39KnowCi7r3RfsU4HpythDz19SWj/JG/ZMq8B3KLH7vyJ
         yPjAKqgrodFhl+LmZ3FJNfFFMlIWv52+DrW+5ju+RP5eSpzkLxedrI1PBboIseaDuD1M
         db7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=/1MgZnPHvsBHj03CStUMXNcIpwKSqo0xE2/WEOq88H0=;
        b=hLRX8XjnMbJrxbUopj9oMve9NcHOIPL+QkpueAjRiRooL++JJ5RIt+Vw8/F2r0UpVk
         waSgCg3cc28EQXffvKSS0t3E+LpDBydss9O/o6Om6vp9zeYd1ousTUluS2Z3l9EUIwXx
         ZoEeiceYlE/HK0e941QQ/1yTRT+kF4vXJGvCBgZCpPGtbR5uXozt96HMOfCOLCUiDsEN
         bzNpRRzTT24QaoRgaPw6nTa0y/0gSEaSYlEL7Udv4Hiw/ORDSrg+TxcCA+ay+/DP00kR
         mIWRQ0SUOuL9eOP8ySjnr0Vrfrn8MklsjNVt/7D2DcCbIOMi8rkdCDw0OSpiNE/1HnaN
         ocCA==
X-Gm-Message-State: APjAAAVD21kGB3ZUCA1i9e6T8lNg3HmfAsvbS8TwKlzWyjkfHP8+xOIG
        6w4yOYTGNmFfp0/pxGGWXCQlJ3Wr
X-Google-Smtp-Source: APXvYqz51RxZMZDJXSSVVUauDOeCZGGfq2PUho2EduwOCidNx+AkBVwYHXTC/gBoPIYDIW2+z6ZpHA==
X-Received: by 2002:a50:aa31:: with SMTP id o46mr23709004edc.6.1554194305150;
        Tue, 02 Apr 2019 01:38:25 -0700 (PDT)
Received: from localhost (82-197-216-99.dsl.cambrium.nl. [82.197.216.99])
        by smtp.gmail.com with ESMTPSA id bz3sm2361927ejb.52.2019.04.02.01.38.24
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 01:38:24 -0700 (PDT)
Date:   Tue, 2 Apr 2019 10:38:22 +0200
From:   Mart van de Wege <mvdwege@gmail.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: EFI and RT incompatible?
Message-ID: <20190402103822.31608037@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I compiled 5.0.5-rt3 last week, and after rebooting I found that
efivarfs failed to mount. Loading the efivarfs module gave me
a 'device not found' error.

Rebooting into 5.0.0 (no rt) and efivarfs automounted as usual.

Trouble is, I have no experience with bisecting between two different
branches, so I have no clue on how to start debugging this. Anybody
want to throw me some pointers?

Mart
