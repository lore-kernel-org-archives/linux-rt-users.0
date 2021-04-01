Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B9AC433B4
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Apr 2021 02:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D6761029
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Apr 2021 02:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhDACB4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:01:56 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:57057
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231620AbhDACBm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 22:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/4ETTmTmgInrxUV5+cTPhEFVkHamEHfssyZ0rjk493p8o7tPNgwqiBR97OJH+iFqK1pZKWLR2igS0488QGrAg5iTterF8d/DFW8E1fEz0quAd6CSREQ7UuZrX64mkziB8mr9i+y8cKu/gB1Ch4t66hlmXV/7XUyt3+ISI+MLMiY1i3Gp9DhRFkf1/teknVFrOZJ7xzcstp9gIODiRbnpz/nJZq/68wqS/CaXoaZOtF5Pn0I3FEHiZD1UPTKa5HJ/y2h+bdxWGaGTxctn9yy247FJv7DG4Zg60f8hUz5pYxjcUUZnj6I7Bcdl/9mS+P64/JruvhLdmvZu+S5qcFSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPg5h3BWuS9rkID8LkX3HS+dA0/IBWq14A7papfk/q4=;
 b=lHyANP86PBiD+epwqSjsBMQq6U7L14ptOKMstJhxyrbXT3OqAyd7BcMePGPkVCIF+Cuxiy2qU55+3YgWjbJ8LYL3Hl0vGduUtGEBzlEDRYJ5J+P4uM404y9KADLqEsYblF0QHVpVUk0yw9kjLi946XILihWsJm+Mb9HREnZi+ehWlWzdFgsm3P5uOQD7qDXRvihMrQMzl4PKlXzR7xZ5WuSw/VkYK/+meiaV8JeyB9Yh4CL5Ubk04KptFvg8w74g5SXqO4FyuSxjhEnwqbSOBMECV3DMKg3Ap+r2/ld8TLvfCO1LGKnsvd1A+b4CSt8xY43uytO4Kfiul3pV68DGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPg5h3BWuS9rkID8LkX3HS+dA0/IBWq14A7papfk/q4=;
 b=SjMkH4HfqCDy7fa9zIsppDvzeRrcBfDcs7rJfWwFaMyuqh0fKQ+Cd20NYHIS9GnTJta4LcQ09UKxXpxQ1ypWalYu2htzs+1AncMn0gIQoVY1RiBySTxb6nsHF+CIUpEzMZ0hL5GRLPH0vByjnWfSeN4KXArMs03VwDSMaHXP+V6BkYvYqLdpIYJcwd1Fn0wMuYdXbJBz3V8HA4ZPv4RxatvPn/BnXag/DiDuSvP7KqyI+KznIsRYYzFMkhBqq3EGIhGxQS0gh0TAujSSPZP2MtILauLHmDlUhM/hiYvB6iLOZYTVk52bn6KRKAXvi6DAM14wXG7iTvz8U/psks/GGQ==
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 02:01:41 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::5b) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Thu, 1 Apr 2021 02:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 02:01:40 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Apr
 2021 02:01:39 +0000
Received: from [172.17.173.69] (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Mar 2021 19:01:39 -0700
X-Nvconfidentiality: public
To:     <linux-rt-users@vger.kernel.org>
From:   Dipen Patel <dipenp@nvidia.com>
Subject: Multi pthreaded RT application - mlock doubt
Message-ID: <896cf71c-f610-961a-9d30-8a82d433e0f6@nvidia.com>
Date:   Wed, 31 Mar 2021 19:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e79b833-fb7c-4d0f-4052-08d8f4b21765
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR12MB31449E7B349A665C7AD521F8AE7B9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZcRZLB7NYNakymF4bZ1rjFrJk0kp/8Be1MwBWnETbSL9mSNp2FTtoK0Ag/RkqLcMjSxQsZGF+V1xTRwsq4MSuUlgcsF8jq9te4PSycnEHNU/DWgHTMODA6FJSEV8RbZyZ8nSTNjIuWJb/fGP0x2+VFq1N8KkuDE1q5lFzdHzvEFPUF1UNuTId2qamqEKxtiHsz2U08dWqZ8/sxDnxymHrIS1YjaNhRhDbamrDcJs3cl/Y8/C2oQWE6PNDQAJMTYYKSan5XgyVsLlpJT77P7RjwTkeakYZZDlOJGneVcZj5eHEYHslSCOOII1B/Og9HlOHGKkdOaE4MPQvsy0ldoR1PUv6zLUkGoUO81akPQ4DrSQoPC9IkADCP4pUynCOvRKUvBDcWaNhHsEPrSqX3LnPMOAyuybZ15LnxUweUBTul0r5KLE+ZyEQaN/6Qs490wAYFfWyN+AICXOVPhiFQC9soEyFHpgvALIHoXH4hMV8DCnXmMsHnEq305MlY+jIgMTGbojODL2qLajt+q7EVGs1beaBEHhT/amPVXtGN106NRs1Gg5y2jrKEPchn5Fw4GKvEMyv3BB5SLT3IznnOHmrCnG3spmsF4rVYYirYj1P6NWV6T6tP52ENPGbRU4YLlymlxLUIDiVB8eSVel5Ve1SoVL3hANig2eSLuj72Plz9CQdU005nqxUgfsrfyC2hT4/i7dTsZJfqOCjbVRja7ZbiZ/XQl/TjaX/PcIaPuvYRb/QGF50k8IyJpA5uLKXTVXOTVk0JbnUf6+lpnnODr0w==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7636003)(356005)(16576012)(86362001)(47076005)(31686004)(70586007)(83380400001)(2906002)(82310400003)(5660300002)(36906005)(6916009)(966005)(498600001)(8676002)(31696002)(4744005)(8936002)(2616005)(36860700001)(336012)(426003)(70206006)(16799955002)(36756003)(26005)(186003)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 02:01:40.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e79b833-fb7c-4d0f-4052-08d8f4b21765
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I was following https://rt.wiki.kernel.org/index.php/Threaded_RT-application_with_memory_locking_and_stack_handling_example with some below changes:

1. Added 8 threads
2. Moved show_new_pagefault_count logic inside thread function once thread starts running as below:

thread_fn {

	getrusage(RUSAGE_SELF, &usage);
	
	print and save usage.ruminflt;

	prove_thread_stack_use_is_safe

	getrusage(RUSAGE_SELF, &usage);

	print usage.ruminflt - last_saved_cnt;
}

I observed there are still page faults (although not in big numbers as if there was no mlock), after touching stack in prove_thread_stack_use_is_safe call. I played around with MY_STACK_SIZE (from 1KB to 1MB) but still see minor page faults.

I am running 4.9.201_rt134 kernel. Any idea what I will be missing?

Best Regards,
Dipen Patel
