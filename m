Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04999C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 00:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80C760F59
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 00:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhG2AXe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 20:23:34 -0400
Received: from mail-eopbgr1400042.outbound.protection.outlook.com ([40.107.140.42]:60155
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232727AbhG2AXd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 20:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgQUYMNp6TF/yTFqfnzoBnORyFbwlFlsuosTlBjMVZ0S78ds05bkUsWieS5W7GMIHC3iXQf/fdMt2CLNmjClDBrrOVnzB5tjnhS187AnVAqzoXa9A+cvf4jMVwKInUipfx/wA4cvjab6vXf7NYpbOLMP/2OQ7bnS6w2i1xeT9vrHf8tXqAixXrSUiHS6ru7TvBkv9lgw+tYfpFXYqQb3wCUAZbBnueGcg/taPUFsSRmjG8rs6ANLfWPcaBBkrZa4nUpdWq9yFTnhlDFmRhme2C90whmWRRQvbgedYBHr6zyb4/MX9wrIZKoB6wFUJJoSMGSAj1zzZ1jtrI6nRpoROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRX8WuAz/2KyThtLFrHyhyWO5WQzyxKFUHGUxKNm3RM=;
 b=CPy68KkR7UJVUTxnSEqNpdiQ/9/QDJI6NWh0az1vwiQ0fgc1SK8WdRZH2XCgSii61+3j28IbrhqCfgbNKD6BECF9yX7pIWtm9TbGqNLy8FIek1Lpc/6Pn+WFEv+Xn7BrfBzFM8dHZHNCYin3EB+sU/QMB4vU7reDbIVtMcTZn5F4uSArGGoB7h6DseEX5mHE+dKtYRzl7QNiDDvx0UOZAlfjISimk5qRx34WBia1XZ+FonGs8Z83QLNBpSl5JRAQqCpzjuKEeYHMIcMFE7IfG/nDzg0xKJRytfgVew3fa156TYOdfQJuM2IGYJp4Ra9zwEW12/ZBIDNxqOreeJz1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRX8WuAz/2KyThtLFrHyhyWO5WQzyxKFUHGUxKNm3RM=;
 b=FR9oZ5kdiuf85wx0/q4+0kbZbWvyN02YI2HxOXg6QW0GjLeCkljRZu2Tb5ShnSv5QytfLxTxJQNsd3YI01jAF2sZkJ4W5pyT/9HBV59rsddi3zUxid4YK+gfQOwsgykuVSiey5qp8fIWPwId8Xjjtgv2DYQMU0znKiKYVrde29c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB6102.jpnprd01.prod.outlook.com (2603:1096:604:d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 29 Jul
 2021 00:23:29 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%6]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 00:23:29 +0000
Date:   Thu, 29 Jul 2021 09:23:28 +0900 (JST)
Message-Id: <20210729.092328.1410316616346703094.atsushi.nemoto@sord.co.jp>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix argument passing to
 Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <1643d3d2-250-5a9d-731f-fecf8f2f2b17@redhat.com>
References: <20210728.201927.2141210326291227293.atsushi.nemoto@sord.co.jp>
        <1643d3d2-250-5a9d-731f-fecf8f2f2b17@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::20) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR0101CA0034.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::20) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4331.21 via Frontend Transport; Thu, 29 Jul 2021 00:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3216e839-b4af-4c92-bd5b-08d95227171e
X-MS-TrafficTypeDiagnostic: OS3PR01MB6102:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OS3PR01MB61023DA95087955447B7229ABBEB9@OS3PR01MB6102.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/pUKjB5kbOvG/HQcx+6ez262Z4m/Z3cfxOCnnIkin1l0R6Zx7mvCSCYWWgrReqNJofK5dI3oOIJpI7GB/7U3of5kfFxCf4ZrR74cvXIJU9pSuYJqlQaZPN0Bu7FpfPmznPfjIv5q9ONmP3uRVZ+h4xtxqvbDKeQ4gIzVsBd+ehVbBNsYrFVdxGWP351IZlFmFuM+KTUuNYLMs9jBbE1exJFSB/nQDOZmCb5yq2O3EWoA32Tk18+4Y32GdGufbRMccLtVr8lot25x/LVw6yRdDJe5uH9UgBma1HZ3OEmFSvtPCOrG3yJmxQpfR8r3ecjxFekYUrAj23YOmx13xvF5uiwWsyBbQu9WCMQbkuYM6x45OECYBl/k2g/GNuq4QhVARlAKZGcy/xhQ4pSy7kmIXdjYm9z4clytjnGPsotaT2Hw6gGIqVFbjFEUZDRDAzEJmELA4zkiScPuL1wvVcI+spUtgrs6wwbwzqZ6jAlEL1cA/ZDfNzjORlfkqTTffe4uG5XFllDBgdIu0J4QBLudS1Yl+iRzHBNmqTHIG2QKwDp6rsdJUcXLrQ3XGRQoOY9UZ1HLVTNZynls2ckAVq5qfyWrh/jMnm6rfEYfM0iNUQ7E/M+tsRIvbFXT+/Z6U/87YwvqBook9eE2qtMQM9DZ80uktuH79q348IBYZ7nkxNdeFk5QJl0e2qYRHtxQmUoO47xJjii6j2EfDpBGw/tKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39830400003)(376002)(366004)(346002)(38100700002)(6486002)(38350700002)(86362001)(4744005)(66946007)(5660300002)(103116003)(478600001)(36756003)(6916009)(6496006)(66556008)(66476007)(26005)(52116002)(8676002)(186003)(4326008)(956004)(44832011)(8936002)(316002)(2906002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzFId9V7iMrGDyfNWvFQ5VKzY03LDvWwPVMs5iLO8UbzzxAV8CY8MpfUlJ65?=
 =?us-ascii?Q?K2ZReDHIYiBPQvPWP0j6OqiOrZBeQxE/pLisoTtDIY9dOAXlGg+ivzgRRYhr?=
 =?us-ascii?Q?idAT/laGPhzl/URrYAWvV7HscHEMq9eQwwehi37nVk7EsbXHr4wUEaG08aWG?=
 =?us-ascii?Q?IWSimkcP//J+xHh73YlILDIPvQkdMSTgFIVgztqg3MfJnSKbREe53B9kLgOp?=
 =?us-ascii?Q?ef3bA4ogo68s8gl+4uGVFAlpMtvvHP6hD0/EJeTZu7xg0H2DKSC8AHXembt0?=
 =?us-ascii?Q?f24BeCgR5pK2g1nvzlAQH75oD0ffL5sLOUD8e7GGPsanslwRTM8qT87DTn+r?=
 =?us-ascii?Q?+GZoqjm99dW6R7eBy+3eKAdIoURkE5NwYiYj2E3b21NizD45g/Ebi2M4FgQW?=
 =?us-ascii?Q?SJ7JYDMpfNff17YO9dfm0zKyRK6oy6RrcuCc/Oo9Fnv0D7tvTXLfCYjZUI/T?=
 =?us-ascii?Q?lXxAHnMzdkD5RN6Dto9JSOVkxP1X6Yu5UPOZAw44A9YnCbfY8o+o+Da7vmHW?=
 =?us-ascii?Q?tWUaUI4YFfEJDVLJJC3n2zjtFRFRB2HGdxHShXVSFQoYv2UrG/v5e1qUK2kh?=
 =?us-ascii?Q?w8ZkrIAifcsvKWOPzSPNamWChGwtRj/6dDIrd5ktEgUtu9+sQGt+MsjByilu?=
 =?us-ascii?Q?1DU0Gt8rSRUXEvEU4lJnpqAum/BRzms8woY7KxFAvbxUgMDvGKHemRuS6c/x?=
 =?us-ascii?Q?QtbfHkrcjkFH9Bf18EbpWroiNla/+3xi8GkaW60wx9JxvRVVANQPUNc0ylkD?=
 =?us-ascii?Q?bXpYini+sEDcL71iP5u4TTYEcOdk9nnT8LoYjC3LNc6qXm36LdDVTBc6Ayck?=
 =?us-ascii?Q?Yfy4GxJSv7ki8JVzPfcPKgguvUWSRyCQyZrekuG68+nOZGKNuIOfPiUTPelp?=
 =?us-ascii?Q?wVWsl6IOV1Bnr83Qi3N1c7RvgyE7vl/pYW1e3EWCtLhCrWqRwmNT222qsMUq?=
 =?us-ascii?Q?xnotModmDpy+Qn2nRYShk9dTPieuz38yB2loONczzX54PyIMUDXEKumO0J3b?=
 =?us-ascii?Q?SPdgLwvT7aySi+IA9S2pRkL4FM+kAH6+3WUpc3gR9hbHiVPrZ0KS0VD2dgu3?=
 =?us-ascii?Q?lB5oc+lMH/a7Cw+9uknDpTnIw5G2Y/TM2cS2sQELv+Z0cIgnroICsexnjP10?=
 =?us-ascii?Q?f3v3kjfgWmdiRu8rx3ztlW4BZBQtJC2FoCQjFjhPnLZsVtl0TqGK3c1POCZ+?=
 =?us-ascii?Q?y5MzSHb24UUmIDsHQ5XIs6XJMJQifZ+AFOPLGqn56f5By0mCMF+bCwgY+HRx?=
 =?us-ascii?Q?0+QvUzwYjbVg7PG76N7AJIGHLwRa//CK8OzXVkdCtGMPg9XPv/H0bW4bQ790?=
 =?us-ascii?Q?FwohUuOFOCGCMRExC6cV9IvC?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3216e839-b4af-4c92-bd5b-08d95227171e
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 00:23:29.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fussnMWTvJJ389eWG0Zr0hLZJrsOmbSgrbZ0lARzmbAbDsltSBLvZUv+v9tH7omSaui2oWuwvcObSOiMWXvaLmzAqYQzFA+d8kbOF3zmCXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6102
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 28 Jul 2021 17:38:05 -0400 (EDT), John Kacur <jkacur@redhat.com> wrote:
>> -            self.process = subprocess.Popen(self.args,
>> +            self.process = subprocess.Popen(" ".join(self.args), shell=True,
>>                                              stdout=self.__out,
>>                                              stderr=self.__err,
>>                                              stdin=self.__in)
>> -- 
>> 2.11.0
>> 
> 
> I don't see the need to do this here and in fact there are some security 
> implications to using shell=True. Is there a reason you want to do this?

I want to pass multiple options using --stressng-arg.

And also, there are elements with spaces in self.args already:
"--timeout %s" and "--taskset %s".

---
Atsushi Nemoto
