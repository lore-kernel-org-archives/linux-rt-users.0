Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF796C3A5A9
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 16:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F921582
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="5y92yAS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgEDQ1b (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 12:27:31 -0400
Received: from mail-mw2nam12on2135.outbound.protection.outlook.com ([40.107.244.135]:60865
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbgEDQ1b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 12:27:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkIrr5DUHZfTr5xDbtQTKAreBbIfXGwrpfeza4slVRQlwZHTySn7tfXD52lumaefBnroH7wir0NZ1W3V+4ttyzpnXgG0Mv4tFlrVJNUZzldBh2NpOOiV4k+UqOPl9ja1bkq9G7dNIHqRBPlcLeg9hHp6xLzZ6gRjQAptrl9Ld4WEUuXQWlFfxEyw6/uHJxxEXbgNAkM6DQtjfB7bRKeVSbhCuKtVAz1Uqu1KxFU1JWUfCYAblLkXbG77ns8PsavQai8Le9KhwM+ar1vrRbka6NaB63jqVYvo3wUICNHfkaA3VXYVP0j8vGEv73ws7ywIdxD521Pee0fyxTs3mxMX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmZ9aoEL28n1R9FE+c38BZRGDTYb+lPMqeYkF4JKKSk=;
 b=ZrgLNktrYkA4CRqKjuYKBkzooDU2g1Em+aGqTJ4Ef0hfqyX6rRH5BA1fsYJYq4ogFK6oG1HTeYoQ9n5iC+0mvbgij5oqcoQcHe8tURxJjyaxiGtKBsau5jT6Fx3ef6cBzshaiDPVO/c2bO9642FFNmygsqNRXOG+CFV9x+NCRfowWHVMLZlW+xYyKRC7cTWxNlMWElXttxh2cm8ObUmOYp97FwBTtt299I7EnSaLNxpkSDxZPtDCs8IpMYgXqU2PCbMbKGycrab6Uc/BWg+hn4yxJGwZ16UxeP228vUZg8wAcvJK4N8YLENvKckNC/s/lwgyv971DDfQOhgJ1E+DHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmZ9aoEL28n1R9FE+c38BZRGDTYb+lPMqeYkF4JKKSk=;
 b=5y92yAS390e3vIu9g01XOCbXwmDuwySx13znSqDZXJqpxFhDfcUkgQLHNO+Ei8F+l95ysAmOvJlBt/PntEtqCaEKgpAJpyJS6zG+RNbk2RyKG8OjA6BTq1LTdNcuOKrJNl03OYD8jTOIZJgzu0MwdNGgXDSwyDwtBJcrlGPskSM=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CH2PR11MB4341.namprd11.prod.outlook.com (2603:10b6:610:3c::19)
 by CH2PR11MB4311.namprd11.prod.outlook.com (2603:10b6:610:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 16:27:28 +0000
Received: from CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085]) by CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::c988:43f9:15c3:7085%7]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 16:27:28 +0000
Date:   Mon, 4 May 2020 12:27:25 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] signals: Allow tasks to cache one sigqueue struct,
 version 2
Message-ID: <20200504162725.GA35638@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200428154536.GA33300@zipoli.concurrent-rt.com>
 <20200430161848.GA29113@zipoli.concurrent-rt.com>
 <20200504154148.lkowhavipj65c76n@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504154148.lkowhavipj65c76n@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:404:b4::19) To CH2PR11MB4341.namprd11.prod.outlook.com
 (2603:10b6:610:3c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR2001CA0009.namprd20.prod.outlook.com (2603:10b6:404:b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 16:27:27 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872f822c-3bdd-4324-4243-08d7f048096c
X-MS-TrafficTypeDiagnostic: CH2PR11MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR11MB431104269C19D16F7D0F23CDA0A60@CH2PR11MB4311.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHEV0KnhUsJj+APg+zmK3SYObGuke1LcRZgGWhbe19HlbUlcH4FdnAU5KQWmTFnr2mJP5/DobMUNj8oMaDVR+VS5octTeUY/pKDPtr+gcsnzRHvywhONjGLaGBrqBFhMc9VkoBINJMQeFfaP7Fh9ONrKwZCHpi//S0TcUcf2PMKUu/ewfqrEuVi/YBY+KlFE9945sgRaecNbJ1us31sAik8QCtxUngR2V9GPI1iD9krE85AP64A+xRC1E1BGrpsBO7SMTUBKbOs8nUwDJwZ1LXzNaCTUoc5tCkp+xU0iRCzcCY8G9I3k4b07y6VyR+LSz/sA0Kh9RAzc4RNVvIU0gSYTOZI6mRo3POtQEszky4pCX9vTGAMbBvkcBm9TGaFn/xJ2b3CsZYrSWIfNuo/8AG3yYoLeMWm70WM7OyBXkLWjQ13yakJCpmwlYl+SKs9qd5sCMmSknz73dULA/EeioMWrXaMxuHY68Ya4peJOBxTaFuLzmMt4U2qr09ftXab70q+vactB5x12hs84ojXWdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39840400004)(346002)(136003)(376002)(366004)(316002)(66476007)(508600001)(4744005)(55016002)(7696005)(52116002)(66946007)(1076003)(3450700001)(2906002)(33656002)(966005)(6916009)(86362001)(8936002)(66556008)(8676002)(5660300002)(53546011)(186003)(956004)(26005)(44832011)(16526019)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R9YjruHhY8ORa1d3mjPkfaQJUylt2GMDwIt+Z1kQXXmn4wI5QGBcOGu1qn5TFtZEdELOcaWcIxiTPvTpWisM6VOiSoJ7Hz/Y082mHdioCQa+X2OOaoGkrgFz36mrwCtryGDaNb8vRX2JAG4QuDm1tCGJnPT9eRMDxK6lGRsz6jYChiu9/UveuyElBR9rIURJ+sDpDdHhHThX+VvgooxlKpMmd7UPIZV08HOgZixD1CLTZDLGbAGMevYaVNAq6+wMeRuESdQwVoR9Nn44jH0LBWMQM8hc4fKqle+y+MbTXZ/IHzUB+JggW0XYP36n7+USZHPoFPc4Yqd7bzVV2pXAm8Zql6e+UmmO1mfWt5IOBLTp5gVSwGrNXLCluP7Mq7HhW6q4JiDVv76HDWh5wxGEQY6AKngkUW5X9sXbQjk3+RH+demD7qmzdjMhVkcTJLyLJEF9N2jUCKgu2UwK63aYZkism0Cnlp9EOIDQhgV+0C7o+KZL9fcJabN+/8n062sVpiwSug/E6Sui6wGidcQOkLC+/jIajIl8c5sdKFIyBJEhTQwHapjCGg9Kj4reYkoLGiVtgVxUcOfUX9OnPb4jd2AR8NhSKFPMl4fY8ve9YeL/MRI6w7OhjtSVqiRU36kpRbaDriVWrZW8D+vcjdELNt36BdGktyj0qEoaH1o8l0xSpHh0QeuB26iC8wiouGfidonJxjOaJFCmuHlHLfOIj66sepwYlaLPxwxO6KXrslRCY4hUgqUKgUn1OuQEJFDfHMP2MR7BEU35skvgpLon+TG//kZLL6S2wZJndRmeZ5A=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872f822c-3bdd-4324-4243-08d7f048096c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 16:27:28.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFbtXse74ZGX3FyPCF7yOwcwr9/CUq0Fk+MJuAHSbZki/UqNV9bdWLehbfk4Ru3n547klxILVR1929b4xdWMnzhEaycmDwLtOPnyRVGFY9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4311
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, May 04, 2020 at 05:41:48PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-30 12:18:48 [-0400], Joe Korty wrote:
> > [5.4.28-rt19] Cache up to one sigqueue per task.
> > 
> > This replaces an earlier version of this rt patch,
> > 
> >     signals-allow-rt-tasks-to-cache-one-sigqueue-struct.patch
> > 
> > which is able to generate a kernel splat of the form,
> 
> Does this
> 	https://lkml.kernel.org/r/20200407095413.30039-1-matt@codeblueprint.co.uk
> 
> help the problem you see?

Yes it does!
Thanks,
Joe
