Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C08C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2B2053B
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="dGYY8yWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMB6Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:58:25 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:49376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbgHMB6X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnJJ3+CfcNPcTaNATSwpaDvVHcPP9dwk76XvtvL+yhiJnsZVLGJXe8fQxQ1+4rVC9lq15KRTQr3srCGCsAV0Aq5tU9TZrsiQKRZdJV/cwwlYlS91EtH0U2EcSzwwHNivtclG2empTiZRPtrwk6yeg/wvYWalhHzhqzo3v33jxUcNsNSyVADNU3lDva7bvFP55tFfX7uXeZJjXSZGUtZ5ECzgdRFC7uyyxLODxI9ZsfyF/dV0YdzkLDL6u5pVW8f1f5WcLJ1UN6KFwljuZj+MqPq15S7SqjkGopkPLdnTMV8TCQ8B/OwJ2MYpL18YUc/sJH+ke8qmplsYZt4Ragl9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/vRPa5N6kHPQPSAiUYGEeG+cEWYVpZiAWAfcJilOYg=;
 b=Cn/rQTMHFs0BFL1A3Y1d8bXx23ft1h9fVDsXm4KF5QEGi21eDo0ou0OF3hkbFi7RkgFmGYbCLDYnatKrzOeDVOtXaAm4E6nOW2WEs3ZHswIXYvQrGBtOwjkF86AiZGy39zFauVqGdlRC28p9344rIVZLNf0N50I8jK+Tfh7PW+rCp2JAbg/BtJSuvxFYRjjNrwg45oNBoNZGd28u+35cR175lN/P/Km8r6pIK7JFzFCA08uUgwp4m/4dfey6uaCfTZ7d/OoZwZIpXGDRd47nFrYaQzbVCT0bLtL0bg1s6ePCNN5FVAKNw3WQxe3qzotFD0aWZnyZ9Pc++MUEohesPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/vRPa5N6kHPQPSAiUYGEeG+cEWYVpZiAWAfcJilOYg=;
 b=dGYY8yWlisc8kR990KrF604vTgDakVa5ItqfIgfMWut+iMRVDsiBmxVK2MSOWnFk4cUKiXblvfcDDpPP72iynTDr1fPbxpBZojew8IuGbgiutPBNyPXsleROTNgXONr95HGfHRLIpMpzSKMLitnzWTfeM2x+o0ZZS3FZulDCAbg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3190.namprd11.prod.outlook.com (2603:10b6:a03:7b::17)
 by BY5PR11MB4323.namprd11.prod.outlook.com (2603:10b6:a03:1c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 01:58:21 +0000
Received: from BYAPR11MB3190.namprd11.prod.outlook.com
 ([fe80::5500:d278:6406:ccbf]) by BYAPR11MB3190.namprd11.prod.outlook.com
 ([fe80::5500:d278:6406:ccbf%3]) with mapi id 15.20.3261.024; Thu, 13 Aug 2020
 01:58:20 +0000
Subject: Re: [PATCH linux-5.2.y-rt only] hrtimer: correct the logic for grab
 expiry lock
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org
References: <20200812105053.602-1-zhantao.tang@windriver.com>
 <86790e56-9cec-5cea-8387-f7010b88708b@prevas.dk>
From:   Zhantao Tang <zhantao.tang@windriver.com>
Message-ID: <05700b0e-1edf-ab5c-ea81-4d4f8f2c20b6@windriver.com>
Date:   Thu, 13 Aug 2020 09:57:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <86790e56-9cec-5cea-8387-f7010b88708b@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To BYAPR11MB3190.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.245] (60.247.85.82) by BYAPR11CA0039.namprd11.prod.outlook.com (2603:10b6:a03:80::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 01:58:18 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98aabbe9-7789-460d-7adc-08d83f2c5a97
X-MS-TrafficTypeDiagnostic: BY5PR11MB4323:
X-Microsoft-Antispam-PRVS: <BY5PR11MB43235E85468CBBBA20FC7D578E430@BY5PR11MB4323.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVcCAvrx6tnXXEaujAESfNs9EZZqZe69gjz+tZE0cloyrvfRulY97OMe8CddhJHUNX0EpYjuePo/iEIsFCb+wZgfLyc78tQsBfUmuqYlnPP4Xm7WSnVHTFDTvagzWuuRWQeJbQLQ77J3EXlPwY6wSHZHvbURteewyFZnwDlpp1HITbURGanvNNpMcaMAdW483yucj9G0DLXSjS3oQ2mBr7yKHkrh+dmyVaEfHXXnYZzKNtib/jTM5/WNxVg33pnnZOCvegd8XSV+ZfQ2ugd+veIregUugNuph1vgi3uPu0z4PoIMrhupgaUe8OYJseSEVq8mKuwjkSKofd61tI6ccuzpR/LvYj7mfTXzx6p2UcYzQJtxyGcw99AYZKgYJfuL38BfnVCXllL/PTfp1aL/Z+H0Ri/6Bwhn8cz2QstfMgR5x4eC1v7CgiH71zuPZd8rexG5Hx5vQxGuz0XHYtMXu7dZOOcAJcoVBddHMSSRc3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3190.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(346002)(396003)(376002)(136003)(16576012)(4326008)(186003)(8936002)(6706004)(6486002)(31696002)(44832011)(966005)(316002)(2616005)(4744005)(83380400001)(2906002)(956004)(66946007)(86362001)(66476007)(31686004)(52116002)(36756003)(16526019)(5660300002)(26005)(478600001)(8676002)(66556008)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QoaJqrKdNuhRPOX6UFju6cf3hly4BsfiykTstT7vGGm7j7lp0Y+idAf9ATdJNEV44zNxZej0WESXvYiL7+O8UF/my4JB70apDIRqN1VvD3K4c/iD0cjrV6CUWzdMPCUVvblA9uAf/OEfFyaXjX2cF6lA5FrUspo/onEBiKyTXgdsLPpcqFtxp6u7QBMdPJ6N+r7YMKYE/x3cYzE32wmLGyOVOIGTGz+JB22vXgsFhY6GapKYyk6xAl1Z7CQ1Y6TxkX1YFx/neMgtaFktayUINC4AlpcDUtGTlZNlMyiLZ/6xarrE9uPwzbt9HMNp36rRrfOsN5vZMsGRluCs9Y+dgaMp1AzMVJd4baFso3NzX+Ie3SPD3vyui/rK1zZ48NHPsB3b7g3a8/dS4kKfZXfSglAhayT5RXtzI6oQAR/8gpnploZk+otx4XIMHgEe9AuaZ/bU59ytA122gGEDLpdHhat544s/jhOvym2pvkNy9P5kNmp3Nrkoceyzl5/F/Chr7dFcgvw87b13a8f/YCXUM5dwnF7Jo0s8V5M6JhJLHLB9zol8DP67s6caAZ1aevUhELD+YQXoeUGkovPV3/+fTmP3LmCaqvKmJmLHpg/NkonFYEYXlvdBUV3v5S2X9M86hCzwI2EtzRkJnl7yOGR28A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98aabbe9-7789-460d-7adc-08d83f2c5a97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3190.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 01:58:20.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfzj910sgiNjeMOZIQ+u8wvSPgz7vPrgRJ34MZMuBcfWBRZD6Y6d4/YReVabJ1LwVIHtKRjW/1kPuc7OFCvT7RjarUeM+ivXSoC15e/vLAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4323
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


在 2020/8/12 下午7:45, Rasmus Villemoes 写道:
> On 12/08/2020 12.50, zhantao.tang@windriver.com wrote:
>> From: Zhantao Tang <zhantao.tang@windriver.com>
>>
>> In commit: 47b6de0b7f22 ("hrtimer: Add a missing bracket and hide `migration_base' on !SMP")
>> a inline function is_migration_base() is introduced. But
>> the logic of the hrtimer_grab_expiry_lock was changed.
>>
>> This patch is to correct it.
>>
> Yup, same patch sent back in April, which also had a fixes tag for 5.2.
>
> https://lore.kernel.org/lkml/20200428144026.5882-1-rasmus.villemoes@prevas.dk/
>
> It got picked up for 4.19-rt, dunno why it wasn't for 5.2-rt.

Yes， currently 5.2 rt kernel not fix the issue.

And I checked the 4.19 rt kernel, but  did not find the implementation 
of hrtimer_grab_expiry_lock().

It used hrtimer_wait_for_timer() and the logic is OK.


Thanks,

Zhantao

>
> Rasmus
