Return-Path: <SRS0=1+vS=TX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E5C282DD
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 May 2019 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C178720879
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 May 2019 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StKOlD/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfEWMzU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 May 2019 08:55:20 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:52145 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWMzU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 May 2019 08:55:20 -0400
Received: by mail-it1-f182.google.com with SMTP id m3so9489641itl.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 May 2019 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=F2xGatMEn0etLodr5h54dvC6rnniTpir/8GipBauVlo=;
        b=StKOlD/eJDPIMzNV//nvSVeG2pUatizqDXFSBD4PXMa0gNrxmUn9/55NTJk7Pw/sKH
         IyW97hNz5mR0qruZ3kmdEYrtldFEQpPAbBJxdrlee7SDibFYOQ1gZaWWYRjrU1sdVSG6
         0/jzmvpg/R6TNdcNmzKDSVK50dSsA0DNAxquEkcuxQgk3do2vBw/Q/4JlovpQ69VHQMK
         P+BMHz+9V607p7WPm9ffzmPM4nbmIeJFHwujx78PPrXi/HJsTtRKzMlhp1UIVO++1VeH
         z3ZZ0fWLXG7yuqLXGjAOxa6Hvzh8/PSlDwksbs0lNNL0ELZSbUHIUo8JsdRZfDqBGAQe
         U/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F2xGatMEn0etLodr5h54dvC6rnniTpir/8GipBauVlo=;
        b=FUC0vEmsBXDX8U1swR7QhAt/kRoto5wsyaDpmKP9VJTMJ9pU1gVxYq3Sgk05D9UArE
         v1a+b/7QJqjZ6KuNy8yI/8OaF3dSdKpS5F1mmnPn7c0EMBfuP3sjXT1dCNCmEY+vyagg
         PNSLBxhMZWzEZVgA703DCvCY+bdLYz7dCOvWZ2qdDL4PYYoX4vb+ROYYol7jpFKjGYDC
         3R4h4d3hrZ9mor4thcE8BGM/XIYDjq1kEOPXaKWwYpND+oaIVGLH02irNYQq5948ZJOs
         v9QCzHEPpmgjVdosC3hAEiLka2US8jRDouK8gyYfl8/nQ0BHWd+F1lqDwB9+dTcTVOQH
         jUjA==
X-Gm-Message-State: APjAAAWR3jfiesXRlMVHW2X2wef4oYPueJ4YY5UOfKZGOhXxqNLcF4NO
        OoJvc7nhGZIxZA9R+9JOZypDHlZYuCrbQopdcdczVFw09P0=
X-Google-Smtp-Source: APXvYqzXi/HQbJYihqfIzHsR0Rqr99qy91XteGyVmYRf0/+Dokz61tmfwDET+fqhH1IxWBk8zd/d9Chpv72W1pD/Q+E=
X-Received: by 2002:a24:1416:: with SMTP id 22mr12774761itg.144.1558616119154;
 Thu, 23 May 2019 05:55:19 -0700 (PDT)
MIME-Version: 1.0
From:   Michel Macena <mmacena.eng@gmail.com>
Date:   Thu, 23 May 2019 09:54:54 -0300
Message-ID: <CAL4zHx7Byude2QQCLbJkyMWLHtHC5yC5F1y0bG8COHhAdVOzZg@mail.gmail.com>
Subject: Boot problem
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
I built and installed a Linux kernel 4.4.179 version with the rt-181 patch, but
when I select the Rt-kernel option in Grub it freezes in  "loading
initial ramdisk" screen,
do you know what might be the problem?
