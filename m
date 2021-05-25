Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21811C2B9F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C1861415
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 May 2021 03:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEYDDf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 May 2021 23:03:35 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:1249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhEYDDf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 May 2021 23:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTuYgKKQFunqjOFyL4hr18ZXBAuJXI+D7yGQ6rdpvu7W4bBdZ61RMfht3CqjDdeq1ezABiGGaKAgSSzlnolqfl3J5Q2WpJKv7ewNp+kNOc3WpSFjCddCqywzdy+dbws30vwUUM0Rt2sWv/NTKO89ihbqO16vUK0R5cgkbGUUy6YwQNSsvIBtN6VP60clSXWBKbZxtW9HJ3WTevEnxlEOrJwwmU6Oxb4zQAYbdON3nXdx+KqY19Px9Bu+PoceTdVYZ0XOQWqrbBLVFKem8mZi47FIGP/A49o1GPCMhGPnjEyPBRX1aURHMZedfbi6ivEC8dnOkuS0g7/BZ7Ao3FMn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7pzvnM2UORxzn4VOpWGfTTUslqle1iSUUqAGyS4I0o=;
 b=J2d0aSGEpFEAzqWp6BSmT6wgX66BhPiuLBvx7Cl8DkoXqxU0B2yvKgBKjvNqT64bLoTdoCLVtROTs0yOLyfkncHMtNjqW5IxpRnpAxNEkZiwmdmbBxrT3Z+StcdjUdIuTd5m0Uo6Wq2BpC/aWCYVjcBC92DbWibzaVMZ2H1JnC4TB80OzYHR6DkIJ77xegNmi08jtEnJo9Mwq1AeCP2ZAw/q1Im3pouzIAC5L0zyVperqgIMIVxxDxq1FZSjd+grTP8Z78d2YAVnazemBcsxWMNmVNh17y3U5rl9ZqTl7nvD0uUUzQn7aYKuzmNDy17xbsXelfqjzKyOlQMRJssE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7pzvnM2UORxzn4VOpWGfTTUslqle1iSUUqAGyS4I0o=;
 b=tJ1oFAfFhwvTSP8XYm+6HuZovLcmpFnBbf5gm44UvO2HPqamq8TzM2+NDf/QhU/x1U7azOS6CVIbo66N7wHuSnTwcDW6O434UuzZrpwiDH829XdIAt8CfzHAXNv6y9wsl37PBSNZx2kQyEvCDXxz4D5dGIXRtJw/LmWhJSKlhq6xMrJfy8l1qx3RVo3wNxA3CKXLEvMA7xeI+9W+FilEv6Ok3ct2ZurmatTT53Viwm1xB3LHYHw7vKfDdLHRh7tSbrJs0y3uZC3byZUFq7wLEchy95OMmEVlKGh8bXN3XZEQQpZCUIwd1f1DZmoGlsWuAqmZbltWTvGgGkfcibi2Zg==
Received: from MWHPR02CA0003.namprd02.prod.outlook.com (2603:10b6:300:4b::13)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 03:02:05 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::7a) by MWHPR02CA0003.outlook.office365.com
 (2603:10b6:300:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Tue, 25 May 2021 03:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 03:02:04 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 20:02:04 -0700
Received: from [172.17.173.69] (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 03:02:04 +0000
Subject: Re: Multi pthreaded RT application - mlock doubt
From:   Dipen Patel <dipenp@nvidia.com>
To:     <linux-rt-users@vger.kernel.org>
References: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com>
Message-ID: <54ddc471-9bef-8a91-b82d-3c11412098c5@nvidia.com>
Date:   Mon, 24 May 2021 20:08:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a6be36-5bfe-48ab-9f1e-08d91f2979e5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB536406ECE5E182E090193514AE259@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYn9VfkxJbJ2TXJmIazkSYoUQTAdPtcjQI0U73o+sGlhdjeNCU+NmC3moZFpfQOUwPAR0Fno07oCfLxcuAGrwK+FL8WjoybjEeRXOyB9vfV80u6/KSS9+fTcWe/QpAQDuR4a1c8uTpd2HAiamBBlaI4O6wLQLHoN8Ywvr7wrjrvC2VPcMLjnWrp5XZK3if9cHCI4q8e6OoiDwkO+lDKaJNs9k+c7AcAqyKtuKNLxHCF4MSnmfQ6uisJdhzghdAAnpvEQNV2Rlp8j7/KyDg75477ECJJTdtnfxFo3xVvS2CFZgEV/aByUjzmDE8JkrVucbUwgMhbYWnIWYYXpSg2lSsnShGejwWnsv8UUzGEtM7A1ZtNjBgJYIrixjo0yYB5SLSj/emt09ZZV7c+N10kCaS8w63iVUF0FUL7CDiMhRl4D3P7ja3lqhRhI9+NUU2Do22b/wqa4xJWlTt+uT6syFcA7BfVcVkzX0hyeerHa78LzeUP49H4sqZTuHmxTTqOk65HqaKpDbWaPwvNDTdRVaClohHii+0tAV9UfvExusZirOjqytQG6598vHs7T1Q+US2wRTYOuV/2GfPaBlChYbb2XTlRTDwfj01QT1N85PLH88ns5yhLt87dONase9mXnZFdJGKa0zXD5gQ/wH26xuzRoO+ZPACiVDS7yaKx02i57QqGzDSNMlnklyzGVMHAwVe1JEcV+KmtvzchsnYRNFLR79nePLCls06rN9eQbz6veUIKXcn6CAGFrYRJ/1ndyOX3jjOnvnt5Ew0KWM5prm7OTEI8TVe4QRbObwHdk77gkGHmSHvsuoGD9leSZQVdh
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(16799955002)(36756003)(82740400003)(5660300002)(4744005)(86362001)(82310400003)(83380400001)(7636003)(6666004)(8676002)(16576012)(316002)(8936002)(6916009)(356005)(53546011)(47076005)(2906002)(336012)(31696002)(31686004)(186003)(426003)(478600001)(966005)(70586007)(2616005)(26005)(36860700001)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 03:02:04.7688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a6be36-5bfe-48ab-9f1e-08d91f2979e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Gentle ping on my below doubt...

Thanks,
Best Regards,
Dipen Patel

On 3/31/21 7:06 PM, Dipen Patel wrote:
> Hi,
> 
> I was following https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memory_locking_and_stack_handling_example with some below changes:
> 
> 1. Added 8 threads
> 2. Moved show_new_pagefault_count logic inside thread function once thread starts running as below:
> 
> thread_fn {
> 
> 	getrusage(RUSAGE_SELF, &usage);
> 	
> 	print and save usage.ruminflt;
> 
> 	prove_thread_stack_use_is_safe
> 
> 	getrusage(RUSAGE_SELF, &usage);
> 
> 	print usage.ruminflt - last_saved_cnt;
> }
> 
> I observed there are still page faults (although not in big numbers as if there was no mlock), after touching stack in prove_thread_stack_use_is_safe call. I played around with MY_STACK_SIZE (from 1KB to 1MB) but still see minor page faults.
> 
> I am running 4.9.201_rt134 kernel. Any idea what I will be missing?
> 
> Best Regards,
> Dipen Patel
> 
