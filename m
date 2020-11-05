Return-Path: <SRS0=ZRAY=EL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85363C388F9
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Nov 2020 06:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213F52087D
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Nov 2020 06:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="H7QLJ+Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgKEGc4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:32:56 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:43884 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729149AbgKEGcz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Nov 2020 01:32:55 -0500
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0A56ShxX032386;
        Thu, 5 Nov 2020 00:32:35 -0600
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0b-00010702.pphosted.com with ESMTP id 34h5r5c09h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 00:32:35 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CamkrcLkRjKVBx5Se2AXPpl+c3Dcfkaq6npxtATiz4rQ1PE3dJ05KFDmV8PwjftuaNCtAB686qC1IdMV81L5tr3TOSWaly2CV/XTWTAlNy5WD5VN5JCUv6ZbCmvUdaw21vJcDCZ/xEyLudr6nDI2RkDBJzI6AhA9UYLlfiifR6TqM5iEMeDSom+6S9yQIFns3Go7CDBrz+UaZ9vexiH628NpzWgoiWwaOvUTdhJEBZF3XSY8p4ATDcNwsCEUE6ElKWXX1dety46N/EIevR9asU6v5cRdKLTBiP+uoOHoyK5rtbxGq+NL0tBaBgURElHBPd5l0JE/3kiEC4IPAd+QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMb0lCczS6hfpfIV58P/3J+vM3A7eav6SHgvqonElPI=;
 b=aZF2jhUBTbFAI8CUG4O98BnqySDTsBJf3jeiZimHF0CpQ4rpK257gNX/zaf+zNkq2JdhAQZFOjID6FS5MnqxyU1kqmDAbNSlIh2w9BAiJZVUrK+v4R7KDFjVS5TLADlXr3k91kjSvBIfKImwX0XPai40a30jlT3WT4UD8x/EbBLxO1RV8NXfxtcMb3kiCbIZt4S9q1dQ8Gy43pWVcKS0KKiQN1daHOcdyheRYHEy2a4j3DKb2jzXcsaOfYlXY0Zyc3oWCuI5G8loQhISjdqqYuxQM3niwgx6lPkrURuMObtw/oEuxwqXghrGjlZanCtMuUjrr3HBXCLQq1WrDpoB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMb0lCczS6hfpfIV58P/3J+vM3A7eav6SHgvqonElPI=;
 b=H7QLJ+ZoIfABIsh5O9aKpq6sTXOsZIzCC1/XuuHbMoPYZfEdXmkZboLfGd5tjnfDDOPKQYNahDxaaYw6iLp3FBy/vmBiozHdPilt4jmEAWrifMekwCJ9DKKvKm6V9ufUP1P2JNWSbvgdL6vGNj1S3fsmSerqS0h1MGVTomh+Gyc=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by SN6PR04MB3999.namprd04.prod.outlook.com (2603:10b6:805:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 06:32:33 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::cc42:669f:a4f2:c1%5]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 06:32:33 +0000
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
 <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
 <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
 <874km5mnbf.fsf@nanos.tec.linutronix.de>
 <871rh9mkvr.fsf@nanos.tec.linutronix.de>
 <87v9ell0cn.fsf@nanos.tec.linutronix.de>
 <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de>
 <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.3.2; emacs 27.1
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-reply-to: <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
Date:   Thu, 05 Nov 2020 00:32:29 -0600
Message-ID: <877dr0xqiq.fsf@ni.com>
Content-Type: text/plain
X-Originating-IP: [130.164.62.38]
X-ClientProxiedBy: SN4PR0801CA0014.namprd08.prod.outlook.com
 (2603:10b6:803:29::24) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from quark (130.164.62.38) by SN4PR0801CA0014.namprd08.prod.outlook.com (2603:10b6:803:29::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend Transport; Thu, 5 Nov 2020 06:32:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e77bf98-5e07-484c-681e-08d8815493dc
X-MS-TrafficTypeDiagnostic: SN6PR04MB3999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB39996F21ED1E57358D57A33EFEEE0@SN6PR04MB3999.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQHPHvKWY1Nq6mnVSg9CvEuRn7/oU58vzt/yL5PJL3dTyk6BUAqZpWXciLcRloSVzMKSwI0UBDWqdbKq4kWWIPfg0+FxpsRMb4Dk1R9DdL9k3BLoxsUeYGLliEOwcqFMsRw5t3MEO2OuZFpSgTXKIMfYDGklzDIbmuJQ0RfI+yct+N+VEkFiUr1EyZM9/8nzjEsR5BnEUTwAsEhF1LNtIwgoXYVf0KcgLBtu05O7lx39R+//H6Q46nG+ME3hramgL1B2yAMRjfBxr9ztYOFcYIJzZVWV7VcEfc/n4LeUGe5tHscjDQXEuM6owQBkzOlWcwWd3DAxg8VPcGzef1ma62jksmNdhBarIpMBCabb5Q4Q7Ch2bZa2COrKoZkXxQ/2ixW5LFtN3UAlzl8hmnn6uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(366004)(376002)(66476007)(44832011)(66946007)(316002)(54906003)(66556008)(5660300002)(6496006)(36756003)(6666004)(52116002)(83380400001)(86362001)(6486002)(186003)(8676002)(966005)(16526019)(26005)(8936002)(478600001)(2906002)(4326008)(6916009)(2616005)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uogEOU96ZUxlUGWrSjk5z+wxgstwdFHNLBDo37JCpHt07O3kwtfxhRrC3XmwFqziBks3S+zg3OvmHfklxhRCbkjc5DsOIwH+45jQumRM9GYn99QRCIICqgChuzVBlBCT2EsvdNCQA0IlmmvY49NH95fOQNhsQd/kUmmbldl2o/CFtmYMBXbSQny/catgvIK8xZG8ToCoKPkmwpkM/cH04wKJAYoUg5hIxu3mdrq2gkAwCi0MJcLJG2OuXHL0BINrdmIUXy83rg0/O13JF6osD9E2qC9DqGVEqszmdYyelBhWka5UnFJKO9uSA8oztvKRIkP0lfC728eQS4hrZ8Kj/lkJTOcy8aSXTzV/cbeM2ellFcIUm8Uv5dLAfTAjNTjBZQKCn+RMmR5rdfWPSIBtFCBe1DE/DXL28X2Mly8RyhlIaEKkvhocgdJt81qR/rhD4RYbWRYjIuk9/0Y5OjMfmEFCjiePvqWfENDfZLqgEc3T6l03RwcEI0VBpxk3mq3uhkgqa5kHjgPXXxKPhah+Hs63tNKE3/duonyZVcFjHd+uA+DnmZ+GCq1qp7G8Qgeqk/P51FAzdD8J0huhM9p+7PNGiuMrF40ac14wsWP1VZ3gcYpYRCqt1Df9Gqjhba040aJxN72UENJdyLY4U4TsgA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e77bf98-5e07-484c-681e-08d8815493dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 06:32:33.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYT3KgIk07OR4Wocbk0vdAyxrBneJ8w795BxT4mg/4GEHvbQKS+EqFPPRTJ+RYhc2nse07l1VXJ1OF2+njHBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3999
Subject: Re: [PATCH] futex: Handle transient "ownerless" rtmutex state correctly
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_01:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=988 bulkscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050047
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Thomas Gleixner writes:

> From: Mike Galbraith <efault@gmx.de>
>
> Gratian managed to trigger the BUG_ON(!newowner) in fixup_pi_state_owner().
> This is one possible chain of events leading to this:
>
> Task Prio       Operation
> T1   120	lock(F)
> T2   120	lock(F)   -> blocks (top waiter)
> T3   50 (RT)	lock(F)   -> boosts T3 and blocks (new top waiter)
> XX   		timeout/  -> wakes T2
> 		signal
> T1   50		unlock(F) -> wakes T3 (rtmutex->owner == NULL, waiter bit is set)
> T2   120	cleanup   -> try_to_take_mutex() fails because T3 is the top waiter
>      			     and the lower priority T2 cannot steal the lock.
>      			  -> fixup_pi_state_owner() sees newowner == NULL -> BUG_ON()
>
> The comment states that this is invalid and rt_mutex_real_owner() must
> return a non NULL owner when the trylock failed, but in case of a queued
> and woken up waiter rt_mutex_real_owner() == NULL is a valid transient
> state. The higher priority waiter has simply not yet managed to take over
> the rtmutex.
>
> The BUG_ON() is therefore wrong and this is just another retry condition in
> fixup_pi_state_owner().
>
> Drop the locks, so that T3 can make progress, and then try the fixup again.
>
> Gratian provided a great analysis, traces and a reproducer. The analysis is
> to the point, but it confused the hell out of that tglx dude who had to
> page in all the futex horrors again. Condensed version is above. 
>
> [ tglx: Wrote comment and changelog ]
>
> Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
> Reported-by: Gratian Crisan <gratian.crisan@ni.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://urldefense.com/v3/__https://lore.kernel.org/r/87a6w6x7bb.fsf@ni.com__;!!FbZ0ZwI3Qg!5INAsNbAVSp3jaNkkjFazSRC86BpcZnVM3-oTDYl0KijU6jA5pWYk4KI79_L5F4$ 

LGTM, no crashes in my testing today.

-Gratian

> ---
>  kernel/futex.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2380,10 +2380,22 @@ static int fixup_pi_state_owner(u32 __us
>  		}
>  
>  		/*
> -		 * Since we just failed the trylock; there must be an owner.
> +		 * The trylock just failed, so either there is an owner or
> +		 * there is a higher priority waiter than this one.
>  		 */
>  		newowner = rt_mutex_owner(&pi_state->pi_mutex);
> -		BUG_ON(!newowner);
> +		/*
> +		 * If the higher priority waiter has not yet taken over the
> +		 * rtmutex then newowner is NULL. We can't return here with
> +		 * that state because it's inconsistent vs. the user space
> +		 * state. So drop the locks and try again. It's a valid
> +		 * situation and not any different from the other retry
> +		 * conditions.
> +		 */
> +		if (unlikely(!newowner)) {
> +			ret = -EAGAIN;
> +			goto handle_err;
> +		}
>  	} else {
>  		WARN_ON_ONCE(argowner != current);
>  		if (oldowner == current) {

