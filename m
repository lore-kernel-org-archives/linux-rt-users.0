Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812FCC77B73
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 May 2023 08:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjEaIoT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 May 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjEaIoK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 May 2023 04:44:10 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58B19D
        for <linux-rt-users@vger.kernel.org>; Wed, 31 May 2023 01:43:44 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V713DC016634;
        Wed, 31 May 2023 08:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : to : reply-to : from : subject : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=/uoIvEKF5xEHgrcz99UawMiEDO0TBPy2BIHr5K7r1xE=;
 b=Cvmvg0qRVYL2VJbpDWEpogJkUstp0ZYVABGC94Z428D2ODOffPv6uy4+fzzhd7WXFmUb
 i0c3gWPlT9AAE8GxC6QBEU7Jtkb1HmIAulmey+5CEn460wAxMZXXcGmbAe4oKug872DQ
 JZ7A1LCDV0aEEB+jH7zERQsVsgZylRp1dFx0AcfVdOtD9DmrrT9lUr2QJOqpWnflbduz
 bUn10MBmpgdkUnWDGmdKvdJSg1k31fM0ofeodvqJ+CmLGkEoWeHCNEZUSU7x6meft7QF
 4dQ8af9ApTYiEKVPNbEtRqH0RSbPnQCcm64dBht1Q9WQ3ceUpU49uxwkihPAoLKx0lHV 0Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qu8u8kgpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix94zUnz3yRPN+ONtMVpRqW2+ecizuKOCoUTDFyrfCwCPDkGX+oBotHB98W/Iu3N+Tux77riTLe+j65hvokQydH2apXKUvnkDmTS5sEy5pqnOHsPj8x59vp/grmps0l9+pjVUQQq8hAUQuokXhAXTcCj++hNuuqaO4RKFhGY9cwWPIjC/qThcBGVRrUK2pJq50tNiS94J3kK1S1Styi3b6THSnVk4aK57F8kY4RcmnbC7gxl9J/vmak1SN/Og+zb3SNev2qEM9A5s80nJdoV7Xeo0YIsEuOV3uGqDwn9SiMnKwvRedEMN4o9yBzipLDLQ85FccOIcgFTBUwsCwPeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uoIvEKF5xEHgrcz99UawMiEDO0TBPy2BIHr5K7r1xE=;
 b=dGmPRtEnyTg2ezAWCDe7pPZAUkdrX7KJAgQ8jEo87uahAi2y+u+s35dTR8yGGfbGPz30RrY4EVmFgknNvvpzMMGd4b69mvjY80vChVuGycBlPGmQiqtPEaDIr7VbqpdAFlqTJfJit+O6tmHqAUaKa1srtvxYqqRjI/3CzvuCratni6RnzlKC8sDztSTJI/Nj7XQ1Zq8T4q01Qgp53PM51qOD3jffKH4jMYOGlWh9b9FpFqH6T/FDdy6RPsEVWr5nYhduit/FncDRJEX4QwH0Z+az3mL9UuNqqP8EOe1BoSvnxjaqcQUfDpkxRny7wJe4kx9VOGcjXU6JQhoJrvz5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:43:20 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::6287:f818:92ac:40fe]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::6287:f818:92ac:40fe%6]) with mapi id 15.20.6433.020; Wed, 31 May 2023
 08:43:20 +0000
Message-ID: <e15710ff-b64f-f382-8de4-7c2b8f8d445c@windriver.com>
Date:   Wed, 31 May 2023 16:43:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     pierre.gondois@arm.com, efault@gmx.de,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Reply-To: 859aadda-c971-d16b-44a1-4e15ef49bf8b@arm.com
From:   He Zhe <zhe.he@windriver.com>
Subject: Re: v6.1-rt4 rpi4 boot time atomic_sleep splat
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca50864-20e5-47b2-9eb3-08db61b315df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jp/BHd0hql1zbjCxg9CXgWbRv+G1DwkH/eQBCMFTy3f7voe/8qTLqkgjvJ1f9Gs1slicf3dgye4RI+aF90dlOGX/rv/9BQ2l2qoWchuSZ0T/NbndiexqVXQBkQ9BCP7gAfeno0Src3bGCA3lChJ+QSMh40BQ8UUDrkLpcFDU5oDAcnBLpHEouvDvoq+ztRsjTVMF9YAkrqWNicoPn8V/XFjeeLZRz/QFsILsfmtiUwaQeqdnWnR+jXlndMVgNxAHLIdmKgkGmWlQCg4cKY5QmaCcRRAo1zA2eoxWIkDZXR5v/U1M4wp7M0iCch+Cz05OkJpGqHv1ZMCGv4xgN8nKysGfmzMRzJLAGdjTXza5MmFVgCs7w3rGs780ZtLJpuoQ9qnUHZI2IP6CoYpstSX89kmk08soWB1En0/p8AivaofrPtndErln3I22H/FJKjZbxq85PBqxcGsxDtVKvOJMaoDu1trkJ/ezm8wNqw3Ht1qcBuAYf54u3GCo5Xpb9ZlNruEWfH9hMDR3YQI26eVnJ4N3ekmSBaJtvQK0woTro8GNw8lhb5o9xs+ePToZfCtI5ju8P3k7OuzCsW2gZmuQqGnrUGFQdI7dQgGpAwvE5dqal9rZZkVYMPNAWMX4FvuTDBVZuOl5RCVptzdfq3mnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39850400004)(451199021)(31686004)(26005)(6506007)(6512007)(36756003)(41300700001)(186003)(83380400001)(316002)(110136005)(2616005)(478600001)(66946007)(66556008)(66476007)(8936002)(5660300002)(8676002)(86362001)(38100700002)(6666004)(31696002)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNGYmNUMXI3eEpmM1hYQjFhN3RBOTg3WmRRd1NYdHo0WkNVV0d4aDJSckpa?=
 =?utf-8?B?djIvMWF6NjBRSTJ1Y2o1SGFUUi9ldWFIYndwSHMrK0NSR25obEVwZDNnbFVk?=
 =?utf-8?B?T2tkUjNUWjMwNG10TTl4ZUNTY0NKNzA2Yncxdyt0Yk15aE04ZUtlUEtFMG12?=
 =?utf-8?B?eXNYRWxQZ0xaVzBMWW91NS8yQjZSenJuOGpRRWFwYVdTNWpkYkxYb29UUEFo?=
 =?utf-8?B?RTYxd25HbGM4NXMza1owdGowSTBRdUJCSGQxcCtxazRqbU1KaWJsTnNqQ1dU?=
 =?utf-8?B?cTJ0RDFpYjR6bkVSQU5zcDkyUm1IanZEZE5qTlN1MzFXSUppNVl6MVNuVVQw?=
 =?utf-8?B?WHNiZkR6aHpFaHZyQ2RDeUFJVm42QmRCSWhUTmtQWkV3ZWpKUjR4dm5CNUZU?=
 =?utf-8?B?aStLZVlFVjRZcFJXVkdvYnRoRVNLVVplRzFhWmZhWTBEZDBWN2dyeG5CbWFt?=
 =?utf-8?B?NFJhR3NlbU5XaEI3K0hyR3A1SkhDVWZFaGVUY1c2MEJOM09ZNmJvT25qWndi?=
 =?utf-8?B?bmRTa09KUm5oQlROUXRoZnlEN2huVGE4MUwyWUQrcjhhMS9ZSTlzV2h5NkFI?=
 =?utf-8?B?a0JSM0huVFhyNkcvSjhQUlZPdnpuNHNrTHZ2OUNySGgySWVhdlZzekNmOVFz?=
 =?utf-8?B?bElWNEhZRGorKzI4bGNTeVgwWHhXYWVEakY3ekJaVThWbVM1Q1lUWVh4Mm9B?=
 =?utf-8?B?L0l3MUI1UFZ4UUNPSVFNanp2WXpaTXFVaCt5eUtia0l6bVNFNW1hSDR0bGVP?=
 =?utf-8?B?WldqbXN3aVhQRS9sd2ZTeWR4Z0wyZEZKZnRuRDlVZHRhUFRZenB3NzBNSUdC?=
 =?utf-8?B?Qms2QVRtSEVoSHhJTS9ZL0RjdVZUTFlUV0xNYThpSXNYZ0lGNlY3ZmtBM1Z3?=
 =?utf-8?B?ZmNXTEpTaldUUWt5cDdMS053L2RNMDR3YUd5Q3NYa2lZbmR4OEZvQ2tpVCtG?=
 =?utf-8?B?Q3FZdG04T0djbUppSTZKZG15U1NOQmtrNDFUMHRsSW1JY2FnOUUydVNFak1D?=
 =?utf-8?B?eUtlM3h1bmdhM2JKN1BoZjQyVUM2Y3d2RHYyaWxQK0lxTExITzJ5Q0ZzK3Rv?=
 =?utf-8?B?eWF5QzBlK21wMUtHWHVJa3BpUUZIVm1QL2pMckJCbDFyQ1NuWVZWK0o5dDBW?=
 =?utf-8?B?M1BWQWkxTnUyZnJoZERXVUdmeDlId2FxSzQ1TnpnZzBFUytBRVJnZ25VcTV6?=
 =?utf-8?B?M0xDZUZXQWdhaVNoQ1FrbnphbDJad0VEVCtFT0tDeWFhb21aYVZDengwVS9D?=
 =?utf-8?B?VU4vVzk1WGdZUlN4Uk4wWGNxdms2Y21hcjYxOWY5MUkrTmFnUFExYTRUQTVr?=
 =?utf-8?B?YmFNd2ZpaFBrbXhtQXVXK0JMVGNUaU83VnlCSjNRYmJCVGxTNWExYkxuK3I4?=
 =?utf-8?B?OEhnZ2NUTHNlN0pqZERYakhFTnRjdU5ZMU5BdGpCc0xiaEhhMzR0YWxKeTRP?=
 =?utf-8?B?YTlXWGx4amwzT2JGenFmcm8rVzljTG8zTUdIVkVTM0kyRUduU2lEbmJRcWxI?=
 =?utf-8?B?QmordHI4VjA4ZTZFUWR0RzcwS01DdVlqSlVyUVErQksvT1J2Ky9EVkdUZHIw?=
 =?utf-8?B?UFlaQzVmOHpiL3JrdlptQXhqajZXQ29mZUdBVlhXVGxCTDB3ZGozb2V3Z0RG?=
 =?utf-8?B?T3NUbmRMWnVjYldKVlpkTjFHdUcwSFVCSjVJMmRueW84R0ZYaDh6Y0VwaTk2?=
 =?utf-8?B?eTA1dHkvdkZ1ZFlYdXpkOTl2QnB5S3ovWXVUOU1saXRwQUM5RFlpWXlmQ3hU?=
 =?utf-8?B?ZUl3azRWcVhyeXF0eXFod2hyQ0VKMnVXN1NsY2hYVjljUm1hbDRrMjhqWEdK?=
 =?utf-8?B?VWh3ZjZ4emlVNlh4SklBUWNOd1hQRnhaSzROUjVVOW9WK1d4YzZVSEViVzlT?=
 =?utf-8?B?Uk8ySzNjM0dMQ3RITHo0aE4xZzczZjlmOUkzTkhNVTY1dTdzdVZ5QWsvanJB?=
 =?utf-8?B?RGhJT3VRdGZCeDQzV3dJeTNUZEJJRkxKTlZ0dWUyNkJnbkVVZTRERndoS0ps?=
 =?utf-8?B?TXNJK0pDVW5BcG9FbHY3NFdDdnh4bXFpdHpjV0M0RkhYd0lIQ1FLZVFOczNo?=
 =?utf-8?B?VW1FZlQ0bTVzNUF1Z2V4dmdRMzROTjVJVGdzNE1yWGFDaXFMcVNlU1RWTVMv?=
 =?utf-8?Q?XPm+2AD4X6uSlK8ANww44yPx0?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca50864-20e5-47b2-9eb3-08db61b315df
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:43:19.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BePbw7h1yQZETTLQ7aa05+mUTzEDRpd4fFY7na/Pzf1xWVrtQPaACTAk4Gvt/YcqoTcO9I2w9cN/Ir4a+dtd+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-Proofpoint-ORIG-GUID: HMo1WxCjc7h-FplslHN2-_lRC-BdSpnb
X-Proofpoint-GUID: HMo1WxCjc7h-FplslHN2-_lRC-BdSpnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 mlxlogscore=589 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310075
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Recently we still observed the same and seemingly similar call traces in v6.1.

Will the fixes in v6.3 be backed ported to v6.1? or do we have plan to fix for
v6.1? Thanks.



BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffc00820ff14>] __create_object+0x110/0x380
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.27-rt7-yocto-preempt-rt #1
Hardware name: NXP S32G399A-RDB3 (DT)
Call trace:
 dump_backtrace.part.0+0xc8/0xd4
 show_stack+0x20/0x30
 dump_stack_lvl+0x6c/0x88
 dump_stack+0x18/0x34
 __might_resched+0x160/0x1c0
 rt_spin_lock+0x38/0xb0
 rmqueue_bulk+0x68/0x920
 get_page_from_freelist+0xd18/0x11f0
 __alloc_pages+0x164/0x10d0
 new_slab+0x2f0/0x454
 ___slab_alloc+0x4b0/0xb90
 __kmem_cache_alloc_node+0xe0/0x38c
 __kmalloc+0x6c/0x1d0
 detect_cache_attributes+0x458/0x570
 update_siblings_masks+0x30/0x274
 store_cpu_topology+0x48/0x60
 secondary_start_kernel+0xd0/0x130
 __secondary_switched+0xb0/0xb4



[ 2381.971932] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[ 2381.971949] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 25, name: migration/1
[ 2381.971959] preempt_count: 1, expected: 0
[ 2381.971964] RCU nest depth: 0, expected: 0
[ 2381.971969] 1 lock held by migration/1/25:
[ 2381.971975]  #0: 869aa87c (&drvdata->spinlock#4){....}-{2:2}, at: etm_dying_cpu+0x2c/0x58
[ 2381.972020] Preemption disabled at:
[ 2381.972023] [<80229ab0>] cpu_stopper_thread+0x90/0x13c
[ 2381.972048] CPU: 1 PID: 25 Comm: migration/1 Not tainted 6.1.29-rt10-yocto-preempt-rt #1
[ 2381.972061] Hardware name: Xilinx Zynq Platform
[ 2381.972066] Stopper: multi_cpu_stop+0x0/0x184 <- stop_machine_cpuslocked+0x130/0x1ac
[ 2381.972101]  unwind_backtrace from show_stack+0x18/0x1c
[ 2381.972136]  show_stack from dump_stack_lvl+0x60/0x90
[ 2381.972172]  dump_stack_lvl from __might_resched+0x184/0x1c4
[ 2381.972201]  __might_resched from rt_spin_lock+0x54/0xb0
[ 2381.972227]  rt_spin_lock from etm_dying_cpu+0x2c/0x58
[ 2381.972251]  etm_dying_cpu from cpuhp_invoke_callback+0x188/0x370
[ 2381.972276]  cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0x74/0x100
[ 2381.972300]  __cpuhp_invoke_callback_range from take_cpu_down+0x74/0xb0
[ 2381.972323]  take_cpu_down from multi_cpu_stop+0x84/0x184
[ 2381.972349]  multi_cpu_stop from cpu_stopper_thread+0x98/0x13c
[ 2381.972374]  cpu_stopper_thread from smpboot_thread_fn+0x19c/0x320
[ 2381.972400]  smpboot_thread_fn from kthread+0xf0/0x128
[ 2381.972427]  kthread from ret_from_fork+0x14/0x2c
[ 2381.972447] Exception stack(0xc087dfb0 to 0xc087dff8)
[ 2381.972458] dfa0:                                     00000000 00000000 00000000 00000000
[ 2381.972470] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 2381.972481] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 2384.412614] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[ 2384.412632] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[ 2384.412641] preempt_count: 1, expected: 0
[ 2384.412646] RCU nest depth: 0, expected: 0
[ 2384.412651] 1 lock held by swapper/1/0:
[ 2384.412658]  #0: 869aa87c (&drvdata->spinlock#4){....}-{2:2}, at: etm_starting_cpu+0x2c/0xcc
[ 2384.412703] Preemption disabled at:
[ 2384.412706] [<00000000>] 0x0
[ 2384.412724] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.1.29-rt10-yocto-preempt-rt #1
[ 2384.412738] Hardware name: Xilinx Zynq Platform
[ 2384.412747]  unwind_backtrace from show_stack+0x18/0x1c
[ 2384.412784]  show_stack from dump_stack_lvl+0x60/0x90
[ 2384.412821]  dump_stack_lvl from __might_resched+0x184/0x1c4
[ 2384.412852]  __might_resched from rt_spin_lock+0x54/0xb0
[ 2384.412879]  rt_spin_lock from etm_starting_cpu+0x2c/0xcc
[ 2384.412903]  etm_starting_cpu from cpuhp_invoke_callback+0x188/0x370
[ 2384.412928]  cpuhp_invoke_callback from __cpuhp_invoke_callback_range+0x74/0x100
[ 2384.412952]  __cpuhp_invoke_callback_range from notify_cpu_starting+0x78/0xb8
[ 2384.412978]  notify_cpu_starting from secondary_start_kernel+0xe0/0x160
[ 2384.413006]  secondary_start_kernel from 0x102160



[ 0.000000] Linux version 6.1.29-rt10-yocto-preempt-rt (oe-user@oe-host) (aarch64-wrs-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40.20230119) #1 SMP PREEMPT_RT Wed May 24 02:08:59 UTC 2023
[ 1.014167] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[ 1.014173] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[ 1.014178] preempt_count: 1, expected: 0
[ 1.014181] RCU nest depth: 0, expected: 0
[ 1.014185] 1 lock held by swapper/1/0:
[ 1.014189] #0: ffffff88000008e0 (&n->list_lock){..}-{2:2}, at: get_partial_node+0x4c/0x3dc
[ 1.014229] irq event stamp: 0
[ 1.014231] hardirqs last enabled at (0): [<0000000000000000>] 0x0
[ 1.014239] hardirqs last disabled at (0): [<ffffffc0080431fc>] copy_process+0x65c/0x1424
[ 1.014254] softirqs last enabled at (0): [<ffffffc0080431fc>] copy_process+0x65c/0x1424
[ 1.014264] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1.014270] Preemption disabled at:
[ 1.014272] [<ffffffc00831f660>] __create_object+0x12c/0x39c
[ 1.014288] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.29-rt10-yocto-preempt-rt #1
[ 1.014295] Hardware name: Freescale S32G399A (DT)
[ 1.014300] Call trace:
[ 1.014303] dump_backtrace.part.0+0xcc/0xe0
[ 1.014311] show_stack+0x20/0x30
[ 1.014317] dump_stack_lvl+0xac/0xf0
[ 1.014330] dump_stack+0x18/0x34
[ 1.014339] __might_resched+0x180/0x230
[ 1.014352] rt_spin_lock+0x64/0x110
[ 1.014363] get_partial_node+0x4c/0x3dc
[ 1.014373] ___slab_alloc+0x328/0x714
[ 1.014382] __kmem_cache_alloc_node+0x10c/0x260
[ 1.014390] __kmalloc+0x68/0x104
[ 1.014400] detect_cache_attributes+0x98/0x104
[ 1.014409] update_siblings_masks+0x30/0x350
[ 1.014420] store_cpu_topology+0x44/0x90
[ 1.014430] secondary_start_kernel+0xd4/0x134
[ 1.014439] __secondary_switched+0xb0/0xb4



Zhe
