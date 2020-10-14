Return-Path: <SRS0=pHqT=DV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB50C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Oct 2020 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3B220B1F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Oct 2020 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="QLdV9OrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgJNQiD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:38:03 -0400
Received: from mail-eopbgr770059.outbound.protection.outlook.com ([40.107.77.59]:45635
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727020AbgJNQiD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Oct 2020 12:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YudW7f9I0o/ZN3vcDNdDgpw6uzuQJHBdX667c6ZoWpuAA8vPHtnIqpQC7FmI1ixH19wAnLCObbNFL8G/DRBNU4iLcuxTIAT9ZnOPG95QR1p5l2VrQTKqIKjL+kYptBwAkfxpj84mobKF3Eppv8PU7gSui7vH93mLnhRZXYQhXL7M9RutWTpt0iSoPO854NIxffrmyIXJyzzy3Ho8XvAGCKWDbGmjZYvYi5CrcZJ1dyfu+oUWKOI0yymfTMvEsI+8vToYAOgxHujiIIsfBwDUoPFCYT3XpGFSM6099Rqp0gqJFWK/TE628hnkgKm+8ZsH0c1whTHKbOkTOQ2Gx2PgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX1blAQvtn2h08XXqAY/LK1hbJw77zg6rbEPZQHuTNw=;
 b=S7NTMHyJpHIT3WusJMN4ZVlxcfbFL2xZ8aWk995Plc19suyr3uQCQKcQCjOweAEl8U7QMzl9SoH9CR7cX/Sr/VeGzd6VxNff1pk01opFOLoHhzgeZbLm9D+6v6+jaXD6wFC3buPvGifSkAD+sBAPOGN9+6/7OkZ46S9+3hab5vXmw/PMtapfg7QEvYB+Qgy86movRTcx98hOJbfWaSFoOjayjaPXHmUmbg3hvcxWb70qjzdYLpWYrznaESwGPsSL8Hf+GlU/iJ8ktkFxo666w3LHUg8R611ww7pr5gs69kTIFUXfVH3+8vRu3e0Zb0cLgw8ONulAJhhhjfuHk3DViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX1blAQvtn2h08XXqAY/LK1hbJw77zg6rbEPZQHuTNw=;
 b=QLdV9OrPN62yNWSQOIdKe5zgWewx4gDHwNw04kn8aq51EBKYrjisgaqLqSRrXTSucNTYVRKvfYH22ofBM+A6lKA7akB7BRbXPDMaHuPziVWfvipYNybL9Fl/1NpXjw/bSUD3x2Z01GaAGiZrEU9xpo/It6ql9gCTMF21HDpsCWo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2870.namprd11.prod.outlook.com (2603:10b6:a02:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 16:37:59 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 16:37:59 +0000
To:     linux-rt-users@vger.kernel.org
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: high-priority RT CPU-hog applications and kernel threads
Message-ID: <f1441440-1c54-0ff8-eaee-4f7330e0a8a7@windriver.com>
Date:   Wed, 14 Oct 2020 10:37:55 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.73.216]
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.12] (70.64.73.216) by BY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:a03:1b8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Wed, 14 Oct 2020 16:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce75a6c-7b4b-4d43-32bc-08d8705f82f6
X-MS-TrafficTypeDiagnostic: BYAPR11MB2870:
X-Microsoft-Antispam-PRVS: <BYAPR11MB28701C75F3AD4CF2E60661C8F6050@BYAPR11MB2870.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6okPd9bA39o4/SRCjqH+aS+eEXi8orwKAYxsuThpwkViJx4GcFZpkV6fUYp36Sb3DHF4NhzmCWXOFbrPGXQ5pa/cfRzmp8K2AZQNKrzfNvCaJEqFpJQedsMGn/lYt8bj36gxwZmG9049db6lIaWvt/I8xIv3FA/ama2xNdnmAC5F8gFd5cwlAz4phiGImYpRhy/qeo3+j+vu7Vctujw2q89EhtpceIM7dNx5C2R3UXn/1qUCGwDkZ8ren9rqK5EYtkV90txzbE2pS5K3R2592E6GbbPLxtSy3eJzZk3IC1CNKiey+8Qhc3SPxnwNPY4GxR5cG17i9wN04UeXzncZyKHQEAtr2M4u33n9pXMVOwxM/ZAzfRimuFb1WpQus+Di
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(366004)(86362001)(478600001)(44832011)(6486002)(5660300002)(16526019)(2906002)(6916009)(956004)(31696002)(8936002)(66946007)(66556008)(8676002)(66476007)(16576012)(2616005)(316002)(186003)(52116002)(36756003)(26005)(6666004)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N3OyH2fQ/LUpI/8UKbKRTJFDyF21npbz9G98crVlhF2ts5wB6MISZ4jMQUtbXdE+mAIkoUVfVWHI6zF2BagQSgyEgWMESHi8lcJBCe3wHJqeoZynm5j2kk0jbx8yaWm9dAQZVNen3kVHQINCASaIIRquJRA3dNt+72JqAiqB3tpHUZHahtr7QfbAacnXaRKrJWCQW19IRGu8dtplnidOOpa5CyrTGz+aX1vfN/hhUuLXFysGEK7P5lqsucM2acrficcH4P9GHjYoVEDJMXSU99/Zw0FyGzKdJYuH9nDLA02kB/vex6waBX6Q2TvQA5G0het/mXvGvompC/1VT4lE6eS+wOi+vje5Ly9qG6ox/K+BaYm8M6vEg1/HchRTQ7RJhyyNmyoi2I1bSJEl8PzP5vw+HjeNRv33WCyj/o4rNJ0J5KsMkpfrImsuSEGrwZnD5hKrbAjx+IBQznial/E1TiQWM3bVWrJ8uhyraPWcIGEhjuG15E06gsH/n1wrpzADX47z0RIdyalO1e4lYD81CvMUvZLEptuRd3yWblZjPhrl0lnliwNUtGIJZ5X0CcYMN8yHsdjBuvZXQFChYOJon5WTQgwFrippKcyj4J6yHOfJClkqxgh5N2azUN+9VwKhdIefmYzpHKAeFZYd7sST6g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce75a6c-7b4b-4d43-32bc-08d8705f82f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:37:59.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I31kcajDqw0rdrO0eZLH5KBD83RBdR/nGicaL9+7Dw0+9Lg8zRR8GznjdPP0HFwOXKDRPnw6an4khBFHec5R+msFp/V/PnEi2xEbGgajpxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2870
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm on the CentOS 7 RT kernel but I'm hoping the general principles 
still apply.

I've got a system with a number of CPUs set aside for housekeeping and 
others dedicated to low-latency applications.  We have "irqaffinity", 
"rcu_nocbs", "nohz_full", and "isolcpus" set up to try to isolate the 
application CPUs as much as possible, with RCU threads affined to the 
housekeeping CPUs where possible.  (rcuc/N is still on the application 
CPUs.)  We have CONFIG_RCU_BOOST=y and CONFIG_RCU_KTHREAD_PRIO=2.

One packet-processing application wants to run in a busy-loop pulling 
packets off queues and shoving them onto other queues.  No actual system 
calls that context-switch into the kernel, only calls to get a timestamp 
which are handled by the vDSO.  Testing has shown better jitter if we 
run this higher priority than all the kernel threads, but I wanted to 
make sure this was kosher since the various tuning guides seem to 
recommend against running high-RT-priority CPU hogs.

Is it okay to run the application higher-priority than all the RCU 
threads since the bulk of the work is offloaded to the housekeeping 
CPUs?  Would we need "rcu_nocb_poll" to run the application 
higher-priority than rcuc/N?

Is it okay to run the application higher-priority than ktimersoftd/N 
given that the application doesn't use timers and nothing else should be 
running on that CPU?

Is it okay run the application higher-priority than the irq threads or 
is that a moot point as long as we affine all the irq threads to the 
housekeeping CPUs?

Is there anything else I'm missing?  Basically as much as possible I 
just want this CPU to be entirely dedicated to the application, with 
nothing else running on it.  Most of the tuning guides want the kernel 
threads higher-priority than the application though, and I'd like to 
avoid that if possible.

Thanks,
Chris

