Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED6FC83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 06:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088C3206D6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 06:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="ivyKn759"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD1Gvl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:51:41 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com ([40.107.8.129]:37088
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgD1Gvl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 02:51:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+nBdhOyaq0OgCpKOZS2a9LA7nWH743zis7B/Y2ACtTNsA72ysNlO7XbFQIMarhCFg9C/07TPSZkRarOW9Gje5Zhb+hJBdm6PmNXMUHGMednGJIfQlW5CGaLGD4J9lHCM7NoCRy3HHC/aXYAR9LJrJ8Gzf2KYN5VPdfW2ghAOfj/0h0fdJPS/ZCmY8khN3DcNRdOLLukLiZCmvjeANxfng9B+huK+ONdsb3jTn7aVbV3tlsl218llyb+aJcui/zRFlS959Fy6ERvvWBTeqwu0kXtEbVL3/yIOowNudNSCJDrnn+nqX4T/XJE39V/0Nc/3TjncN0+J6mEs2CwvLsN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RdK95B8GgeP7PLzdmwLP6jwW3fvq5zYRxu6M6WGixY=;
 b=dWbI2gL8vMr1Wxs0rBYyu2rda37H2/bDztEpzpy11s/fqa0I5lJ9T9OfxCFx+yfG/JSbKnNBlNC/zDqWM+/mgYziKKfNrbheyoY98e5J94v5B9iCC5VOuWdyC5OE8W7prYcF8gon/yJYHjYkcO3zYs3iLLo3OtaulxP82Uwsz1AMWAnKYOOW46BsxM0qDMpu5rkTDOJ8byS8RXzOcg02sAyXV0prng061L5luQ55oVLnduru5VcN8GMgheymYKxZTGyZhPE/b5By6j5/GKgtKSzrgQ3Hz0IjxsEyKy+Lws+uJETdtZlBHsJhJFq3E596BdrGLkKN3IDIQFKwGBtucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RdK95B8GgeP7PLzdmwLP6jwW3fvq5zYRxu6M6WGixY=;
 b=ivyKn759WIXhUc3VLwkUdnDs0fX4UhtmGqL/AzD+d3DUwH4AB2SGMnK+A/6449kAqfZBsmlzOtmDXk65/sjE/9hqClkWjV3we4obtgM1jAXH/DqNXcU9P0GPLm9MyYBp0+nitgPKRQO+x5glarGPwgS9prZ84hcmAjeORXfVdA0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 06:51:37 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 06:51:37 +0000
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Julien Grall <julien.grall@arm.com>
References: <20200123203930.646725253@goodmis.org>
 <20200123203943.749508731@goodmis.org>
 <ac4168c7-68d6-e558-644e-e0daceea1f61@prevas.dk>
 <20200427150626.4f217c82@gandalf.local.home>
 <2535a046bc15f28478c5289742e617a468becbd6.camel@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <48699adb-73f9-225c-c8f4-959f4b3008b3@prevas.dk>
Date:   Tue, 28 Apr 2020 08:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <2535a046bc15f28478c5289742e617a468becbd6.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0011.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::24) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 06:51:36 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99744508-7a50-419a-2523-08d7eb4098e2
X-MS-TrafficTypeDiagnostic: VI1PR10MB2381:
X-Microsoft-Antispam-PRVS: <VI1PR10MB23817ACBB2DCE8B29C039A9F93AC0@VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(396003)(376002)(39850400004)(2906002)(478600001)(2616005)(36756003)(66946007)(7416002)(81156014)(26005)(8936002)(186003)(16526019)(66556008)(66476007)(6486002)(8976002)(52116002)(956004)(54906003)(31686004)(110136005)(31696002)(4326008)(5660300002)(8676002)(16576012)(86362001)(44832011)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+q4xnSd8n4Yr7f6Pe6uQeTh0dz0UMtVAlMQ9RhmtGiZmr/+XtL2gjoEK3mgdERUbquNl1oFgz8663t9dMSsmBpoMkZHnXLu6NVTH9lBqhpG5shPKHvKW2keKdJIas4FWcEnS/LpAyg4ZBkT5cZLJhjBAzQcHoZOcw2g85FShbfPeI+yTS7JdMFUUe7MgU/+sDfoqzxIPjAp7ShvECT0/fDUZnKzvglqJpWZ3gs1YeBCoUIBZVgkAyj95r7rUjbETmSaV76hJHnGY5v2njV1cbLvfLWXEYhwOSxCnZCqYnfoD4Ctov3yLHQUxW7Oi+neUuYuf/EzCMbSVb6U6Y/pOXo765OW27Hp2Vm73sVFe+UR8uN1tSEXLv8i4y1u9WffDDsVPuCkSOvGVCsj9vtfBjRB+OAHe3F0wl3jWvWIi7phdPiAjZqprnIBBdSIxKpR
X-MS-Exchange-AntiSpam-MessageData: W9I96igBUr00mu7FjEwK1UZynlG+LO8dJpxYLhOpevrCopAxpm3wFJyXIDGe6JCNj+7pfx5E8gLZYXO+EkT/SZZYLX7Ksy/VBZtP25NdTysYfelcs54HweU3D3tPiKTCX6I5pyyr7ObtXBxm7pk39AwU3y4NertQF3qhaXrK5+vd9rvsdiFNIKm84TIOXTmJjP+Xc1MGthCqPTvJxN+/mQWEy0opjGEVL9ZhjjhaXNBf/6NTCq61na6a5veVGhV3XYlmmkLv4YvOlHDOTzQ4OS7QpvY637oLDO1qc+vnONz1dnwxsUaG90tOL03++zmGjTHw0eJ60EhGDd8nzMKMubKdn2iNp9UUkrSfUf15N2gNeUpgDT9johKcDg8yaqUC3Y36tiE9DoU9EYzZMRbajIwoeY91aRCnaMxM/73H1y0R6YhvOH65X1a7jo3kpizs34VFrBacP2bkEp0BYIoDhjVfBhG+t/q0XHQ4F+2dwrwC/zfiqheUEw00oV3mdlxg0XdG1CO7Vh90mnkevlvYuGCIG/G7YwXO2Vv+owTmuABp1zwctYTiHVLmzDJUg17id6+Inccn2M7FRG1bbvYI1BujI5t4NLKTd6OrqAXuU9pJxBByPLM2IKnyc7NzTKNduPWIzIJ+nPs1JjmjuRfw/6zzimVWQWDAzXDMJzsMI6IqMhkhSVhUQRZTZhAVRf4h56dWQ5gynTQqdE6cGN3H0/4ibJi8/wm/S7JEXt3JQ9IynLLJgn4kXSE1mg1T2SozilHp4g/hRRvS9/vjBENKoOkC9dg2/qtsNrQVuaGVE0I=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 99744508-7a50-419a-2523-08d7eb4098e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 06:51:37.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH0pMtmK+nnorT1jtuUKgQdOUoTZ+AvgQee98V8G1KgF10hRqxQDXDXsaFeQ2C/sJ824FEnoXf3NiqhNDgKMpchwztLwL9ywOXqI78yqJV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2381
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 27/04/2020 21.26, Tom Zanussi wrote:
> On Mon, 2020-04-27 at 15:06 -0400, Steven Rostedt wrote:
>> On Mon, 27 Apr 2020 15:10:00 +0200
>> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
>>
>>> Reverting
>>>
>>> b1a471ec4df1 - hrtimer: Prevent using hrtimer_grab_expiry_lock() on
>>> migration_base
>>> 40aae5708e7a - hrtimer: Add a missing bracket and hide
>>> `migration_base'
>>> on !SMP
>>>
>>> on top of v4.19.94-rt39 makes that problem go away, i.e. the board
>>> reboots as expected.
>>>
>> Thanks Rasmus for looking into this. Tom now maintains 4.19-rt.
>>
>> Tom, care to pull in these patches on top of 4.19-rt?
>>
> 
> Those patches are already in 4.19-rt - he's saying that reverting them
> fixes the problem.
> 
> I'm guessing that the assumption of base or base->cpu_base always being
> non-NULL in those patches might be wrong.  If so, the below patch
> should fix the problem:
> 
> Subject: [PATCH] hrtimer: Add back base and base->cpu_base checks in
>  hrtimer_grab_expiry_lock()
> 
> 4.19 commit b1a471ec4df1 [hrtimer: Prevent using
> hrtimer_grab_expiry_lock() on migration_base] removed the NULL checks
> for timer->base and timer->base->cpu_base on the assumption that
> they're always non-NULL.  That assumption is apparently not to be
> true, so add the checks back.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/time/hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index e54a95de8b79..6f20cf23008b 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -953,7 +953,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
>  {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
>  
> -	if (timer->is_soft && is_migration_base(base)) {
> +	if (timer->is_soft && base && base->cpu_base && is_migration_base(base)) {

I'm sorry, but no, I don't think that can be it. For !SMP (my case),
is_migration_base() is always false, so with or without the above, the
whole if() is false. Also, the symptoms do not look like a NULL pointer
deref, but more like a dead (or live) lock - so I'm guessing (and that's
just a wild guess) that the lock/unlock sequence is needed to give some
other thread a priority boost to make the whole machine make forward
progress.

Rasmus
