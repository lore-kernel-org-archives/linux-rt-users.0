Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D5C48BE5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E43C61461
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFOMhi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 08:37:38 -0400
Received: from mail-eopbgr130130.outbound.protection.outlook.com ([40.107.13.130]:31526
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbhFOMhg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Jun 2021 08:37:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npx+Jp7H/0xuVPre6TvcidK2MyA6Lp3K4UPM/xIRO7Y6cpuU9nhe4NYtLcrVOwxbdct6TwHZsz3vDrZf6ZTs0E9KC/6aXNO3pmIhBf1+DUZHcFsmiddafNza0HwDemiwRdnpksrz5Y7N3CjMG22FfDStI4YVdaFclmgRI3wGElxN7L+Ed0FJzxZUEh77ZryhAbh8HBkgFYi3tnY8r0CzwQ9Jt3L5XdiSHwS/4DRfBQurJev2c6mGnUuii2g4DzMQ5rp9RaSGWHHaGGg4Za59yDgIn7m2H7s/3XpmR3nrP/6R+whBY4vZ3P2oCvV0Tr5AxGRPTUxwbIq6iSxT8HPAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR/W+lBW3yAL5ILw1XhetJW2HoBUap/ALoRGtn6EcWU=;
 b=NVBHcO1qdjhsUkGvKT/FilP8anl9XDGaVBp8F/2slw0yuMZTiM4MZIfI/SViRZk3fahmMHtJInD5fhkX83A8GV1xw+gxEzsIUvmdimJh7NTqWCSnbwGuczfG6bi5Qwj2iyTB1O0c4PQTOI7LLFIIazkxAfxalBDId5Po0UWYslMLmyohXB1EFkdZUVRqRSsJgZ+9bfZ516UKnxcP7PqzkF3EpxJzLpcewP2yNRGzvwGzCl4i1dgex1WxFCyqJ5gVffYtP3jQlG1CsQtbD+xCiTJpDs5mxunQVUzPQzcDmByK/xU6eyCJqDtyOgQ3YBk+WcerhGp05CnqmmWzymrWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR/W+lBW3yAL5ILw1XhetJW2HoBUap/ALoRGtn6EcWU=;
 b=T7IqrIg1yHXhwnspgLW/pr4xEaEwB2Fk+QqYrmrOAo4y8u5kJvxGW7dmzhR4m7okk2VP3F8itxJbpP9dXo7XrksaPOkMJi4qCr5DWbCllo3N3MWVNozOgnWxX5vCJrdk4r9hVxGdmKEtctals3DT2vBaypIxeQBooRvBhkS+0QY=
Authentication-Results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 12:35:29 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 12:35:29 +0000
To:     Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Esben Haabendal <esben@geanix.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: commit 3d5bfbd97163 versus -rt
Message-ID: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
Date:   Tue, 15 Jun 2021 14:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.64.110]
X-ClientProxiedBy: AM5PR0601CA0057.eurprd06.prod.outlook.com
 (2603:10a6:206::22) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.64.110) by AM5PR0601CA0057.eurprd06.prod.outlook.com (2603:10a6:206::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 12:35:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0e43228-8ec4-4b94-261f-08d92ffa0f6c
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:
X-Microsoft-Antispam-PRVS: <AM0PR10MB31727CF387E51F424BDCEED393309@AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yb8Lx4g5AayMO8eJ3k/UaiYvb5SoBbRn1QliUforTbRycjM8zEQ7KQ6CxLEfIXsVUwEi9PFxIbPFkBxndv3OrXmj1iLtWKqVHUDsup3/y3BQ8kZAAfmM2MFySmpQksp0D3Rx7eFj1i4uNQfsWviDz+nrsaYrEfoCFwbHchu3Ql58cpR8DJakX+CQEqqJRZLPd1ciGD291aBcLXfYCBwChFshrrAJAxVMV5LH+P+099eSbfHV0mtPUtjEWSJwQ7LDOuHFXYs10MBq1yXeF9MfEJrpxvlZvB/IC/Gz5+jyPWOKK9xdka66jpJg5TGuMBUoYMVH1d8eZuN+aTBYXR80BC53JY++kug3FQKyrlubHkowB/SnBi4BnQFOcnG3DHi1508IGkK9bgBm+fBoJq+CdfF78RB15cJm1cebnMSy1gcrqShye2w9cFx7GERpTeIavPLbJUL3uA/RJOfEKc/fSeYuBmAJ0BLSU5n0oBGu0TyJMj2TtyoiEksfg94aKgJh0T/Wjrh3mIOVc3q1sZ0nbJPi9NNi8tdIg4Rhi5bOzDas8cuXwiiHnLsWgmMFxgzLMU6jJdTwn5oNF20Pq4Odugn5PIItUT5MiDR5viFAeAe+NOjnNO8TSLEBdDQhoHYy/ZiqTZX056TP4/zXo2bEnE5LdNztavvdgaRiwe/yNZuRoQfxYqxRtXgQe9qD/4UYAv0mRy8dCmKmRSbObYXQpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39840400004)(346002)(136003)(66556008)(44832011)(4326008)(66476007)(52116002)(38350700002)(38100700002)(8936002)(8976002)(66946007)(6486002)(478600001)(86362001)(83380400001)(5660300002)(2616005)(31696002)(8676002)(956004)(16576012)(31686004)(45080400002)(2906002)(26005)(186003)(16526019)(110136005)(36756003)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?fvw5kfjxtixNvaOOpoKlgvblN0rDczzCRgGSBUuyVqUyZla32DTFeKiB?=
 =?Windows-1252?Q?tUk1NqUa/HJ7gw0hSeCQ1985rBHEzNDOB77wBYF+FISwC/lJFAI4xp/c?=
 =?Windows-1252?Q?Yxym+QxLcXpUQ/ue1mA/4wOuCsVMz97FSmqbsDaVUmUpKKDPfSyYr4Vp?=
 =?Windows-1252?Q?GtpHBkVOImS0ZH+f00+EdPcfcONJ0X6G6oIkzJBEPhgFz1Favmb5ytjK?=
 =?Windows-1252?Q?Evr5rsfzmi1b2gUQjHDwZSC1Uufqw4qFWS9WIgjELtinjFVZ2XuS0QeO?=
 =?Windows-1252?Q?2um7r0xmTmeXz0n6tM5hD2p7Bye+Vo9NoBqKrpK6EGABKDMWPQB2UVzY?=
 =?Windows-1252?Q?2g8bBy9lVsRa1McWN9Q0yxYyoYXxtqG3SAfQbrHfVpS8LRCvuW6Y8na8?=
 =?Windows-1252?Q?uY34MK8vcY4SRahy/o6C2GRTM7SzCB/ankbBdnr5eRAcsQyb+c9OSBAb?=
 =?Windows-1252?Q?Zc6RDMcyy0N7+T0st4vpXY0W8nrC+kDfx210Zn2AtZMOIC69S6j41MO0?=
 =?Windows-1252?Q?nCMAW+R6FNocmNlKl67ofe9pLl6s2nAbZCXQt4FKH9c5AHRNGohU1Eh0?=
 =?Windows-1252?Q?9V7MMbiTV1Wsj8Em8eVeWrulSXPBpgO3bFbGXexEXJtMQxrySO2E2BNu?=
 =?Windows-1252?Q?Musirz3C80Ya4C5RgpAW7cqWyTws6v1KGYG7yMnUGs+sOzcKzkzwi3PD?=
 =?Windows-1252?Q?j5J6E/8bQzrkuKxLWCQqCuWvhBma3cCet1LeaIbf84gIRMJT0R2ge6WB?=
 =?Windows-1252?Q?aeot6fqU2bgtSRIaLMPb8PV9LNSdHEHGOsD0LLjxujkUve4/OoiSJajs?=
 =?Windows-1252?Q?lB8JQLzyxNj8drl8Kn/InxUrd2Vmd7eHp4njac9cE45Wq0qorU6bUh0j?=
 =?Windows-1252?Q?4BZHic1WXFbrxeomZIu9ZlkytDLOfjixVI2eHGDetzqa0LR4oAzD4KCC?=
 =?Windows-1252?Q?SHILmB4+IgG5xtvXrY9jWk6QwyIA1GeB6wz35tMWT1sCkEamZTV8VVir?=
 =?Windows-1252?Q?T+ZY4kovqc0viSVO/WiQNrMh68its4bUPxDpyHFN5VWdMQK5Cm4WfvXy?=
 =?Windows-1252?Q?PE2q2KNk8bWOJ4fp0ei+3oAAnquu4gcHN1L+riTl+KfoqVdbVelKmYbh?=
 =?Windows-1252?Q?y3o9Nvm2X/wkcWbQeKQ2GY9X5Ini/v3EmP8bO5kKGKCQbS7WFhxxhY2e?=
 =?Windows-1252?Q?ETIif7PopZwdPyGEEZ9ifaTqh/fMwhIuZiJkcQ/TLI3wUnnmrl0WhWUK?=
 =?Windows-1252?Q?u+kAbrNK2RuWr+liBoBqo7gvs28FiKT0Xj3rFoYH4hGBeZO85gIV/nqQ?=
 =?Windows-1252?Q?kFYLOxr1PIdktIieTJ1Wb6q2CXdWxey4+oHXUXxrzNTBZ9insMBX1Be5?=
 =?Windows-1252?Q?/7QmO1AjCDmkghtFCNmNszePHsIx2dBjGUWY4NAzrnKEcjDwThEGFi8T?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e43228-8ec4-4b94-261f-08d92ffa0f6c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 12:35:29.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMthMQq+uWK1p30QOznvoBsIDNsFDGvi56Z6tx6WJthQDcJmnVMMTQrzjw+75DswmifP7y3nz4QguFGj7x6bmoqe54dPnsrfqXa1Y3DqTC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

Booting 5.10.41-rt42 with CONFIG_PREEMPT_RT=y gives this splat:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 29 at kernel/irq/handle.c:159
__handle_irq_event_percpu+0x1ec/0x27c
 irq 66 handler irq_default_primary_handler+0x0/0x1c enabled interrupts
 Modules linked in:
 CPU: 0 PID: 29 Comm: irq/45-gpio-cas Not tainted
5.10.41-rt42-00001-g3ce830134091 #495
 Hardware name: Freescale LS1021A
 Backtrace:
 [<806ad420>] (dump_backtrace) from [<806ad7c4>] (show_stack+0x20/0x24)
  r7:80abad04 r6:60070013 r5:00000000 r4:80abad04
 [<806ad7a4>] (show_stack) from [<806b0a94>] (dump_stack+0x88/0xa4)
 [<806b0a0c>] (dump_stack) from [<8011d424>] (__warn+0xd4/0x100)
  r7:80e3fe14 r6:00000000 r5:00000009 r4:80170c48
 [<8011d350>] (__warn) from [<806ade3c>] (warn_slowpath_fmt+0x88/0xcc)
  r9:ffffe000 r8:807e5943 r7:00000009 r6:80170c48 r5:0000009f r4:807e596a
 [<806addb8>] (warn_slowpath_fmt) from [<80170c48>]
(__handle_irq_event_percpu+0x1ec/0x27c)
  r8:80e3fe80 r7:80fff800 r6:00000042 r5:00000002 r4:80ea2000
 [<80170a5c>] (__handle_irq_event_percpu) from [<80170d38>]
(handle_irq_event_percpu+0x60/0xc0)
  r10:80ae2508 r9:80171c48 r8:80e3e000 r7:80e282e4 r6:00000000 r5:80fff800
  r4:00000000
 [<80170cd8>] (handle_irq_event_percpu) from [<80170e2c>]
(handle_irq_event+0x94/0xb8)
  r7:80e282e4 r6:80fff878 r5:80fff818 r4:80fff800
 [<80170d98>] (handle_irq_event) from [<801761a4>]
(handle_edge_irq+0xec/0x10c)
  r7:80e282e4 r6:80fff878 r5:80fff818 r4:80fff800
 [<801760b8>] (handle_edge_irq) from [<8016fbb8>]
(generic_handle_irq+0x38/0x48)
  r7:80e282e4 r6:ffffe000 r5:80e3a640 r4:0000000c
 [<8016fb80>] (generic_handle_irq) from [<8043e98c>]
(mpc8xxx_gpio_irq_cascade+0xac/0xd0)
 [<8043e8e0>] (mpc8xxx_gpio_irq_cascade) from [<80171c80>]
(irq_forced_thread_fn+0x38/0x8c)
  r5:80e282c0 r4:80deda00
 [<80171c48>] (irq_forced_thread_fn) from [<80171eb4>]
(irq_thread+0x11c/0x238)
  r7:80e282e4 r6:ffffe000 r5:80e282c0 r4:80deda00
 [<80171d98>] (irq_thread) from [<8013d9bc>] (kthread+0x18c/0x19c)
  r10:80e121c0 r9:80e282c0 r8:80171d98 r7:80d15bf4 r6:80e28300 r5:80e3e000
  r4:80e28340
 [<8013d830>] (kthread) from [<80100130>] (ret_from_fork+0x14/0x24)
 Exception stack(0x80e3ffb0 to 0x80e3fff8)
 ffa0:                                     00000000 00000000 00000000
00000000
 ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
 ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8013d830
  r4:80e28300 r3:80e121c0
 ---[ end trace 0000000000000002 ]---

Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
that option exists but cannot be selected).

This seems to be the kind of thing where an -rt expert can immediately
see what's wrong and how to fix it. Ideas anyone?

Thanks,
Rasmus
