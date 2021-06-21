Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD982C48BE5
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Jun 2021 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9E86100B
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Jun 2021 07:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFUH5B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:57:01 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com ([40.107.3.115]:18502
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229618AbhFUH5A (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Jun 2021 03:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LK7J96kP89a5j3RtmRuSwX430u60knMkLxZWKxLGQrA+G9ZYcvWK0D0fG2i76FlQsmIyfwIa6nEmd71d8boj3/aUzfj/nl0jjkWAQ45vHGCrH/vyk+mt0qyfTQtks2bYTjIfCCIu1cnYv2OLi3WI8fJewAxYqfVqM8QFyfgbbnk+vuo7qYsBSz41r7dfnzcUld0K0CtV2OF8bq6rDzdlmTAy2Sy+AWEp7Z3Heul3rSRsQcPmMALZb1dOAkPXjsId7r0Ez73UxiovSF5XNo5nd17h1uBe4F3Z2Ft72DB5oBspUZfKbvBaS/MyU68lsEY2dGb3i6+ch+QBzbGADpqfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q6g+6qogyDMGdAGHNlw3fcoS005uDGI/U5Uw4FECmM=;
 b=FCRGLeRlfyUJpI0dRxLLgmUfNA9fnwKU1aDRic5Fx6z0+o5nxiCtPww9kppPSo+0/ojunBcrJwxpqm8AICsjtSvuS6uXiCQBcJOXXZhLV+3tGuWZWK35eNe+HJt9Nd6FUz46iH9fVLPA4t/7NU8Dv5jI70svm04B5FhJZ3H5BPdkD1QYhDj6HqWVNm/G/47Q9OMAUV86MX2aeAAT5sydr6SjwGbk8cxL250EQLCJSBwOXnF+1GnsCj9lkBF4tNYaCbpVsPEz/DgjCMOrPzIOC6feDLza0VtATnkyDluV0sRpanLVcZMPqONMPwQNgrWor7ECFuENMPwsyWI6aw1oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q6g+6qogyDMGdAGHNlw3fcoS005uDGI/U5Uw4FECmM=;
 b=fKROR5HpmmqXcSaR5sNYRd3jNFPiqy26D/MpLozYTjVKRZvKir0Kkbbu9kCw25PudBdVz9ip9G2YpfrGLYr1eIMovemPKBcsoJNQU1gfBC2RhtXDrL/HBkDuhyugFUxC0ZD0JvqLJ9f2uvIx+UPsyEgLYTyXtzWM4GRBEl1YmrQ=
Authentication-Results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:415::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:54:44 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fc83:36a5:db02:3dbb]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fc83:36a5:db02:3dbb%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 07:54:44 +0000
Subject: Re: commit 3d5bfbd97163 versus -rt
To:     Thomas Gleixner <tglx@linutronix.de>,
        Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Esben Haabendal <esben@geanix.com>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
 <871r8zey88.ffs@nanos.tec.linutronix.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <89f1be10-853b-1ee5-d4ef-48068c591af5@prevas.dk>
Date:   Mon, 21 Jun 2021 09:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <871r8zey88.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.64.110]
X-ClientProxiedBy: AM6P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::32) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.64.110) by AM6P195CA0091.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:54:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9b5178a-decc-47fd-88c8-08d93489d4e6
X-MS-TrafficTypeDiagnostic: AM9PR10MB4838:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4838B6FE0E0EB2CE8095318F930A9@AM9PR10MB4838.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fm3T1eTDfgZXcsfMNXPG3RCCP+8RSV3/5j/uD+kSrXBv2PonSxDSEnU46As+c4wYP8xB5nc7FvEoI7Xx/Y2OKOVuaASGyQF/zBZPglvqZ/0uqx1CXhaW1THRSws9CbRhqeezx4dHSH7jtYtyi0KvuoqQFnPK7GY84UaIQzmwvsXvD9FxtYVThu/yK6Wz96CsR0qoS4OM6mJ+krcP3oTSBEYWYw/F10DL+v9F4bbzq8h2Y19rV8tkVtwVg5qSLXMzVH8Ue2UtVGlspm6F91Ob6tyITQ2bBnhAQBjsEjbOyyaf0raNDJ4vUKuyF+bK2HiuL8JTUNLpDYFKk0yL/FWf9Gv12+Df7E6Zxy4YBB8cDTXQQMygBf2m223LVoeI48CV2RqJd2NMIrvyYEyIq15Ld11NZDS/jfbpEbubDwNoZLXtwHzwXgqc+0tLH7kZgtcDQitN7HEMGUdwUhpwW7LgNkMtAqXf5FfkpKU3vX+Ax4Np7aWk89eqDzepRHjFqsGz53ZXAm6g8lPTAwtp4RGC8WmBnSVOji9S6zqO6mJ1pP5HLdDkzrlAgDlE7/xaeYkL3/+pZSBwVNqw6hYNmxCc9XADv1yS5jZHcuuTtZMoFYTXU7ly7fOiW+ZIlHsjDEyM4exxgPl1hEKsbLhURF5N1+g02cl6Dhd+OUx9TQYBCE6qiWOLgavaSWDxn2b1/Vwt2TJQqlOiMTzmGmzJVzh0wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39840400004)(8676002)(478600001)(52116002)(36756003)(8976002)(31686004)(38350700002)(8936002)(38100700002)(316002)(86362001)(31696002)(6486002)(54906003)(44832011)(110136005)(5660300002)(66476007)(66556008)(66946007)(16576012)(26005)(16526019)(4326008)(2616005)(2906002)(186003)(956004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?scpjFXXbEjkmOh5RUwJdwsfDReQ4Voi8GvEe9jQFsHjRdbF2S/G+fWt/?=
 =?Windows-1252?Q?1dAq2Kab/LqY0t9CznP+PHTw/LApW3hn/0/oiTz9p53xjZz3XkKmQHkm?=
 =?Windows-1252?Q?0K+Qe2lmi+arF/raQhmpyrgGQ8WplcQYmCTxpo4qFsHQiBFg9QBpy13u?=
 =?Windows-1252?Q?TrlB5x74Fc/uX/pXxU+Nmx+GpczFFE2IC9ePF/9KEKX2VVTDOe0SSaJu?=
 =?Windows-1252?Q?wZ4w/DXpNrMpVEJHmynitFlD+MuRYmVBh0thVmXNSXnyz6jaa/OaxtRK?=
 =?Windows-1252?Q?IlEB9K0mEoUirzMyJ9T8etIBWtpXgFooNglucXY/E98U5edr/2TJ1m8B?=
 =?Windows-1252?Q?8yY6v+AtlE7nX5YPQEgRK2AyelvUWH2uEJShWKvfhyLxqrOWXHT5lLpx?=
 =?Windows-1252?Q?5HY7U55gRD/i64cACirPlZES9hllE6JPbITPTSIe45OhiW1d9JwOt95/?=
 =?Windows-1252?Q?xUDnvKc0dv7SUsnUvyTzyoPLAkPnfVIcVTsEjLC67PEHA8jSy7OrmmEJ?=
 =?Windows-1252?Q?fxF1D//kRZy+T+DFenmA3GOlVLRRYqGk69ss301FxWnWVUx/WArl+FG9?=
 =?Windows-1252?Q?2nlevxRfzEz2TkqQo5UrpoOJdYZAO1bD8/zL/wt2jG0xbdVC9bh7Y7yH?=
 =?Windows-1252?Q?3+gbiTlcDGJGs9l3tqFAZ5rJj/aOfVLYrzlQfcJrR5T7vlHxTjf1qgd3?=
 =?Windows-1252?Q?kAMItbt/XWLXQlCsE/+jmI81hLhXVDjUhM7Tq5Zfm8QA9Z2OdLM9HQzx?=
 =?Windows-1252?Q?/iVNFtt271l9gognKJuV0u2x0/GdgL2O+qmKdnqTIbqz4Oa3crq39Tk/?=
 =?Windows-1252?Q?isRfaAKsPH2Ch2y+6NpqSur5B7UyUVJVtIguAWO/jZc5fesjwilrum/w?=
 =?Windows-1252?Q?a/YvUmqi9GahCkcsog39XGWprzA5YRcMiv1u/7wGdXoMgzuiuHnjY9wM?=
 =?Windows-1252?Q?ar7vl3RWqMATQw4decG/R+VP9jvM3RVs12lduoqrKHsPNTaShDzzKqbC?=
 =?Windows-1252?Q?KUjtRbMZWGxGIkFF8W4qTpwKchgTWUwhvBRevoMH2Ttqih4pwI4StPKw?=
 =?Windows-1252?Q?LgdBmiHXTX15lI1w0EPdiVYihV2m6qccof8plVBaLLhoz6Buz+MjDXet?=
 =?Windows-1252?Q?3iL0fx7Y6pnJ8PPKVgLV3jCTAVk/cdpXmpUgW5HGeBLYdsFXB5SVo3LF?=
 =?Windows-1252?Q?wq/QAgfeQlHhcVLqjJyzrjkXgrjtC37Hk4p3f+jwkUKAuqWSPHTulfUT?=
 =?Windows-1252?Q?k1LV/z5YehC0knoc5HJ9MGRgMC+c5xju0xGv6UOS1kc+9Tn4Borzp0Vj?=
 =?Windows-1252?Q?ngay9KcGBAwHlT9DxieB8cevfAlYKQzZPzDEv1qMDTeppGYjgZB/q9qk?=
 =?Windows-1252?Q?z/XkK+xBcJag/hqA8KqCDitRmRqvkmmaInyF39u2xgrCsA7EPwpkVH0y?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b5178a-decc-47fd-88c8-08d93489d4e6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:54:44.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMkj336dL4DQPQh1DOirhq5ivh7C6r6rVnvwwquZ5wG9loFPF6XLwX4kZ/nxKsu6CVCFcC3goWB4F7G9gxpJ6qWZmk6Rvkm0LO2oMqkuvs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4838
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 18/06/2021 22.04, Thomas Gleixner wrote:
> On Tue, Jun 15 2021 at 14:35, Rasmus Villemoes wrote:
>>  [<8016fb80>] (generic_handle_irq) from [<8043e98c>]
>> (mpc8xxx_gpio_irq_cascade+0xac/0xd0)
>>  [<8043e8e0>] (mpc8xxx_gpio_irq_cascade) from [<80171c80>]
>> (irq_forced_thread_fn+0x38/0x8c)
>>   r5:80e282c0 r4:80deda00
>>  [<80171c48>] (irq_forced_thread_fn) from [<80171eb4>]
>> (irq_thread+0x11c/0x238)
> .
>> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
>> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
>> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
>> that option exists but cannot be selected).
>>
>> This seems to be the kind of thing where an -rt expert can immediately
>> see what's wrong and how to fix it. Ideas anyone?
> 
> Let me explain. The force threaded interrupt code in mainline made the
> wrong assumption that disabling softirqs is sufficient to provide the
> semantics of non-threaded handler invocation. This turned out to be
> wrong and caused people to do fancy workarounds.
> 
> See 81e2073c175b ("genirq: Disable interrupts for force threaded
> handlers") for details.
> 
> So people started to remove IRQF_NO_THREAD or local_irq_save/restore
> pairs in drivers.
> 
> But 3d5bfbd97163 ("gpio: mpc8xxx: change the gpio interrupt flags.") has
> nothing to do with that:
> 
>     "Delete the interrupt IRQF_NO_THREAD flags in order to gpio interrupts
>      can be threaded to allow high-priority processes to preempt."
> 
> This changelog is blatantly wrong. In mainline forced irq threads have
> always been invoked with softirqs disabled, which obviously makes them
> non-preemptible. And on RT this would have exploded exactly in the way
> you observed.
> 
> The commit predates 81e2073c175b and therefore was obviously never
> tested neither on mainline nor on RT.

Thanks. Commit 81e2073c175b was included in 5.10.y per 5.10.26, and I
can confirm that booting a vanilla 5.10.25 with threadirqs does indeed
trigger the same splat I see on 5.10.41-rt42.

> Bartosz, please revert this ASAP.

Thanks for confirming that reverting 3d5bfbd97163 is the right thing to do.

Rasmus
