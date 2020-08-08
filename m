Return-Path: <SRS0=CLfq=BS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292ACC433E0
	for <linux-rt-users@archiver.kernel.org>; Sat,  8 Aug 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E269F2072D
	for <linux-rt-users@archiver.kernel.org>; Sat,  8 Aug 2020 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="Q59X7rDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHHOGs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 8 Aug 2020 10:06:48 -0400
Received: from mail-mw2nam10on2105.outbound.protection.outlook.com ([40.107.94.105]:63073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgHHOGq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 8 Aug 2020 10:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5Sd6Kv7o9wx07ZLbEdY5Ze/UogSVeyF88bw1/pczv0o9xtF7qHG2I0/GXZL0KDBegZzFp9IZKNVhZaogB4sIpxIODkC1WtpDRoO3u84WFHPz2IVn5+znBBsTpIG9iERVWWN4nGnm3YYgDzmkZM1UMnRkcp5hCyE+hej1X02xgzOXUrkdMR83InWZ69xNGWQuMUqdFqgHwl1eKDDmt0XUe34LAFmSLlskjeZ+925VF1ZDdEjKzzn9j5FoY4CMvIk4LgyN6UpcuQkGmSwmhGMnk0HMb6XVSJcQh1pGBUmUoV5C4aMlT2iOpsrsR1UiikjptbUl6GE5y2PojDnUgarIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDvljy59qlzIftlpjmx3bz7tnWb15RCV30PjN3DstoA=;
 b=GRYWe53y6/1uM3TjqftgLkC5Fsz/TvhEfNtqEPopOHjr0QVykqncQmH+J4cA+bQZk06IJQRWNEcwA2Ewgp0AQ6qK3ij3dL0aBtS7678yoYPA8g5f+Tv8Parf+MDT9WsWa066P/vmdeBDXx+vmD2OUvjNEEXJbz4iWdZShjATMoUAYkjjYuUT0O0tPEW4QTnOaQ3Z3z6UlelkNMC0laypVkSro+8z3f7Mvxh5M0muQ8+cVVDFEhrsdPB6CIsJ9KJI4SscMK0gSl/1ghfdXzkU9m4jEtHwvD79qze6iEz/6I9EtP38yLKxW8hAiFW30Bn1IQom5OwU/rt/OxETl5JIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDvljy59qlzIftlpjmx3bz7tnWb15RCV30PjN3DstoA=;
 b=Q59X7rDvhI1vCs/J0pkHtAz+zWKb4+4Pg19GIzIARCVap+cJut3j5qcGbc4mgiMIEQVAvRrZVZ10md0xmStdnUcH/6G7XOHCj3P/AtjAHJib1zCDX4QT/ElQmVi+TwBcee/gusKf/CgblbcLUzFCCX1rBlBekL/vdEoyqvGNtzo=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Sat, 8 Aug
 2020 14:06:42 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::8da6:288a:aad0:d9bd]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::8da6:288a:aad0:d9bd%4]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 14:06:42 +0000
Date:   Sat, 8 Aug 2020 10:06:38 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] v4.4.231-rt202
Message-ID: <20200808140638.GA26582@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <159559806551.29587.13643956941367278015@beryllium>
 <3732c1c4-36d4-2cdc-677a-cb58a9507df1@suse.de>
 <20200727151033.7c37df2b@oasis.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727151033.7c37df2b@oasis.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:408:60::44) To BYAPR11MB3398.namprd11.prod.outlook.com
 (2603:10b6:a03:19::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR12CA0031.namprd12.prod.outlook.com (2603:10b6:408:60::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Sat, 8 Aug 2020 14:06:40 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3abb9f9-e80d-4a6e-6f28-08d83ba446d2
X-MS-TrafficTypeDiagnostic: BY5PR11MB4242:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4242DBB130B68EB1BCFBD614A0460@BY5PR11MB4242.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkYuyvcRZqjZK+kDFNDz/Ln1UQkYiQaZl7OKTCDKVV7HOXAsgRggqJwf42LZGZ2pCr1INoJpbEtX4dOBz9UzuPIXINyuNPpnQ4lDzNbfPwtEm/VnrgHO4AinCyG1wVQcibwGXMjJST+n0zx+fpJ8Ms+83GlESVmHxCSWXoSN2n8xHIC8BqpF6qCzjBTBMfD0PQ0dZj4wFCmBRIUdRyP1CW7jvxk4fDmRXMHjcb0myO/F4GTip6TB5EMaYeBc0GC4mD9NZPv8xqzenZ1HB/QQQ2oI7a0HM6g1kiMKF+7fUemICDGi0M3IH3A5hZFentItrGOq6aSmpw5MwPDqhjlBij6YbqhRQAecXawjrclF66jyiIyzC73EWruLGKRiLZgYZRYcHbfKNFtPJhUFGzsfDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39830400003)(366004)(396003)(4744005)(7416002)(4326008)(8936002)(8676002)(5660300002)(3450700001)(7696005)(66946007)(316002)(6916009)(26005)(55016002)(16526019)(54906003)(2906002)(508600001)(52116002)(53546011)(66476007)(33656002)(1076003)(66556008)(186003)(86362001)(966005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KYjYSfcVn8OL/aSg+R0bU+tltsJcly206ttYyyX/Uc9DYFGmabF/sRipkTgX8fTgX0fe0lUCv3qPKSXgo60k7VhCSrk4KvG6ixOlzIvG9galgB3T+dkupb4THqWGWVV2TJYHFtlJLiXKC/UwmgLowHc7L14mrnDpNRhmpg6LrGLZv6L+9LRCKN9z7eSFrWmpubxmTSR8YDKa0uw1f1G1Ln3XzihJwQ1NHg8EkT+P3KavqUsRgPR5P/mN29sXcJvNVsAWsIN5X0ZeCnZXq0aj9GZVjZwBYjZU7b2JVmVKTFUX+BAzFxq956CG1nrNDNazeBXaTOB5Wb+wBqI9AYDASswPGOferJKJTkNBzHG7RS3uOxgCRKIHnmTK7LBov4iWWzjkejziZ0LOimu/C9B08gQI+PLkmev059BaMR6IkzAeNi49qgxx13bhwfzdzaAJoLf0Qzvej/j3pvb92xxcQuBZddNIA0zjnD3FKXmHVF8MIktYI6k4xooFQkx1czgXUl98Ep1JN/3NdAqf+uw820j4BxHvOJPlr2CnTtGCUi1c/SL8sxzJpXmBZpB8VyPKxX/OZ2PM4g7iEI+D7J+1SP/EjJj5FHukvFok3qUs/cjuZAZFxj6ArER4xR6bN/wbWqZhVeL3VRhETWv7mvTXtg==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3abb9f9-e80d-4a6e-6f28-08d83ba446d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3398.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 14:06:42.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc6xnVn1pkDVe+BQ1fK057VwbFUjxKEFi3QIgA4+zIqzfGbzyJn70OkpBLmxiSssGCp33hHzBK0SDdC19Q+bP2+2pHyaE7D2K5BOIAHYv/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ping?

On Mon, Jul 27, 2020 at 03:10:33PM -0400, Steven Rostedt wrote:
> On Sun, 26 Jul 2020 13:55:12 +0200
> Daniel Wagner <dwagner@suse.de> wrote:
> 
> > Hi,
> > 
> > On 24.07.20 15:41, Daniel Wagner wrote:
> > > Known issues:
> > > 
> > >     sigwaittest with hackbench as workload is able to trigger a crash on x86_64,
> > >     the same as reported for the v4.4.220-rt196 release. As it turns
> > >     out it was not triggered by BPF.
> > >     https://paste.opensuse.org/view/raw/58939248  
> > 
> > Joe pointed out [1] that v4.4-rt is missing 9567db2ebe56 ("signal: 
> > Prevent double-free of user struct") from devel-rt. With this
> > patch all my tests pass.
> > 
> > @stable-rt team: Can you please add it to the missing trees?
> 
> Good catch,
> 
> I'll pull this in on Friday.
> 
> -- Steve
> 
> > 
> > Thanks,
> > Daniel
> > 
> > [1] 
> > https://lore.kernel.org/linux-rt-users/20200626130544.GA37967@zipoli.concurrent-rt.com/
