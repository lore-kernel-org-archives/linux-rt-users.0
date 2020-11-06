Return-Path: <SRS0=4Q8Q=EM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE3DC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6481620719
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Nov 2020 20:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="aLnAvb3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKFUj2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:39:28 -0500
Received: from mail-dm6nam10on2126.outbound.protection.outlook.com ([40.107.93.126]:39904
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728413AbgKFUj2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Nov 2020 15:39:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxTT55MbFGJXNR1RBWnaHLjn3OfQw7WpEKfshk7YVcLdNtOeR5Payd+0QTIRP1OBOvTl4vG4aYrhWMNqucPTrEbzhQs8vRA8mfGK6MMxTE9VfsyApDGMjLkwgtfuOogm6o4lm6F8ieQFx03QyOOMGPvEVvpYZbZNOPiYcZS425i0n5iKw+HldaWGIv9nX8Vnwu9V57AeKUV3i8teN5Ci69PbTfHD91RDmyd9KFt/4CFQjwWQsK0R4r4iXOoV3Pe0eYZ4Mfp4OAxIeCVQCXEouiQupicO7GjlFxoYD/VfqTrJXeULNoMctrXe2p3z0+DkpxzY+7FA2Q6UILkaDeWmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKQZau4g7P9qGonpdkHHSrxDjUcMb8ub6g2RWgLnxo=;
 b=MjLmc/UVEAeDxU6/gTrjEtIlg6geKMSKIGXgbpgXwC7z4KlSEcy8BNP4A/e5nlsX1mQOHVNnK/066qqZ6Oy71nvP4jz1e0Pcv5iao/SBhz3fH/0u3AfHZUC1v0vv3ffxLnJZHRbhYKhecYT2RF9EOKCIDlDLrBVntndEREEVuN0wEK3QteLxDlFsqG03ftA4oTa+c4/BJx0VtFC7c0e7ZA9yO6O46YZVmvhAnx1QtK9SqRXkAF3vJTjGtM77CqmZv/9kyDCk45gsb3JPS8vUB1CsXAZtvf491EFYPDYKPlje3aUeGRE0Ma2R7MAXhekmE0OBLgtACvYLa5wSKxtmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKQZau4g7P9qGonpdkHHSrxDjUcMb8ub6g2RWgLnxo=;
 b=aLnAvb3hxKexJnXcoFGSm3k98Hz1qnxLZQCersY9S1KiC0Ap6KkWS6u0ToQH2Xqnl7elFt4DA9Hp22sYXhqRmZiOoVDGELNv31prF1ajzNn+kwF7Lf9AEpRnOb99tpZf+cImbBAdS9UZEgb5MaArENSq/Ol75eWIWlhGsSJ6IEM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1720.namprd11.prod.outlook.com (2603:10b6:903:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 20:39:25 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::dd95:2513:7bfc:739c]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::dd95:2513:7bfc:739c%8]) with mapi id 15.20.3477.038; Fri, 6 Nov 2020
 20:39:25 +0000
Date:   Fri, 6 Nov 2020 15:39:21 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: [5.9.1-rt20] affine_move_task does not always release rq lock
Message-ID: <20201106203921.GA48461@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN6PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:404:10::14) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:404:10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 20:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51f7deb-99d9-4de5-b8bf-08d882940c8b
X-MS-TrafficTypeDiagnostic: CY4PR11MB1720:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1720CBA5A3E976B58703CA47A0ED0@CY4PR11MB1720.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l2c4g5Hxgu+rNh8VwsRLoGus3TrTacAQWJdyG6YkEoKhC6llxfe8pm1Voo8QVIHcDTN5JWYTEZh8lwwVq2lhZakyKyErxXSPZKJ+7+yW9l4O/6J26zZXTNeTJtZH33gSkp2Ar23CEk+WHV/VMyhjlB5xiDmRh5XKAw4BA4lUuRjN6wQmE2wH1ZCeQ59PIsFOemtdPFq+2ueVHsY7XoZc8iPUS9jtGqrfEYjHsSjHjp05lDssVPtKQcNRmT3D254h/AEPrieFP+COZddBAgdRGZTVRnuX6WfvuUzLJ/W3OiTgyR3OE45WU9qidLynQlr/gyU3aX1lH++ReC2sp14Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(396003)(366004)(136003)(376002)(86362001)(558084003)(186003)(5660300002)(44832011)(83380400001)(55016002)(26005)(33656002)(52116002)(4326008)(16526019)(8676002)(66946007)(316002)(478600001)(66556008)(1076003)(6916009)(3450700001)(8936002)(956004)(6666004)(2906002)(66476007)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Mu/XC3dLbsxvgejhR7QMSCVpub6rYiRIZSamF9NyBLlPTO6YAWn/IdIelZQVVfnUg+5mXjm5rRYheUbzqRwLfcbvSDM4b0ILJCokPxAk3hII3pOeTZt6DaaHgRSgYZUDuMNZMSTX3d+5MQ7Fh5QvBqMC4QBYP95oDBmQ44S40hO0TwfGb9Lq2fJofUIwY385m1st4E5PbyeWsWAl0CfRBhERN7qW41nOr1R2/q+NUoUMhvP7ReNhMyoxWlSUOjZMadaGGx7We7VOdrFwyMr8TkjHFMVraQUNW8Sm+dC9FgLYaD1tsdx6aOGxervBBjt2WHYf6TnXrpBrlcc1UbwlF6HQJcDuDX/fY2y3XP9nQzSYjo+C38myRh6CfWFFYZZxLg3PFsGNVbJq4/fOPT8lHagL1uHQwNv89nYELRCGSSmyCVHpILg5iXyuZfx2QYdTj+8RyrYbjo0BBLOV5jl7YYgP0Cm7YkCCJKxlg7DEF5l44WYT9ecrYOBEQuyl6Mm7rb/4A56VP/fRY7kpcRJgGBZ5aUJtAEpamwavicWQaBciBxW4NMKK0DSa+TDeYqaF34EQuDpd2VsDydjXvOEmZr9yzrvAnImoZP5qNQ9akpC22upqVYM295YNBsyJhrgj7A6v/SSTzzWK64PCy77Vmg==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51f7deb-99d9-4de5-b8bf-08d882940c8b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 20:39:25.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFAfNm+9fj8WieyXqP7AKEuKRNaO4+hNNaUAawkivBQ9M3iEduxmFNuBabR4z6PohHzzQi7o4VCEE2OY30YuQIovxKYaLnHBQqL92sjGjEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1720
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

FYI. There is one path through affine_move_task() which
does not release the rq lock.  This appears to be in error.

	 * Either way, we really should have a @pending here.
	 */
	if (WARN_ON_ONCE(!pending))
		return -EINVAL;

Regards,
Joe
