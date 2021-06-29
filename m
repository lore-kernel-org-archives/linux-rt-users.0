Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A69C11F67
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8F561DE4
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Jun 2021 19:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhF2TSL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:18:11 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:31718 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234343AbhF2TSK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Jun 2021 15:18:10 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TJDKdM028514;
        Tue, 29 Jun 2021 19:15:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-0064b401.pphosted.com with ESMTP id 39fj0011wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 19:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLNoQn4IAFpHC6ffk+CVdfdLvGJJZWwrwDYBe/QrweChUtbtsKrF5FQWeGlbQ8gPVkMAHVhN2/5YZQUy+ph7POJqjueconfBBioA9TL0PWi6TdSo3C0yRnlWxRvm6nndAMXQq+ZOgX6/GDAjahLlbUQhosd24OQCGoQT+1Plx9D7qcrqPgphll3Ckss4jZRrrH7GOcnonqxCnKMeKJBTBmr932NDk87Ul8kDtjYL4u2MF6TvDScMKhnDgMx6yobocs7oMaEcIK8selC1qSOFmdu62qxwvjg04TpE6S5zrT9p+Vby9Z8LmxfwQahFQ9dszbPLYlo6rHb5gI1wRS8B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJud1sOioFg8jjKeDmGuuv0I9Mctl7PIuIvR+YvmsCs=;
 b=dfE39oz3D0FcDqY7zh606GaVX+9dnMIgoQwP/OfJlvBxL7N3aPwdrxgWw+ygYAFDDro+K/DUqOLyBwuqvlTor90FDTG+C9vBElACL0cwj85OetZGdgIQJtUI8/TaZq0DTNBtWm/x3HbePTsBwscyBTd41fThZsC/Rqih6IW1Njx4w6vSBTtI8tBpvj5XJWt753RsR3RkrQXJ5yw/VqY/lBEA4BMCl48Ol/c709vpYY9D2bDRhFHXr2WxJpGbeVzEALRVhSUAULDWyT0yMgzRXRU6197rxrYSzqV0n4ERGNQzbaYl3k9Lv7PW9P7OAGXbAaO7m1BUE0fbgQD8BR1Pnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJud1sOioFg8jjKeDmGuuv0I9Mctl7PIuIvR+YvmsCs=;
 b=XuJpE7w2LzQysxsozepoUcGyALrxhjnVMdcsYMqmc43hHVFfJAs2pwbRKESEFXni7AUiee/MonWGnvMZypDwj7Tn4PxD/IBw4wNzh3ZdBrldLQF1ZtZH0VB/SOrEjV6/8LV27dV4fWiK5zMuggm1nStui9hqGWp6WYANP8ExDsA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3432.namprd11.prod.outlook.com (2603:10b6:a03:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 19:15:38 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::6df4:6859:4d:29f9]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::6df4:6859:4d:29f9%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 19:15:38 +0000
Subject: Re: Questions related to nano_sleep()/hrtimer
To:     manty kuma <mantykuma@gmail.com>, linux-rt-users@vger.kernel.org
References: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <fab091ad-bdeb-cb03-79d7-2fa2496bc782@windriver.com>
Date:   Tue, 29 Jun 2021 13:15:33 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAB6A5-C=YsVca4OQJZ=tOg9mjzEjobD9b94Mkvc0Ora_uQ-GCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.73.216]
X-ClientProxiedBy: CH2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:610:4f::36) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.9] (70.64.73.216) by CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 29 Jun 2021 19:15:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937c7e48-cc8a-4bfe-1dbd-08d93b324739
X-MS-TrafficTypeDiagnostic: BYAPR11MB3432:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3432B1D8541A162FA1EFE05EF6029@BYAPR11MB3432.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtQX6UaVt7e4HPjqHsn0+E7pAxJaQ7LOmwApixBdAvSnTSJlwVgrGVP7pWVRJufNLUQiaiKF8PIWaHKCHa5sG4P1eyNXpzwX4sp4Tvcbz/PrydBBA6PzQpAkj8F6X+iXJHvSWJRckbLDRfvgmQLEPS6V0XuhDMaf2JaA2HIHVMMCgFLzGPkKoiadLkPUb5/9ZKpQpfH7YYOuLw5TZT9Yz0z1wkh4EFtogmugOGgJj5b4rjINjc+sifSsxi9gHcaXoHuOFZYgOwNz0Db1viCeWC1gGeeX+dGEZu3REMym6hbVUH6YNSQbUZXUWeXt+UIZTxvJnAL7sdzal2dNFKCZoU8c5d+jRCFsZmmkEKajrdt+K1BwiI0MTPJP3P7r9PPF7XGT44W6hRtp5l3Rk9WVqPrUYvzT2+41J01WfnVw28cvova8zQrLGC3bB+d/Znu0SViHOvq+S+2CAFiHAcaXJS4BeSTobBVF36a1nStPBoGVrWvp5ujfGIBBrsaRdxvj8YmoJJEloQtafgY1142AjPRTMWwMKVsn1213o5z+bQA/ymPIPXprl6xZ4odzvwYXSe3T4mtXDKkUBXyn6TIzkCwzJo7CupRYhK8WXGw3vQD4MQZ6sRcYkxikxbxMHF7Kjwx60YuNqfG59WOFxA/PEglgF5YMNWKdNbFxrBR+WOgZxubLgKWBk7PZXlv1kFTUCE9NyYP+F0sUravdwnXE/aRvHhLSnfi+8D3wyDKHu/ULb0Gqy9IZu36YYM/BsrEn8YH798JlI/FJ76ySpvcltA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(86362001)(38350700002)(66946007)(38100700002)(66556008)(6486002)(66476007)(478600001)(52116002)(2906002)(316002)(16576012)(36756003)(2616005)(31696002)(44832011)(16526019)(956004)(53546011)(31686004)(6666004)(5660300002)(8936002)(8676002)(83380400001)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNUMzQvUnNoWkhHVkoybmNRMmw3NVVQR0RoUXdMYlRZQTNmQ0dDckpTRTE5?=
 =?utf-8?B?Q0RLWkdtYUhFTktQNFViWXRyK25DQ2ZRVno1bUpGM3dtSlJDNzVtZ3ZNOGF1?=
 =?utf-8?B?TW02NG1mYXFqdmRlKzR4L1JJVmtmVjU3RGxEbUR3WjROazRuMlpycnRVYW9B?=
 =?utf-8?B?QjBOSjZxdWx2R0ZGN2Izd1VLSG1sK05kNmFEWDBzZzFISGxrQy9aQ0R1czYx?=
 =?utf-8?B?MXJtQVQ3ZGR4K003VzgvbEttRi92U0xpTGRQL0d0dmp1UStXS1RwNFliZ2pJ?=
 =?utf-8?B?QThkZmc3MytNUzVIZkRYREFQMHNiMm4wMHp4dDF1UVBSMFUwYU9Jb3A2RDVq?=
 =?utf-8?B?ZHl0SUNRajArcEswRzRxRm9kbUl4Zklpc1FNUWtReGlKVmZnZ0lOa29IZi9p?=
 =?utf-8?B?UnA2U3o2M09OakpWU1NkYmthc1R4TFh3NHhhaXpocWY5eHk2RytPcUFRNTE2?=
 =?utf-8?B?WTQ5VWJkcVU3VmdDc3lYSWVnYW1JU2xMWEkvVHJEYVE1Y2VUbWFueEFIK1d5?=
 =?utf-8?B?UzZ2d0g3V29TMGEvbmxkaUVCL3VWL1Y1WFVQdmptZmo4UlFvZFlzUWpZdVU3?=
 =?utf-8?B?cDNqYzArUFY2eXluQ2tUczJGSW5qMTVNMWNGeW11MWl5SDhQeEtDNlhqSW1L?=
 =?utf-8?B?eGs4eS9VUmJ2RDNvWUlvS0EwTFhJb0liT1BORzVoUjBWUmtQcUNnVEZrVTl5?=
 =?utf-8?B?SmN2S0Z0STYzeG8ycUtUUSsraGNRT0JxK3R5Vm1XRFlZSW83U2dCVzh2K2xn?=
 =?utf-8?B?clZ3K2V6QXNDOGJZOWIxTEpCWEh1RFVKQmE3RytERUQ5RkJPSGV6dDVkS0RI?=
 =?utf-8?B?bXJ2dUpiZmYvTjB2LzFKRFhMSmZ3QXh0YVBKQUpiQnR5bFFRL0VMTW8yYUhu?=
 =?utf-8?B?aGVFOXIvVWcycmNHaGErNnNDOU1DdkVJMWZ2d2cxZFFORUVXdFpDblVWZG1z?=
 =?utf-8?B?cENMRVJYUWZ1TW5qTk5jWkdVcitvcDFqT1NMbU9WLzZHMkRxNUtFKzJ5T3J5?=
 =?utf-8?B?dEd4VUkwSVNCNTJqU1ZFVGRrd1dFU1FUUG9iZXN4RVE4QmJ6OVZFL1podUg1?=
 =?utf-8?B?aDAvdDB2YVlNaUtmalU3K3BEbi9iQmlrb3R0c1dkY3BSR1lacytSUkdCNnZE?=
 =?utf-8?B?YzhOdUdJV2NHNC9Qem1MWGpDdHltSmQ5NXdkeFViaFlaMzlHS3AyMzVUWU0v?=
 =?utf-8?B?Y3ZjUzVHS2NNWm5NRnNtaXhFYTcwdGJ1eUJ0Y2FoYjQzb2JvVy9sVU01RTlG?=
 =?utf-8?B?NVJyb2gxb25IZE8yME5CSU9wd1pzUzdYOVZrQzJTdUNXUzZ5LzVPTDdISEhU?=
 =?utf-8?B?MUsvZ2xUbW9RVWVqK0NqNHZTb21YbzAyck84eC9TMEdNNE5ZMkJVVUpLVjkw?=
 =?utf-8?B?bytqdVZhNzZ3VWpmZS9JMUxvODNBOXRzVzEzNGNYbVpmOER5ZVFQOWZ6NnRv?=
 =?utf-8?B?THFsbHlGb3g4K1N5K1gvVTM3djBjRkFSUHYvaFg4MEFTWUpsRDF1bUdUN0N3?=
 =?utf-8?B?RzJMa3QvSWQwK21QQ1JaSzh3WUpkMDRnS2txclJQSk85UHo2N1crYTVJWTdZ?=
 =?utf-8?B?czl6bklNeHhEOWk3eWlsdktZbktrdXYwT2d0alRoaUh5bjk4b3I3S3pXQ3ZW?=
 =?utf-8?B?anZRMDhZNHRwNlc4dDJ3V0pjbHl6dEFqbFg1R3dXZVlsbUtXcFNFM2ZXc2hC?=
 =?utf-8?B?MnYwT2s4OHFVclFETkxUdGI3L1gxQUtlbG1MWjFDQzFUZ2l0THdrdzdWaUdQ?=
 =?utf-8?Q?m4I4NzRt9wTKiuI7ajBragtfnhYWp1SlMfy/ZIl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937c7e48-cc8a-4bfe-1dbd-08d93b324739
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 19:15:38.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG3FQHFZVlFJJ9GMImLlJbP8PdzpAZzio9R8fFNKhyuTLKpIDgRA201SV4vMb3RCIjli62MAaWjLGTReb7KZRMbbzikgcyI1tofIyldRyAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3432
X-Proofpoint-GUID: gO2P27QeiaXdKTzWio0Oa8VE7bX4z1yD
X-Proofpoint-ORIG-GUID: gO2P27QeiaXdKTzWio0Oa8VE7bX4z1yD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_11:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290121
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If you look at the Kconfig files, you should see that selecting 
CONFIG_HIGH_RES_TIMERS selects TICK_ONESHOT, which means that instead of 
programming a regular interrupt timer tick the kernel will simply 
program the next required timer interrupt for the next timer that's 
going to expire, whenever that happens to be.

I *thought* that there was code to automatically adjust the priority of 
the hrtimer thread based on the priority of the process it was 
delivering the wakeup to, but maybe I'm mis-remembering.

Chris


On 6/28/2021 10:54 PM, manty kuma wrote:

> I went through the source code for hrtimers and understood at a decent
> level about how they are working. However, I have the following
> questions.
> 
> - What is the clock source for HRTimers and what is the frequency of
> this clock device?
> - with timer subsystem CONFIG_HZ can go to a max of 1000 meaning at
> the maximum only 1 ms latency can be reliably established. I
> understand that hrtimers are not using CONFIG_HZ but i am just curious
> as to what their clock source is and how 1 ns precision is achieved?
> - I am using a RT kernel and I see that interrupt handlers are
> executed as threaded-irqs. Is it possible to configure the priority of
> the interrupt handler hrtimer_interrupt()? for a FF process, the
> wakeup() is called from interrupt context(called by threaded irq)
> which is actually having lesser priority than my higher priority
> process. If possible I would like to change the priority of the
> threaded_irq  process that handles timer interrupts. I believe this
> way sleep() will not take longer than expected.(I am debugging issues
> where even my FF process with prio 110 sometimes fails to wake up back
> in time)
> 
> Thank you in advance!
> 
> Regards,
> Manty
> 

