Return-Path: <SRS0=CtTq=5P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F08C43331
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989A2073B
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="KcOK2XgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgC3PlS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:41:18 -0400
Received: from mail-mw2nam12on2123.outbound.protection.outlook.com ([40.107.244.123]:21057
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729564AbgC3PlS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Mar 2020 11:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDxwwApqQTGCzpZYNZi0wpyEXKr2e5F4mqFZPeiekIj+ZjhFx3dPyLZqFOuRJCwnPutUitZGwdjQyJNasVP35KmffDoTDKxNPK6b4bAMKVWSc3s9hb/D97SoF+17RrdexgXKYx7wSXIdiJIKW+Y04iO/y2pN21LGGpVoQFbZBgtDlyOENBqcujrTuaoiUIEjr5ay60S9jMavUl4d4muRyIb99PkK3y1SjUB/HiuOIPyvCPfZX0DrpHxjRCqTjk6G7Q4DGtl1BWMVmJ/kESZTCJyvImFpjjkeFSLouqc1nHMFW2/sl7okfZS97h6BV5IMyGLlqh6ws9Q9jZzxgLYmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwSUmV0Gbk1J2UiGlCd1g2FiO2HGqL1krEKsyo3x/zk=;
 b=J+JKbnziY6si4DSUunt1zczNG3/qQnThqEmMv5grIzmHItyoV/mikvTCQmTl1v3tZT+zEzNy5I78boLvbTHXu3grtfC4MoQpwwYGy2mxvANyVN837G5hGL7yhd2ZbmFwXGkkQBuITENnUDC7y98dqnW4XU8IjGo4n35dviP39qsXVxkqkLoPI4oU2ubwpQ6ggT63VOUHtNWDZhpQCgHNyerKvMj9Xb4V7oIin+zNsWSH7OqHElJenW43QwysD0Y2yi2YHDVd9fiavR0IdQO+ZdVAaM9XpaBk9N18d6jO/3pEZDDcb9E/o99VYqdxWkztG/2guaWVk6zwlQptZaGoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwSUmV0Gbk1J2UiGlCd1g2FiO2HGqL1krEKsyo3x/zk=;
 b=KcOK2XgGefNTl1bGJq6Wbzo7SeOAilzbN0kBvWxZrx9LkNjJN8VORmyYp4CqOiI9iGQI14dJwJCEoCd8wg0DoO1m+Tv0w1siKm9cSd3EIEi5LyimjWz8qV3PDtEn3sPOpJG2xx3KFpHfAn8tx6UkHlm4atrRDChRTtIDJV0yW8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from CH2PR11MB4341.namprd11.prod.outlook.com (2603:10b6:610:3c::19)
 by CH2PR11MB4456.namprd11.prod.outlook.com (2603:10b6:610:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 15:41:13 +0000
Received: from CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::bd65:23a4:2f16:a20]) by CH2PR11MB4341.namprd11.prod.outlook.com
 ([fe80::bd65:23a4:2f16:a20%5]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:41:13 +0000
Date:   Mon, 30 Mar 2020 11:41:10 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.4.26-rt17
Message-ID: <20200330154110.GA2975@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200320192830.zeci3rhh5bgbareg@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320192830.zeci3rhh5bgbareg@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR1101CA0004.namprd11.prod.outlook.com
 (2603:10b6:405:4a::14) To CH2PR11MB4341.namprd11.prod.outlook.com
 (2603:10b6:610:3c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR1101CA0004.namprd11.prod.outlook.com (2603:10b6:405:4a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 15:41:12 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b5ea04-db6a-401e-1d6e-08d7d4c0c6de
X-MS-TrafficTypeDiagnostic: CH2PR11MB4456:
X-Microsoft-Antispam-PRVS: <CH2PR11MB4456ADA77D5828E6B36505F5A0CB0@CH2PR11MB4456.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(376002)(346002)(366004)(39830400003)(396003)(316002)(16526019)(66556008)(6916009)(4326008)(54906003)(66476007)(66946007)(508600001)(956004)(33656002)(26005)(81156014)(8936002)(55016002)(44832011)(2906002)(7696005)(186003)(8676002)(1076003)(5660300002)(4744005)(3450700001)(86362001)(81166006)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAwDfbNpX28Ssr0a9nZegFhWm9rPpi9+zEjgwCoc5CAM7uZ6pFMz8wjvdxgSciL9WKrssQQyLtVwmXePLyJ4mHqc1XC51FeO4V/Sp24DOj8U0zhhhwKOM/lo7w12RXDqOFvwHtCpKbJRUgb9J+RZ4WU+o0ZKYTSH7Z2yqBCBQGrRm0idB3zvKamPEBp0UyNqtkvVMFEK5c40V2nZC9aGptJB9EG9EAC9WhrkMjGQ0yII6RAeGe0OrNvWuSEUO0V8Osm2bER2sf5OvoLBACc0BGlW89esrlP90cxCcmSQoyN6D00KiJieFd/xkjhNsTzFqiQX7mROxYhyQU3Agi3ZFQrnschsp5X9LvwR4QFUKDc6ykLW4QEOuwXELCks9IFA0jX/L//71o+VuY7N0ipT7wD+tApG9CvwuPEF2EwXAg503QVYqQBapQ2dn/7QVwJG
X-MS-Exchange-AntiSpam-MessageData: KL0keY/EBpLQEgn2x9FOdvPwaM1KPHgXWG7f7lRhTSAPUDWFkZo0XYjux+RlM5uy7J61p2Jq0OlM8bBO6rBHMccxOWRVTx/x5j1Ck/EBbtwsyueSfc5NOQPHXHryTKkpGpyZTqAr0cmxg9AyiPNjpQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b5ea04-db6a-401e-1d6e-08d7d4c0c6de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:41:13.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ar/Tm2CNhmDZ4av4Gkpennc5vtnkiieZu/ba40sHsaVeah3h6NlZekE9s08x1uWOCzSh/Q5Ht/MnShQLk/fz56YF6HurpdJ+PCYe2RdwI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4456
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Mar 20, 2020 at 08:28:30PM +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.4.26-rt17 patch set. 
> 
> Changes since v5.4.26-rt16:
> 
>   - Revert the "cross CPU pagevec" access with a static key switch. The
>     old behaviour has been almost fully restored: There is no cross CPU
>     access of the local_lock. Instead the workqueue is scheduled on
>     remote CPU like in the !RT case.

[try #2]
This reversion fixes the oops I was getting when CONFIG_PREEMPT_RT=n,
CONFIG_PREEMPT=y, with nohz_full operational, when the system is under
heavy memory pressure (mem=4G on the kernel command line, 8 cpu setup,
make -j11 kernel build).
