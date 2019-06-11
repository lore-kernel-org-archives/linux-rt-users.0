Return-Path: <SRS0=DAnd=UK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE0C43218
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 12:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808AB20896
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 12:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sWNIsU7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfFKM4S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:56:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbfFKM4R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Jun 2019 08:56:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BCuHQU010789
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2019 07:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560257777;
        bh=Hco4S6GVqVv0sM7iRsZ/4FM/fYD4tkCTmxSwU+hEuVQ=;
        h=To:From:Subject:Date;
        b=sWNIsU7huxNQiOItEzKrD/cZGQgzTzouFLOV79eU9wYnFwrQqqxPszbWsGx8BRu6/
         0eIkVmsJ8A+pHNi/lb96p7y3CEX81n2NQzrVoWBQmzhAqQKp1Z/kS2gaMOm3UUco/Z
         C6xozMxODlLM+U+sDVyfipq7+D+vFEJAQ+zD8oNQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BCuH0I088378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2019 07:56:17 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 07:56:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 07:56:16 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BCuGEt051543
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2019 07:56:16 -0500
To:     <linux-rt-users@vger.kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Subject: Stable update for 4.19 RT kernel?
Message-ID: <26777fac-77fe-be66-5f85-d708809c2c04@ti.com>
Date:   Tue, 11 Jun 2019 07:56:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello

Is there a timeframe to when the 4.19-rt branch will be updated to the 
latest linux-4.19.y dot release?

This branch is 13 versions behind

Dan

