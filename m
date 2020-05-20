Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21101C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4FA206B6
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="aW0g6CLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETPkn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 11:40:43 -0400
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:30176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgETPkn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 11:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l69DH85T2t163ZMk2cb+otGs4qJWMO4OVZ+8V1dlCNjh6i7wEdEtjTvn+PwDPZ5cUiI6f6dgyVR0/CILmWM2Dp2esgSBVs8mrc265K6eqyel53zRdfGxEvwIq+mymnyhawZ4Xuic7kdhzol8N1a1WFJd0Jgyepr85HSJm+YKnqzhLPTkA6afveZyJAbw1XGN/FOA3twp18d+1LNc+dWR+XAc4q4pJfjbAoRGR7oNBPY1xN6J8XSBUzbLYWbfKlSFlwP7BsB4/jH3OOngk0XO/o1CS7KIF/Rn0OfbVuwALS5HI/yH4Sy4AEZRHwr/LjwkDXglvdXO6/kz/+jzGsxChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3avKRI3kvisQL+zXhH/uhMNX6WvzRoFnk0qd/R1EkGE=;
 b=OuUn+J4X55vKJrGOBzYrrvfkTSscZyOOeJ3+N5OWfgpvFKFa6LkzNDvP6f2MtQfSzP6mM+bcPdnJwSOp8gIS/Q30xPEp/3J+67njuLMWEjXaYvY/fg+RJ+qP1hi7uDlyLFVO6XfwhVBmM0hOq2d5MnRuR/jl6Siog3NQ6jTky5L7B1mYn2urMx68lMiBeQyXf8DpZ3qLCfrPpjPfrG9r9Hn3fp5eJhY6HzpjrwUjKE4H0puOolYOQkBxLRZmq0WAdu5tWTW5IrXqMSF1UTHMEk44nE8D529/bIvfVbJYH89xXn6UvFQyP0d+eM9N42Zr5elugDvmeB5b131HAIQe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3avKRI3kvisQL+zXhH/uhMNX6WvzRoFnk0qd/R1EkGE=;
 b=aW0g6CLKBYfcRg6k12hOm1IU7CAnVboyp++JmFem7th88lU5lMZckFazvtqijlpQbT28YuJuGI2TpfJ97xboMoEWc/H9LfSXeOlRcYbAPd9iCByjqeQUqU47j83lJmmyOYQlR4RgvQY9UHCqX7rqsajA6lrR5NJXYeWitrChXno=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by BYAPR11MB3527.namprd11.prod.outlook.com (2603:10b6:a03:8b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 15:40:40 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557%5]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:40:40 +0000
Date:   Wed, 20 May 2020 11:40:36 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [5.4-rt] kdb: push 'bt' command output to console immediately.
Message-ID: <20200520154036.GA56768@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200520151613.GA54006@zipoli.concurrent-rt.com>
 <87zha2hb96.fsf@vostro.fn.ogness.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zha2hb96.fsf@vostro.fn.ogness.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR2001CA0026.namprd20.prod.outlook.com
 (2603:10b6:405:16::12) To BYAPR11MB3398.namprd11.prod.outlook.com
 (2603:10b6:a03:19::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR2001CA0026.namprd20.prod.outlook.com (2603:10b6:405:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:40:39 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f99cc3a0-93c2-463d-3be9-08d7fcd4260c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3527:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3527624CD9656132432FAAEBA0B60@BYAPR11MB3527.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChGIDDflBHmDhuDN669mPMjJ5K5LtDFVIwTLCqqxUP+Xd5uZKQ3rIyUhul9V3jaPOxlbqv+xj4NTbxmf5HwFLGF6e68lk2aVTutRXAS8EpR1CCc2t4wxYOCKUXNwqlCF9xF7TRbgyi85GYc+Cbo0JBvjH3ojKY1XWQdIL9tTY53KFtg2Qz1n+09Csv0yFOvBJYtT0Blg8Apvkg4Wx2Np7hRGYgg2e6G/UqICzMO9PX0wqSQSwge547B0QwOsaW2nnApF6rStbSBzR9yNHjB9KotbTHFURJYt3q18D0AfXN8l3aQLJbz2lmhkvh3BH70zgJnXCnbPeNwOgll4/ebsGkx1C1Hr31nQrXBxVR7B7s/N784fzOIzcTcK+efA3anYyl08FGTEWnnY9ZhbO6OANipIGFeF+nC3DtRlSHjGQMJ9S1l+DjMlUt3sr/a0Eo1ZIhIICgrdvcPBkLIX7r4tGQJmPNBQhOB94AasYtxqDd50ATdOnrEe07bvy07jG25sUi1zzyd0CyDHDAnCmnsdMeDgcPK9xm29wwRKffcZ12y2f19uRZG1fJjyTOR01Qz3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39840400004)(346002)(396003)(376002)(86362001)(316002)(6666004)(26005)(956004)(7696005)(66556008)(186003)(44832011)(66946007)(66476007)(52116002)(4326008)(508600001)(33656002)(8676002)(16526019)(55016002)(4744005)(5660300002)(8936002)(966005)(3450700001)(1076003)(2906002)(6916009)(14773001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YXllAOhf6ZRPQJ9BmYHmNuQL8ZedQUpW+UvkmaT/81aKP5k8IMPHdd+SgxdoHPYALn/w/iBNuL+mRsEcDYHht4Sy7hYobHkOUkV1BUmyORckVAPfjuBQkscyA2OnyikhoVs2iHAobXJoZDNu8/0ZJa4a3n8L0vtM6NkcYSWyAAr2XgjjkugXzJH0w38g9yucRxCY/JVXPwphGhOvvbE4WzvDpbDQu0tSIJrKBNYIR6NRRyuzJDoR4D6Pqgr/OfwH722OJdJD/iONyEJVU2pzXuZ9GkHlBboL093P/pIIEEzCewILZCzNJvs9uPnfbFZkwLGRndmZ0scX9eddCPG86RBAddE4rCjhzcziBKHzwIwUrF+I8CVuvVrwRENbdWW5Xr85ocKBSH+kBElhEn7rD2Kx4804qhBgf/Ilq8lmxpCfGzCoWZSNa6yOcXWO13KarPHS6iN37neHWf7bdfRA1QzRbY0/BdaSC18IM0Stkes=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99cc3a0-93c2-463d-3be9-08d7fcd4260c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:40:39.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFeWxT4jrq5KwZr4P0Q6nIcvZ3nfxDtwoib5dzxqPtGZ61TzncVXBWb67QwTkhelRijOx9ni/rHukycPA7rwN7xPd/YUCwDVo8f4L6He2Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3527
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 20, 2020 at 05:33:25PM +0200, John Ogness wrote:
> On 2020-05-20, Joe Korty <joe.korty@concurrent-rt.com> wrote:
> > [5.4-rt] kdb: push 'bt' command output to console immediately.
> >
> > The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
> > 'bt' command now prints a single line then returns to the
> > kdb prompt.  There is no stack trace being shown.
> ...
> >
> > I have attached a small patch that Seems To Work.  It
> > taps earlier into printk than the official tap does.
> 
> On LKML a similar patch was recently posted[0]. It would probably be
> better to follow that (patching vprintk_func and using
> KDB_MSGSRC_PRINTK).
> 
> John Ogness
> 
> [0] https://lkml.kernel.org/r/20200520102233.GC3464@linux-b0ei


Thanks.  It is weird that both this and my bug report were posted
on the same day !

Joe
