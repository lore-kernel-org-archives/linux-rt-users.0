Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D89BC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5319420776
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="MtGckG0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEZQzM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 12:55:12 -0400
Received: from mail-bn7nam10on2116.outbound.protection.outlook.com ([40.107.92.116]:29536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbgEZQzM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 12:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSEPuOfPYabpSfYbbek3qpSAD0J0mpAO2ZUggVMAZJCOGn448qSzoXXQFl0sg60neB5ApqfdV6z8e6PV2bvzOob5F/Oyu0nVLc0udCiyf4VTQhJwI0rEYdHPmf3eOsB2SuxPQRT71GxebHQ9VNTkwfugfGQievtPCyN/LJG+eIGJaGgUDbdzOCoLzIGaOyHXpWClhS0qVfSi1hujdbw1kmSZGRbpsMQTgwwg+I1VQCdiI56W+r0gvpvQzfxdVIMaDvB9wnAGUYdxf6uc8+JyUyahfpwMkL8i2eCOOreZPE2J9QzhMh7C8nuBDDmumKGuKGYt8U7L33pGJALUl8I00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCGJWo5D9ZR44MRaMteYd89CoUKfiDZd8vJN7aIw+Ow=;
 b=Z5m85ZLH9fg/0iXkLu7S3XZd+3I7l1E681nx23OY0FygZOUSt89L3tUd/mt2buO3VOfxRvVKHjapMUrPXUxOr6U8WuQFGggQstMIPmH83k6AqS+unIPwxdGeLWlw+HQsChqLVqppIFLukulMVRWb32cNMnVnfeVpdPZu/oiZ/k3Wd5m4eUf9Z9hvCOQvAVO/kwppSxwoeE9tXMH26gz8rfXfxYxgYV1EikBoJWDYViNFrtBdIJ3WBLdZvsfiJjcoZa6Ne51YXHHV3aFPDKt4zf7VFdbL8Y5wTyRJYeHqoWeNSU+BDKfN1h4tMx0zp1orGcmrOZzs0Z0wZ06ByPyAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCGJWo5D9ZR44MRaMteYd89CoUKfiDZd8vJN7aIw+Ow=;
 b=MtGckG0ygI14qjeZ60EoK1pVaOGcQL/9ypRSF9lNLSUNixgQDKS5sRfyd09jEnZcT/xfKKRowBRB+7Ylr/PTIOfbQrsP47hvgjX7y0hP/wM1UKB2iHcYsZyGMdE2EtIwjmzMT048CFUykQcgDnwDo1Dx1YNmzUgPs5U7uaffFoA=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by BYAPR11MB3112.namprd11.prod.outlook.com (2603:10b6:a03:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 16:55:06 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 16:55:06 +0000
Date:   Tue, 26 May 2020 12:55:02 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [5.4-rt] kdb: push 'bt' command output to console immediately.
Message-ID: <20200526165502.GA36846@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200520151613.GA54006@zipoli.concurrent-rt.com>
 <87zha2hb96.fsf@vostro.fn.ogness.net>
 <20200526164449.vrytnvdch2l4g4da@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526164449.vrytnvdch2l4g4da@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:404:b4::14) To BYAPR11MB3398.namprd11.prod.outlook.com
 (2603:10b6:a03:19::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:404:b4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 16:55:05 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fa84196-0df3-4c3e-41f9-08d801958a7b
X-MS-TrafficTypeDiagnostic: BYAPR11MB3112:
X-Microsoft-Antispam-PRVS: <BYAPR11MB31127D5DF91CFE36E0E41D09A0B00@BYAPR11MB3112.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJ19QIc5E6Bvs+mm/reYGlpOt2wdb7mv6vYKn4fDSrLzwAhBE1r/CfXkQR8EONeljsaZI2166cbp9NOOiGaSpu2mn+17esnrR2k9ld5s2Q8iQjaGGh3/TNOJe9rRYuVuDggFrvCf48GNrvtT6K3jZZXxRcYIOitFqE6pBrSf42I4lhUj1CX43jXs9r85uXxQ1vtrxRkzeQ72iA6TEcuHrmPDW/oC6aCbCszAK2cyMScjgrhUHOuiPmLztap+HjaMYFPMVIMZHxMNkPj9epRXfPDnt4tzxeWJffnIUx0rCDkbN7hW7WjlW2wxfbqTNmcEp+nu3Kb55bNsNjt/xRNZK5CoJOzWwezWgTXb0CdcxvGxZMMAW2Fa9rn56waum0HM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(39840400004)(136003)(396003)(508600001)(66476007)(66556008)(26005)(53546011)(956004)(7696005)(52116002)(86362001)(16526019)(186003)(66946007)(6666004)(2906002)(1076003)(3450700001)(33656002)(55016002)(5660300002)(8676002)(44832011)(316002)(4326008)(6916009)(8936002)(14773001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Myu6yga3HAHLWLgO6jygDhREyEU0AUz5PJd7hibnXEuxMmpP6DY1F16qfpDdhfUziMIGDOysUbNxCD1B7Nzmf+FzxT7p9rR4i59iLOVfeOHIff1IeU7Jh3cBNqYWZk8WKcnPDgUKrOENV3OySvQ3VRIIqm1waJd6en/Uyc/Fgu3BzkZkUQnuTdwDF+ssKScdugN9MpGoekcN88Il+y6HhpY14pWyOGnNEH9aUIIg6vQqed6ymJjqubacD64vqutC3evRqSfLYzGZ3J9wO3DlveVs3Tl6ka2sHpzUYWIvmupNWi3k6ni3UY4SmPWTbsMuKGJ/f/p0k42bpgJKyP3SaN1tH3Gcr0C/H28KSjqLOmuUEOjyuiubrpu10NIPPzlZs6B+8Kk9coF9kbpEwg0x8482qv9SOSP4AAgjsLM3k7i9raI5aZvpXSeU7wgg4a7EWQLOhauopuMyE5oMgDnCVqk9o9Wz1ry9BkPy0qHaAkg=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa84196-0df3-4c3e-41f9-08d801958a7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 16:55:06.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpDFmQOgSN3/yfrNvgklw40PlHfoyv2tDu+rF6id3liBlnIJZ12btYlXoPloqQS6WH02IoEESiqX07WsVWfOkdy2pfKHHSbPckKpkO5zHI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3112
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 26, 2020 at 06:44:49PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-20 17:33:25 [+0200], John Ogness wrote:
> > On 2020-05-20, Joe Korty <joe.korty@concurrent-rt.com> wrote:
> > > [5.4-rt] kdb: push 'bt' command output to console immediately.
> > >
> > > The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
> > > 'bt' command now prints a single line then returns to the
> > > kdb prompt.  There is no stack trace being shown.
> > ...
> > >
> > > I have attached a small patch that Seems To Work.  It
> > > taps earlier into printk than the official tap does.
> > 
> > On LKML a similar patch was recently posted[0]. It would probably be
> > better to follow that (patching vprintk_func and using
> > KDB_MSGSRC_PRINTK).
> 
> Should I do here anything?

Hi John,
Probably not.

Since the bug is in mainline, not rt, ideally rt should
just wait for the fix you so graciously found for me to
enter mainline and propagate down to the various stable
trees.

That should be OK since the bug is more of an annoyance
rather than something critical, so I feel there is no rush
to get an official fix in.

For myself, I have applied the fix to my tree, and I will
delete it when and whenever it shows up in the mainline
branches I care about.

Joe
