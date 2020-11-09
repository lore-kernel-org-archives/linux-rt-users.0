Return-Path: <SRS0=BKJB=EP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371CAC63699
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18DF206CB
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Nov 2020 13:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="qIxfB5B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgKINjB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:39:01 -0500
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:24513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730582AbgKINBu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Nov 2020 08:01:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdiezMVndGrlGvP2eE5tb3P0h8Mkcene0zBgBMGyXwG+ezZPAH6DeN2UVlFAvvgzHttAUGShJT8xM2NPALHb8kaOHfp3xykg/l+HRrVLJocaf7qKkDjsMVz+JduY9kV2Dj6Wh2b/FAx8AbZ+BPccQ4ZFbGnEXLFWroUKfOEG4s/VktZIr56wBu4FFELGqwGPO502EmblxxrXKfWgGO4j3X8TOkqAtLoFVfDftBpwlJWZ+2a31QKWrwkeFuSpFQvB4ivihvfEIiQylrVORi++uB7JRXO3gpmuFB3+4pVRs6fl7FrmyL808ZLQz7cN6LxOr2PDInYS9EXNCloOE7tKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNd7xcGZPy9YfDLLGoCbTFpcJIo1Ah7bgZmzcEjEy8E=;
 b=ci9gWSh9SM/seksodvsw7ZwQwcNKwvWW/v3MjO6TDQXb0pjW5FNsETL21pIIsh27NM1muQazvrOA969B2aFB9Z4vwnrAvxJjh2s4zCrZO5NMDji2Lw4zuJknHiU/c4M+X0VSHqYnAmBtku4eEzcp1XEFwde+4QNlRWSIvyCowq4GGyKcE6RWbqdKGHuhbuFJXhdsGXtK9TtV6kaMpW266UmGAo/7fkmRuDyL8WAvxakQ+Begcoi/y1CaCDg0h+a/UiMZRhdjZPiEqweMW8Nu7R+Fx//n5SZIoX6cw+f5FqsLMlC/fFwAv3AlUANXT2dp0d0r4/Ubj8c29H2GPB8qbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNd7xcGZPy9YfDLLGoCbTFpcJIo1Ah7bgZmzcEjEy8E=;
 b=qIxfB5B48uCwbbZFgIe+FLVTaUmrP+lSclVbDuoAMbQs2uj8x7qE2CVyFeoZe9DS4MV9ovn8LLiyHSympypHVu/IhoEFSbj7d6oc/6AsQd1fgLLp2SQD9BdeUDuytdNRLxO8/wUm8MfyCeJvPwfeJfkqXgfq+/Y9FElE9S/UFVk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR11MB1830.namprd11.prod.outlook.com (2603:10b6:903:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Mon, 9 Nov
 2020 13:01:45 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::dd95:2513:7bfc:739c]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::dd95:2513:7bfc:739c%8]) with mapi id 15.20.3477.038; Mon, 9 Nov 2020
 13:01:45 +0000
Date:   Mon, 9 Nov 2020 08:01:41 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [5.9.1-rt20] affine_move_task does not always release rq lock
Message-ID: <20201109130141.GA7684@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20201106203921.GA48461@zipoli.concurrent-rt.com>
 <20201109085930.GB2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109085930.GB2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN8PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:408:60::46) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR12CA0033.namprd12.prod.outlook.com (2603:10b6:408:60::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 13:01:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6535c9f-aa52-4e62-6c1c-08d884af9bfd
X-MS-TrafficTypeDiagnostic: CY4PR11MB1830:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1830161CAE3B740F49110E72A0EA0@CY4PR11MB1830.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FEcyVGU6wezD/Rd9GcJsu7mvGf8V/UhRjxdlTSBgXAh0DsOx2Uey9WsBfYuYcsxLqzexj/5hhcLiuotxvDpEOa862a6BcTD3pH+LTG0lkdO5111zJv/mDwq0pQ34yVdtKvdsS5pwV/P4WMaaiNpME8Kxa2bUgucSAY2naluRFHGvJgX/IAAsm6OtwuUhvty1sf/A9ovdA3WkXjos5odS7zfy0w3Jzqk+cT62mjcrsqek5TY7py2SkJP+BsN/s8rQLWpaIXSlAAiuhbLOQHV3WTlPeIzqprdKgqmFfSyPP7R6p23EJHvZs4wBYisAdH3NuH1NWmm7ir4kKvD3gruZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39830400003)(396003)(33656002)(4744005)(66476007)(316002)(16526019)(26005)(8676002)(7696005)(478600001)(1076003)(83380400001)(86362001)(186003)(5660300002)(3450700001)(4326008)(55016002)(2906002)(52116002)(66556008)(6916009)(44832011)(66946007)(956004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tt93DWBDisFGfWVfcJMNNdzBJj9SY/Tz55I8rRsZkSeezlxLhVxpwPB8rKoMmf0ssSj3pIpZIQsWHNGYk9MiUYHUGqEmGU6uF5CfPuLFFempOD05IwhzjRcz/l5OcGE6h6iMMuelZttCPsRsOiEONY8yzi25RWuWdkg/ywgtRoYgIO72Hzm0jarFiw6EwHUrucEX6LEjG58x3x1A3OLHhxyOuXqClRBzDR2M+ILE6kCSeVniDKHGmrF92PX4PeKSFMn9tNvHuCMSWwNnhe4Qo+XIIp0UA9h2cC6pGAu3HiyQB9lsF/Ebyte/IlCYWZIhTPali5hyqytg3OsDY5yNeFMAm0h8z/OhzemBfrovoWYw35I0yRlqNfMMtIRhx8dlzYoocMxZhZ7sgBy+WDdy2ypmZA0Zyj9ggx98LEH35p01hsgVt1gBfwA7PyECRFqFuD2nsFjc0VZePyrEYRWHzCLJnm5jZDTW/VHTZpgojcYjCzCyYjaWpiUCB7WCtR3/tkk9Nrvp0W5g1X/x35cAD0NYjasIm7wwtsXI6kGOP0NACJFs+Ed+bJHVyrcxeBsVLAoQQ0D9ZC80ynrROYs/SFhbuVcZI1ZoLDdYlVZEZpr31eODWgF1U9b8rB5g5boYpD0LcZkMA+G08kIUp2tHQg==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6535c9f-aa52-4e62-6c1c-08d884af9bfd
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 13:01:45.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMjYXF6S1kso4SXHjg+eLOc6NxicXCJFIn3XMWGMKxt73UFtxAkA+VdCc42kLCpH8AoIAzn9GOmpOTsqk1cH9FZ2nEHWRWki/lXkB31Lolk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1830
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 09, 2020 at 09:59:30AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 06, 2020 at 03:39:21PM -0500, Joe Korty wrote:
> > FYI. There is one path through affine_move_task() which
> > does not release the rq lock.  This appears to be in error.
> > 
> > 	 * Either way, we really should have a @pending here.
> > 	 */
> > 	if (WARN_ON_ONCE(!pending))
> > 		return -EINVAL;
> 
> Indeed so. I'm assuming you didn't actually hit the warning but found
> this through inspection?

That is correct...

> Anyway, let me go ammend this. Thanks!

Yer welcome!
Joe
