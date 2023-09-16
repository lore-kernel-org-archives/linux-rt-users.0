Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E079CD37BB
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Sep 2023 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjIPLUF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 Sep 2023 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIPLTq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 Sep 2023 07:19:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B75199
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Sep 2023 04:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/TjxGHf2UhK0ufKc6sG69Ja7+qlT+1lIhuAmrD1awC9ilF4jsUCLSdFyjHfqmgb5PQYF4QE0zzh94OiuZFa3WANHdPxzx1IYuQuzMN5nJtMovlWGSix40QLA9JYfKRG7lH0IoNSn8auDFuRYxlhLVzTWLXku/VDVUs6OxCpNpl04ofRSZKHeoGTZLcMd5dcNZ1ahjNu43azEBWO9xxgJFaEdG+TnuDLwK+wZdU2kKFABn++BmXZ6MfDZmP2SCv2tccDZzstgQZkfZRmbUlX60ZEezMYjJSA9pppEDF2igXjYB2+wZKgcmIs+Gby26SWvLoiwOxaPl2b5Tv0I1sfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhIlOmU8atCiO2T0y2ZhVVDXObV81Z/5xEfeSkKLs7s=;
 b=Au2BPdJpVuqK5xoZyHGY3CtV+vesLQKLlJ4qlCKoEouqg8Mrp5MZTYs/6SKAwOa43nlAurdCLZfDE0cYNvInGdd5+rGLhKJlrNgsH+P+mxE89It6NKWxBtNf7E5VFgh/1f9xgntJOJjJIeB4AjjkOZQnyGVEwEhkJBJPOC9oZ9n7ZRFjycnzTBOeWWhloi8wZDZKBZUlXarS6WFQqaj8AWY0v8tkfr8yhzsgStb8f+EnigpHIt6SnGNUhjF2xLrVXtBz94Y/1odyo+ZkZb98zZphJNxfRfqaJnhhazRxqKuRE1uSta9IwuG44RB11+DFEw0MnpJUkpsmBO/Hl1kAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhIlOmU8atCiO2T0y2ZhVVDXObV81Z/5xEfeSkKLs7s=;
 b=wXwFYd9KiFELr1/SziRl8BVUpSiXw8VcXFEa8zN7zdWsOaL4Xeh777cGj9DY4qXz1swjdpKnN1PXf2J2GVkfF2a3Z+T2E0Os9M5yYdzJzM26ITio+O0UVIkNVgW/0PzRkJ/Ws5idLwXz1MUpHFuemfvW0jkqLJuGIuefFvLzU4PMfdWbXP1enrmkjB8VcBh4cZt/YyDw+KjU62EFRipefmQ1yAon13YrdhtWDsxbQcP1Lmnt017SK8cQ5C7ZeaHZnrwp7atS53Ap/I7ZTr37s6x7By6bkQ0Kzds41nBzyFy/0FtSqzY2DDqZC++th+5BZYrQMaxQYtwcqCnrIRmv+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 11:19:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:19:33 +0000
Message-ID: <12974db8-bc19-4149-8d15-219537f03cfc@siemens.com>
Date:   Sat, 16 Sep 2023 16:49:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: rtapp tracer
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
References: <e6ab093f-da42-487c-a546-08b3efdf0ca0@siemens.com>
 <87tts04yl6.fsf@jogness.linutronix.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87tts04yl6.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dab1476-8f5b-4104-a6c3-08dbb6a6cda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt6w+TYaJziJaWzTt1VTMju2zznvwRWSt5oYPSUlqu6/+kzheRnagQU92CbcNAVWPx5wTobCtoEayU2CqYWkkgNGqhG76xBmqRmjv8LVdJw2CT3emb2/M9X7s4Sljmr5eO3gu3bcTyEzl2Js9/2eeop3DUtyBtajmIBf+Mq9AbArvXApvA53rP8fuSmq3ymztX9IbUoSpdACCbjFnGbs3jCnUxCNQwTuq2p8ujT/th4efwzsEK2m3SE2urKqQVXnR/ajXypTffOkzQQ08cWhLKtiiu9n1uWJ2AL2Y9dNL/Eg03VX7HsFtGnB9Io2V2Ky+0x2Xr8vpYY+2rQmkNbIkVhaHxL3Dx/oAfaqwCPZHfSprIlOIWRPzSKWtw2bgTLEMIkkQCfGDQqN+KBHgX6Ym4zgPvB6OdO2RoHLqvdHuxJfGkcgxGO6s6p/jnAPgEkwuyrojZ7c8Z8g6kC7HaEdPT0kL23vTUeM2ifIiFnjLCdRSAgSNS3wZt0gGmufiCrVD9Uc4w5CWdUE80EMt3utIU/ernp80rVrlT2hGosvg27EJLTglEjGKOgW6No2fFawaimLhg78vf4ma+o4oH4h32q3V2RIdJrTNIdYU2dBea14FdCgS6rF7+9mn7eWQi91p07mgIzHICGKu5JuHaGltA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(26005)(82960400001)(7116003)(2616005)(8936002)(8676002)(4326008)(83380400001)(3480700007)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(966005)(478600001)(31686004)(6666004)(6916009)(316002)(6512007)(66946007)(66476007)(66556008)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpxZ1pYRnFRRCtaZzlydHA1cDZYYVIvRjdybFd0QWxERVZ0NlhXeVpQM2Q0?=
 =?utf-8?B?bDI1WEJnMVJQUzlGWVRyYWo0MUMwanFsbnNJczRLVTZXTzRkeXljYStKQ3VC?=
 =?utf-8?B?OGNpVWxUY1U4WTVpcnRyRVU4ME5ibDlFcUIybUUvMTZhK1JTcTU4MnlCODZE?=
 =?utf-8?B?VHdPUjUvb1JNOEZvaTBwdDZBSkxXSmlXOHFZWjRVdUhXeVVyVC8vMjV3YkRH?=
 =?utf-8?B?R3RUbzlLazk5Z2ovb3p2WVJQQnNsU0lJTjExWEZsbGl2UW5aWjJDcHR1UFFF?=
 =?utf-8?B?eTI0UHJ3cllTODNUa1NkZjlMR2RsU0EyUnE5Yk5FVTYvbGlRdVE3dWFWcWRz?=
 =?utf-8?B?LzZ2OTF4dmJ6bHB3Z3hSbE5lTk5rUW9mK0VGYmJZaTBrLzBieHcxRWtyRFpN?=
 =?utf-8?B?TVBhNmtCcEhLb1hWcUZCSjUwYkN4Q0NSQU1OUXkrQy90b1IvZlhJMkROT29t?=
 =?utf-8?B?Y2tjc0dRR3lpbGFoN2llWldMcVh5NndHNlpMeEF0Vk9NNll6bExqSytCbU9P?=
 =?utf-8?B?WWNSQWl2TTJKNG1NQk5QQ0wzbFRKNTl0M0VZaVV4bXVjSFBuVFFsVGRCOGRM?=
 =?utf-8?B?MlFkaFlLa0FWRndrbnE3MU0xOUhPaWNhYmM1ZCtleWJlcVIzeWZicVNKRVhh?=
 =?utf-8?B?Ukp5V3M3Yy9QZ1UyQ2IzQnJsSDcxK21GQ2lwdktwRkwvLzR1VnRFNGZMenh0?=
 =?utf-8?B?alJ6eUlZSStydWtTeWtCdVJ3K29yTzRFRE9qQjNaYjR6Um14UVRHYzlUd1ZI?=
 =?utf-8?B?U0Z2cEJZVmdHbk9vNU1tUDVhdFFKYk8rcUZmcWVmL210TDRZTVdNSmVob0tC?=
 =?utf-8?B?UzN2NFljQTUzLzZFUVRJTHpOdXNBblBnQ2RQZURQR0tscEVhek85cWZkeVph?=
 =?utf-8?B?Nkc2UG1OdlVsU0gwWlFiaXVNUWxmYmg0eThDRXh1eUxpV1MrRlVlT2cxOU8r?=
 =?utf-8?B?RjVmOHFRNEVTbkdxVTk5NDUyZnhEcVZqaGJMeEZjQzVqcGhjZy8zdUJTV3Bo?=
 =?utf-8?B?ODBSMWlxZ1c4NUsrZjdpeE5jS0Z5NlVZNTZyaXg2N01mQmtEbTJ1MGp3R3l1?=
 =?utf-8?B?VTFpci9BMDY0cGxQSWs3Ylh2dmpNSmExcnhjVmUxOXlULzdLNG5VczI4TWY4?=
 =?utf-8?B?eVRiaWhJSzNuUmlLU293R0tHNnVnMTJqR3Z3bWowRDdsM3NyelBmdTVFWmVa?=
 =?utf-8?B?YkFIRnNCblNYUTRWVEdhUExSZ1dCR0tBV2RXcTNERGtwRXg2YjJaOEEwblc1?=
 =?utf-8?B?ZmQybmI5WUgwdytSTWU3d2M2cFhiWmtsNTMvSEZjMjlXQzFJTEMzNlBtaG82?=
 =?utf-8?B?RHhPKzA2NkRsMGYzcmkxY2RvbFJYOXlpRHRPSEs3QlJYQWlwaDVkc0Y0VjVH?=
 =?utf-8?B?bnlCRUVCMzc2OVpieWJOWjJ4L0pjT29GbUgwb0dPMGFlYUlTb2FlTXJtMTFj?=
 =?utf-8?B?REYwL0xITzVlZkNlclk0bUNKaXVjdW54Zm9sMmxMbjVvQWZtUndvMmRBVHNL?=
 =?utf-8?B?OVpJRW80cUF5KzZIZktzV3ZVN2xnczF4ajB4QzE4SjNGVzdSMDBXQy9zcjdG?=
 =?utf-8?B?ODZlN2NpbllkcG0rZUZVdDVlcmZKUkFyRlUrVmJpWGJsNks3cVBMc0lodFI1?=
 =?utf-8?B?RExkc0ZxRzY2YmZ3NjNJVVQydEE5WEg1ZW85UlJHd1NmcmtPQTNhQWJWUFl5?=
 =?utf-8?B?ZXUwMTJ4bWdTc0c3a1V6amZaS2F0dXhKWDVwek5pTkhKNEl4MHlMZ3RLZ0Jp?=
 =?utf-8?B?MVVIRnIxdWdKeW5lOGViYzgzdzQ5VmdieEVNbFZFa1RjdW5PTkRzRDErRjdK?=
 =?utf-8?B?WnRIRWRFMTNoU1RmT1JIcjVyd3k0ZXBlMGV4M2ptS2o3RmpkRm9Dc09jSEJT?=
 =?utf-8?B?c0RCbjJkNlRwRlZYby9wenNDMVNRNHJHTWxzZnMzd1NubVdMOGlWZE1oVHhP?=
 =?utf-8?B?UUt4SUJZaGliKzVDL29HTi8zNjVTMkQ1YWNGUmVOZFJnTmZtRnMxUmpRTlJD?=
 =?utf-8?B?UERBWU9IZ2NvNkpidS9ZZVFQZEtKK2EvZXFhOWUwdkdwODVUbmlvSnJLR1pI?=
 =?utf-8?B?a1pyZG56UFI4RGZTV0pTSE54MVB4eE9pcGw5azRjSkhhV3FFVmFYN1EzcDlY?=
 =?utf-8?B?c0I2NmJQam5HSktSSjB4Z1NudytOd0ZUNW92VFh3ZkZKeFJWdEtIbm9ONXFq?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dab1476-8f5b-4104-a6c3-08dbb6a6cda9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:19:33.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwftEY29WhxLCkU8K1yKrRCcJOcsi6y/FzIdazYVrPezDQx1Sep8I07NZfwcBH2ZOJYNui2bQ4wFlzTSgucE8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6139
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On 11.09.23 19:10, John Ogness wrote:
> Hi Jan,
> 
> On 2023-09-10, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> is your rtapp tracer [1] somewhere publicly available already?
> 
> No. In fact, it does not yet exist at all. At EOSS2023 I presented a
> proposal, mostly to get an initial reaction, feedback, and see if there
> was interest from the RT community.
> 
>> And what's the status of this effort?
> 
> Right now I am dedicating my time towards finishing the printk work so
> that we can get PREEMPT_RT mainline. I plan on working on an rtapp
> tracer after that. If anyone else wants to start this work sooner, I am
> happy to contribute where I can.

Upstreaming is most important, absolutely.

/me neither has the time to start something at this point. But I see the
importance of this topic and would like to follow and, where possible,
contribute to such an effort. Just recently, I had to explain to
colleagues lengthily where traps are when porting applications over -rt.
Codifying some of those issues into a runtime checker would definitely
be more helpful - though also much harder.

> 
> BTW, it is not yet clear if it should be a tracer or an RV monitor. In
> the presentation [2] (starting at 50:15) you can hear Daniel's argument
> for implementing this as an RV monitor instead.
> 
> In case you were interested in the bpftrace script I used as a
> proof-of-concept, I have attached it to this email. For it to work I
> used a Debian/bookworm system (12.0). The kernel package was
> linux-image-6.1.0-9-rt-amd64 (6.1.27-1) and the bpftrace package was
> version 0.17.0-1. However, in order for bpftrace to support kprobe
> offsets, I needed to rebuild the bpftrace package with the extra
> Build-Depends "libbfd-dev". As mentioned in the presentation, with any
> other kernel binary, the proof-of-concept demo probably won't work.
> 
> Also be aware this was just a proof-of-concept. A real rtapp tracer will
> need to catch many more cases (as I mentioned in the presentation).

Thanks,
Jan

> 
> John Ogness
> 
> [1] https://static.sched.com/hosted_files/eoss2023/27/Proposing%20a%20new%20tracer%20to%20monitor%20RT%20task%20behavior%20-%20John%20Ogness.pdf
> 
> [2] https://www.youtube.com/watch?v=E5cTgiHJKc0
> 

-- 
Siemens AG, Technology
Linux Expert Center

