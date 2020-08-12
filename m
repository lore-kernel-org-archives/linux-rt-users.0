Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8CC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 11:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875932080C
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 11:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="N4wFbFAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHLLpK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:45:10 -0400
Received: from mail-eopbgr40136.outbound.protection.outlook.com ([40.107.4.136]:36310
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbgHLLpI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 07:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnAbf2btH/8q2j3KOYm7t6zdct0nGbOgTNR4Jbjjah3RAL0CyQwuh4TLyCMLrjeDTOTmnTYGGfzB7E05lUmG6ZdyEk798yPEty0Ly56/YxKxavuYvLR4Ygmwo9W22OLndbikz4pVSFY9RAb0q4Mdt4Et80oqTQ6cZlYQLu1ZOtgzKre74vBqS5jFOykXKqLtuCl784C/k1Zb2V/fG/zfwOzl1xNmT71k7hfTr6caAwvGcJx6J+dcQS7H4cj+YmfRMg9QDP6KMyenc6mtsdcVLtwsA0UFus2GV+XiCmXxcHlYvr7I9qeiijFt2AzDEe2iaVqx4YTZ2B30KuIa0h2O7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYriiuePpzG5FClKRl/mweBYjO5CI8ailf/iWbNfzf0=;
 b=bvdWpRogUA09HTx99qYmMLlaaiHl+opz4sPg1qf8Kh7tOVx1rzEArE4ssgML2yZ8zRDou4Qu4Q/L5GB1m9dV8DDX0snGeMhZDBwbKydV1MGQp4Ubj4o8j0CpBIPd6vunLYGyxDwRW+zszoDUkf1bhIVI4qu/qeWEwdT/cTAuSl27s0QwX3W1h0tWNyWW0W4zU9319XUKSK7vSRpl13fbA1avLC786fU7FrgE9HcEKbbf3Wqq4bqU86t8WLCC4zc7V4z4F8kErCZFDTQORXTcTbLFTrjkJjA+Dm8aUUUCHPH35JMuWg/kg6xoonwzRpT6ce9HmJ445Y+4B/vsrmG+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYriiuePpzG5FClKRl/mweBYjO5CI8ailf/iWbNfzf0=;
 b=N4wFbFAi0daWoLXcOTb1mU2rTOJM+o/1tmkDy2B/WZWKQ2czLsXmKGjgo9Ihn8z2xzlMkvW4RJ9IxSbwXdM1m5aOByVPTLsANPLc1UXwslcnImL/4xYNc4l+E5lYt+9Xzt9see7wjg66PeTfMMaZrMidS8DKe5a17d8jyZiNgPA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB1940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:45::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 12 Aug
 2020 11:45:05 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfb:a3e6:dfc0:37ec]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfb:a3e6:dfc0:37ec%3]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 11:45:05 +0000
Subject: Re: [PATCH linux-5.2.y-rt only] hrtimer: correct the logic for grab
 expiry lock
To:     zhantao.tang@windriver.com, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org
References: <20200812105053.602-1-zhantao.tang@windriver.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <86790e56-9cec-5cea-8387-f7010b88708b@prevas.dk>
Date:   Wed, 12 Aug 2020 13:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200812105053.602-1-zhantao.tang@windriver.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0061.eurprd05.prod.outlook.com
 (2603:10a6:200:68::29) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM4PR0501CA0061.eurprd05.prod.outlook.com (2603:10a6:200:68::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 11:45:04 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fbf2f82-3b67-4c32-5eaa-08d83eb527a2
X-MS-TrafficTypeDiagnostic: AM0PR10MB1940:
X-Microsoft-Antispam-PRVS: <AM0PR10MB1940A7951A2D11770AF28B5C93420@AM0PR10MB1940.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSeGKw1f4V4tPRcabv8hdUWoikZhG/ZyOT63yYaNc5x/RoBU2O97yRiBTlbEFMA0QBr3lNPfVt/DtYdxXgRk1RyPWwMJd1V3pjka/zd2NYqaR8hAqPzGLzOXmwmgnW7r2Mi4a19o35sH+M7X0QZKdPTo/2ID9Me2aQ6FrpdwRcG7d3H5XJEddwXAqbcr0cTdZu6XGG1IWnSThddfuySlLieFZsHZmoG0VSjjrd75iaq/ZQ+KCWm2M05awRE4FN/0XNi7m5aHSpisEh5+lylwqgqQ/nDTsC0G413s9rMMmBx8Kq0afb0Jr1ZPsxX7Oy854rchDeKV40dNWHn629lTxtemOhfQgeoYb1TGWASm3JhHn9GoqLPDx1AICylmaUv7qmEP/KTmzk2gBiD01jDVFrfLgLrZlxbmzEoB+lHBPHFDC9sUZBmQdMIbMsn+weDGE+Oc2l6K8TbfiLHjWw3BqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39840400004)(136003)(366004)(6486002)(2616005)(44832011)(956004)(478600001)(31686004)(966005)(4326008)(16576012)(26005)(316002)(186003)(16526019)(8676002)(8936002)(8976002)(2906002)(52116002)(4744005)(31696002)(86362001)(36756003)(66476007)(5660300002)(83380400001)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: K1bgaPI5cVQ9PrfIrtGiA4gP9fMRQa+g/virk0EM8rlSRRozOeWzvBzg0zz6/W9mczoOCLbSbY8h2O31Hr0JaAkrw/tLtXvxkTrMXlAeEAdNMY0cxOctmMGunAsNO4A9SnOo10Fsn/dAXiiNa/wWKu07GXd/xN3JfOSec+ZcgFIKRYePvlCWiZFXLxKMBH9CeBqVSmx10f51Lbkh5I1yNbfP/zgGVnURYoTmAJX3Og8fFh39Pro1LM/ecReyB8nOvtPJ/XkKBqAf1SII2IDJpkO+/zQzMML5N864II+Lx0cSGKbhZpXA4V1G5YYaNahfK/diacttUJXM3zzCy0j6EnODKlTvil/PwGXjOpzplKLHCUHm3A8DXBfe0+yDQAqJ7pLfmtjEgcjEjwZW8YQH+o3dHi1PoyFL9N9TH8lgilBZ47SWyXz1bezQyXdJaj7luvDTnrX05P0856pgLjDRa974QZadSJh75XIwpUKDFucS4V9ddaAsdzdWFLTRlkksl4b9flGxnkSTfjC6t4L/YrWDq5BxP3OA2lInowOWAgTioS27BuEVBpnP1seMMq+fcDXIhq7t8B1cD0cFfc56CPvymmROVKrHmrbtfUeYC7pAKpq7raQ2W3c3P6FXxh0y8Zih7B/QM6DU0jRVmxw/aQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbf2f82-3b67-4c32-5eaa-08d83eb527a2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 11:45:04.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zih3rmY3ou6EFYwRSWjb6JlQQ2j/EnfBzRD7S1OLknvCV//7H0JfIFkVHbD1HiWOCQ/8j7EJhMfRCM2Ay8laRe9x6k7c6HvDayQMGJxqwtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1940
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12/08/2020 12.50, zhantao.tang@windriver.com wrote:
> From: Zhantao Tang <zhantao.tang@windriver.com>
> 
> In commit: 47b6de0b7f22 ("hrtimer: Add a missing bracket and hide `migration_base' on !SMP")
> a inline function is_migration_base() is introduced. But
> the logic of the hrtimer_grab_expiry_lock was changed.
> 
> This patch is to correct it.
> 

Yup, same patch sent back in April, which also had a fixes tag for 5.2.

https://lore.kernel.org/lkml/20200428144026.5882-1-rasmus.villemoes@prevas.dk/

It got picked up for 4.19-rt, dunno why it wasn't for 5.2-rt.

Rasmus
