Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CABC71153
	for <linux-rt-users@archiver.kernel.org>; Sun, 10 Sep 2023 17:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjIJRDW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 10 Sep 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIJRDV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Sep 2023 13:03:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798ACCA
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Sep 2023 10:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKKIli2KzE/Wfy5AswDr463yiGFZrTH30o8NOuRpI/PSep4++EIJ8fc4oOIof6ACNJf3YCNmBevhsV3+bKvfukVg5YO2GK/YQU5GbeCdRSuwqzHWy3LP5Yf5ENP54eX5zIQeAfwTsYVWQ+VTtMg1ZIY1j6Qvkv54UMH2JGN1AjEBePYO36Pv5Nt1/GhGhD8tNktU3wCetvbNQfwIY5QYvTAvv/2lYQ0gaUa3sMap3IFB+M95ZqF5+Id+O2BlEfSRafMGbC6TPJ+oKcako2xQNRK+MwhglS8rxwsyqNlslHWjvmhAxSCeuSVZOHpZ+Dk8TtsQ2vudzXBQ4OYD7OTRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLXLgLnCdBQDKngPXOYpilRRBVQOygTBeyb3aKBaqgo=;
 b=C1L8GZjkimq42VWncAGAL94IHNNtw/pOgtUdJoN3ces3hUBeSlkfVks5gIDNWDzuzj0mccQi42nq70cTsaV9Okx6EwhO30KPdYpVptcODATtMA8o/h+SZcbu1CEuV47yJ8nVVDHhu+KmZ/d6jbbDRZWISID+csKT8atrKiNC7iHpuN8fbg8ghgH/1O/jylaik/h6AYbCYzk7tXFgvqijMpy4B3EAzDWKRUoQAWoi7+bkiTsbFeNCZP6fn/dqmas7tCXPzEK0xQqFUjZSTw5YFokTG/RreoVsMcn+IO+bbv4qFaDTwLsNkzdhpYyI7RNWBqDMoUu0vHYPSgyQcy/OIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLXLgLnCdBQDKngPXOYpilRRBVQOygTBeyb3aKBaqgo=;
 b=ACrxtwoOQxJARUQ1W8maYkV0oLn3y3aO72psy3b8lsEOXwdNn5D31/w49BuS8tIC9EGW+A2bnMinMxhR9sEyFFOcC3vc5my3M5Pb4I+kZpJ2+hM8Vo+MEt/xExE2IIltd0Q/hvVJ4IRukzEocKl0elUM/QjMtTse0yygGrj1bAqN+DF14C0RD/LzxkWdlkSQQarjj91Ql1XBcYOM+kMSIOCzJggV3rXZntwwXCMctoEV+JQ5Hxc/oKL3Li6j4joQT2a9cdMGnyKklun3iBw0uYK3eEcf8RNKhdTKizuj9sZB+I5Wzb7Nyp454SbZPV0b2for9S3V+Evoc4jCntbCAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sun, 10 Sep
 2023 17:03:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 17:03:14 +0000
Message-ID: <e6ab093f-da42-487c-a546-08b3efdf0ca0@siemens.com>
Date:   Sun, 10 Sep 2023 22:33:06 +0530
User-Agent: Mozilla Thunderbird
X-Mozilla-News-Host: news://54.189.247.149:119
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: rtapp tracer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c73149-37f8-4c3d-5f33-08dbb21fd1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auqGJJT5WbFYLzF+MaNp+Tb3Xvt5DnOD6lZ5HuaiuvkUV79FWTuOqQ17tjy++MAY5JDKP3xYGDT7q+FTQqTHjJDOvcHOR32OQghPB1MrQWe9SnEFaQiJl9j/QbmcKV9je0N2vKem9ghshKif9RX81RcwuF4t7Lj9Q6gdTxYuvSm6RRxl6hD+9mLUyL5mhZHD/Ul+rCtDCJZ6Q40piWDrEnEvWtPoHRGEKED4HJqKl4AtGIrnMcfN7j5PrFlxPpR+pZTB2omF9W9VzPfIQc9cEAC1PzoZjSOeTVuGMILBi4ovu7PwFK4H85pxKZ2pZ1MQu1oilk3QsGZ9O65cbZbpYCwdZ96QaF6c9C2n+JxZNm/OWocwgohIGKPanigH46Y8dOhVcaUlESoME6W+av80yyMi0c2UTCW0MZrCyEY70FUCULIdKgHTuzub2IFkrZs9Man4aSxSz/jCKxsu4dNyP+ehgefGm81jteEHNjavhsAYKUvqdOq7f2z5i+WSIeQYjV22htzTwJSxOvvsaRDu5wVZ5kOUlGofJMrInbv2oTLmok7wrvQwcpCx2V1Xlf65aVS9LOgFeCSBdAdIkvFvww2BxM4NnqJoFUoiH/+sa8FlAY9DfRYhH+YrdPRBVuJrZ2oe/0WdfcrXNW5UUxTzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(186009)(1800799009)(451199024)(6486002)(6506007)(41300700001)(3480700007)(316002)(966005)(4744005)(2906002)(36756003)(478600001)(86362001)(31696002)(66476007)(66556008)(6916009)(38100700002)(82960400001)(66946007)(6666004)(5660300002)(2616005)(7116003)(8936002)(8676002)(4326008)(26005)(31686004)(44832011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1M4WU9hak1iWGoxdVV1TXdESEJGQkZwOVZFWm40MXEzZGdFTzJwT1JmWW1Q?=
 =?utf-8?B?QTJSdzk2b3BsRWo0b05aZFZSVWN2WlRyZjZaS2FVK3NWWHJmMDJnK2NrenVD?=
 =?utf-8?B?UFlkQ2FKT1lLaEtUV2Q1bDhvbFJDTnNZbVBsMGc5Qitwdy8xc2ttcnlSVEtV?=
 =?utf-8?B?YW9INDZxUnBabmlLUFRSUVlxUUMvQ3Z0UWVrWEE5aDVVT00yeTBQUEFpS1My?=
 =?utf-8?B?bjhrd282RE4xY2ZsM0U4a1loZjJXaE9LcGp6ODQ0eEl0cnhQajI2b2NMYnVw?=
 =?utf-8?B?bk5yaGNHM1dWR01uTC9JTFcxRFI3dUxtV1B6Rm13WTk5dHc4ME5ZQmJmdUJw?=
 =?utf-8?B?cmEyWDFNdEZBUUhleW5sK0FYQmxHdC9qaG12MHVMNG8zYVRWTFUrTkZPbnNH?=
 =?utf-8?B?aGpnUEpPRjFyNWpzMVFXWnNsNlpBRzQ3R05ONXRaRTVPYW5rYkJRa0NKU28r?=
 =?utf-8?B?VjlzN2ZadzlWTlpDSytZZU1TTjMxUVhYM1BXSzZsVmlsS29vQTNVRmhXVlJG?=
 =?utf-8?B?Q0lLb1I5UXRid25WN2ZxRGpoKzE2enVZQnR3aGpUazloKytKSDlhaDdZQ1pp?=
 =?utf-8?B?R2Q5MUVsdjArYlZHY2tkeThuVkpVVGlqSVhYZGVJZzMzM2t3aFc4aStuTzdN?=
 =?utf-8?B?OTVlMTQ4Nmt4R204RjZZeHhzWitBVVpJaXVrbEZpckpFdmFlZ1hEWXhwbFR4?=
 =?utf-8?B?V3BmaWkxUlB2cFJaZGRxV1RUVjFITGdPMU9HUTNMeWVOSkcwUFFodjA5blF6?=
 =?utf-8?B?MGtnczh6TzIxUFA5RXBDdytXdUE2NVFIcm82Z09JWFZhbHVGdHNXbjBHQ2Z2?=
 =?utf-8?B?TFR0cDJ3dXZYU3c1MVROUHFta0l1emQyN1lwcWx6WmNDS1EwM1ZITGFha0xk?=
 =?utf-8?B?TTZEL3N4cThmR29wODhlSWJITnVtd3UvWUVjMGIxS0w4eUdXcTFjQ2VlUVZx?=
 =?utf-8?B?QlAwVkQ1MXh1VXVpZFhXSWc3RjRscnliQUNSaUhHL3pFWmpHT0xvalpyZStn?=
 =?utf-8?B?Y2ZrT0R1TnhjaHlGK2gvaGIzVkdJWkVuWTY2Mkp2bndYWjhZaHlFdHAzWlNr?=
 =?utf-8?B?UUZPbUIxcU0rNVQvMjB4Q0JWSHAxYXJsSnV5cnowQ21GQ1B1ZE1mTi9jR0ZB?=
 =?utf-8?B?dmR3SWFCZHV0Y1JEL1JQc21MLzVOVFhGRGgra2k4WEMzMjUxN21oSE5ZM3A1?=
 =?utf-8?B?OWViL0cxVkpxZ3lXQkVWb1ZqeUFRWlhUNDZGNm95NUpEUStHMHMzK3pBRXRz?=
 =?utf-8?B?aWVwN3dzZ013Tmp4RGdzKzZrK2tKeFVLWFJibklYQ21NNzdielJkMkg0LzdG?=
 =?utf-8?B?djVSc0JMVEhOQ2w5cWM4YThMTDdWUUtOUDFUU3VXL0JNL0xFWFQyN0xNakJ1?=
 =?utf-8?B?V0RDOEN1cWx1YzQ4VGErSTVBcHlaOHNCcmRnMGtDWnVuY2pWTUpiQmdFRzBD?=
 =?utf-8?B?UVBtS0hRenhzSkVNeXc5L3kzbEQ5SjJnRnZUZDVSOEJKV0lidGJ3TExJQkZG?=
 =?utf-8?B?MGpId1BoR1gzUUdFK2ZWTWdVd3ZMb25iN1IwN3ljTW0vZllNU1RZdkpqdnBR?=
 =?utf-8?B?YkE3TmE3RGN5RVMwZWw0dklOMGp2ZWowNjZrcU5SSGlydVVlQ0l6SlhWRUVo?=
 =?utf-8?B?M2k2aS94Qm5UWlY5OEQ0NDZiRTBKS0xHaDdWcndReFpVRlpVemExYnYyNCtv?=
 =?utf-8?B?TzVxUU9ZT1NlaTJGV0RQamlUS0J5RW11bUY2aHprOHZjclBiellpZGpKREpo?=
 =?utf-8?B?SnpWZkxnQ0Q3OGRNdFFHcDYyUkNxMGNpSUJKVzl6azJtaG5uQlBVOGpMaHNH?=
 =?utf-8?B?WENFMEw1aGg1T3pZMVNTMk5JV05iVFIrMzA0SFdsa0tqam8rSktZSndIWVZB?=
 =?utf-8?B?aFJiVmttTHpHTXMyeDBqMU9RQjJuZE5mcEc0QVpWQ3MrNjcrVHMzd3dHM2pG?=
 =?utf-8?B?ZVpWcXdxZVlWVVdvdlBUZ1NSdE1SeUl0bmZDdGErV2VXZ0VJYStpTXM5OU9J?=
 =?utf-8?B?NVZ1dzhFK0NRVkxjeU9aQ05RYVZIMmgzYlpNR2FlMW1sUDZRaVhaeS9ldTZq?=
 =?utf-8?B?TGdVa09mUkl2NU1rN1ZLb250ZThzeUJrbHhiTWlsUjYwQjJkckxkRVFsMmRR?=
 =?utf-8?B?UnNmQlpPeUlGWHArYUNwRFdKcHVjcml6UlpubUJTMUtPWDlOdk1qK3FZREZW?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c73149-37f8-4c3d-5f33-08dbb21fd1ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 17:03:14.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePvZlOY7B2xd7cMuyHuUXva3o4HsMfa0QG7GpR4n4gHI8yVmfyjinZE8CwMXnpkedv7eW/et7XhUOOXRciAkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6422
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

is your rtapp tracer [1] somewhere publicly available already? And
what's the status of this effort? It's surely addressing important
issues, but those are also surely not simple ones.

Thanks,
Jan

[1]
https://static.sched.com/hosted_files/eoss2023/27/Proposing%20a%20new%20tracer%20to%20monitor%20RT%20task%20behavior%20-%20John%20Ogness.pdf

-- 
Siemens AG, Technology
Linux Expert Center
