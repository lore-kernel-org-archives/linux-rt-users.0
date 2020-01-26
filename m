Return-Path: <SRS0=Ix+H=3P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2575AC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Jan 2020 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3A52070A
	for <linux-rt-users@archiver.kernel.org>; Sun, 26 Jan 2020 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="glGNxF4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAZVTv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:19:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAZVTv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 26 Jan 2020 16:19:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so8584721wrl.13
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Jan 2020 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=W+1nsbVm0cSPeGcNb729QxN1Lx30Mzxix0uBHJsXjEM=;
        b=glGNxF4orogvIq2I94J2ePvtCI+zr9wr0jLaFxRNWYkP/2fpVeHVaYXFaxJao03hLd
         pxzDeX+UQ4hcqwhaKU1g/8x/DjmxHsq+/EycB/amBZbaWSfsZ7JARImCBwz5+4Me/YRR
         o4JgefluHwzDXaOekePkcCD9VmfHA/JlC/ovEFFPxTXa+SCzapTTBfZ1gPVo7sxcp3jJ
         uYsWPytlwCiO+PFqWOBNy/Giow5ngU7Fl02shok29ZdRJzVbDFJwBeQbhnW5Xzttmde8
         vCgW1+wMZr1wrGSr5Qqp8hPiGjCv5NaWhuueJmT1W3kyIAEk3ifGy5DiL4ZNcuE7LKD8
         pdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W+1nsbVm0cSPeGcNb729QxN1Lx30Mzxix0uBHJsXjEM=;
        b=QphAoIE/EnI/ytWywp6L2TtqpJzu8wZPyCcKyKswYuZyX3ZMWAhyc2vntUaSxH0avr
         iFeQo3yd/Sm/IWRk/EOFk4AAW0CrIMrG0WH12OY1nI+gzozJjwpfgSDYo09HSIp2i2Qn
         dVcrnrmBlmNBjWKntoaIoDOZIT/83Bco3h3WI0PKXidyz/txLXrk5gSF3PUDcmhfoZ6V
         5PyU6E67bYXUxnW8MgXw89JVAL+D8BC8rtkFlHlUkRE9jlcLCRM2jrGIXJP96BPr1FzP
         3naIeYpfZnM1Mnr4KltwjIyQuHTkMacAdWlCnp5HzY36A5IgJR6+Rpe0P8bd9WeedKlX
         0BUA==
X-Gm-Message-State: APjAAAX2mRM+XGedSDOxo4v5zLGyBBRPGUywK6VVdCNxjgAr1vahF4Zv
        EzshgDIiiDJJ7m6Thf5eP3S30dinwI4=
X-Google-Smtp-Source: APXvYqwMe8vSFTGXUaQ4KovzJP158qABoVgugJMpLfobhOJvWw8ltmyEn7rtV/S4BZPXEUj3NxecWg==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr17413499wrq.331.1580073589063;
        Sun, 26 Jan 2020 13:19:49 -0800 (PST)
Received: from localhost ([90.217.157.96])
        by smtp.gmail.com with ESMTPSA id l17sm17291292wro.77.2020.01.26.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 13:19:48 -0800 (PST)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT] mm/memcontrol: Move misplaced local_unlock_irqrestore()
Date:   Sun, 26 Jan 2020 21:19:45 +0000
Message-Id: <20200126211945.28116-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.16.4
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There's no need to leave interrupts disabled when calling css_put_many().

Cc: Daniel Wagner <wagi@monom.org>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b6f208c5a6b..1120b9d8dd86 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7062,10 +7062,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
 				     -nr_entries);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 
 	if (!mem_cgroup_is_root(memcg))
 		css_put_many(&memcg->css, nr_entries);
-	local_unlock_irqrestore(event_lock, flags);
 }
 
 /**
-- 
2.16.4

