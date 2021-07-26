Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF3C43216
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AFA60240
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhGZPaU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:30:20 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:41394 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232621AbhGZP2q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 11:28:46 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16QCxSO0010890;
        Mon, 26 Jul 2021 09:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=ZKSOxXY1oJReaCcorotumNPI3U4FMw+xN1r49EN3xxk=;
 b=ODrTOe++9vjoRWi6dwK880gq3GldO9AXXjjUs0t69VL/Anou44hlmHW8jUbwNDGct6Td
 WIhoHZl17wEC4WVv3TXTPUgEnJbxx70hRCi1CNYlArbKQLi43L5l5rN6eLF9WqD6cR0D
 Ei0qJ82UYKb7O9ba80wYBpCKpiHZpyLTnqF7VuIHB1LN8XAyp2e6hhd5GKTjXwYxfR9O
 fKAsuKkLnRe+SYXxA6kL9otlgdRyBXHeD6X1CuJAhUYxQnOOXrtegHibeXcMvDV5ALEj
 kos8xNX+yPqqprfj+/mDfUoCmuh1VpoRA7BWysqB4QJh9Edg8k0cDv2HbnDNu7szBMiV hQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a1gbu8h2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 09:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffJ/5HGiSBKwrJJ9ziScBRKUkaUO7aoogDFEY4LyY9QtjAToR05xSNu9bwg5f4P3BmdOYIIWfOFL1K4ODU9N91nJ/m7ELajKDegVp5Fd1568TABLufts5k9EIqhvId5LAD+g2j7B7hQQd31gZ+7ZRRtYugLTLifLdSHkfupRLTasA5Aawc6eJwNRn9bi41e4+yk9yFFm5y8Ihii2az2jclBX596btNSQGtmE15f/l6ustsoZmVPsV3C/+OAslvabprFKCW0Wg+KxaV8TNpVPo1FJ5/yXN5lnJq1/HGrD1fmYAmOIqCKcErqakTEoIq34NIS5Mru/AUZvU/h87dQSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKSOxXY1oJReaCcorotumNPI3U4FMw+xN1r49EN3xxk=;
 b=feO3eoXM/BHHcCQKn3ZDn+kzpooqPUht+smT526mpX6eAmoK/p+m5hTbMg+m2yfmAYMgX24g8wTKPOzOs4yBJZUunfewqpXsafeMWY9prLjRAtcP5Wmbv0+qsagToe0aMZ/ddxiAWQBH212eeOiruGNEyCtYGbo0biInKwckQmQ9n6dxN7bKmtPyC8uofssDXf+EJzC4WD1r6tE/G+VVX3teKK8TBmTaXmEpjFqU2X0z4bQ+42/SOo+gfBEzxVB/XMjVjIFkNmD4zoU+H9/4OPAfHClC6wAt+nkLv7fBFJ4M6JC2JfHtrwJABb+qYNepITzsfHCes/e1/Ytpgub0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: ucw.cz; dkim=none (message not signed)
 header.d=none;ucw.cz; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM4PR11MB5535.namprd11.prod.outlook.com (2603:10b6:5:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 16:07:32 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::f5f8:89db:a73c:d1b7]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::f5f8:89db:a73c:d1b7%8]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 16:07:32 +0000
Date:   Mon, 26 Jul 2021 12:07:28 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
Message-ID: <20210726160728.GL63045@windriver.com>
References: <20210709215953.122804544@goodmis.org>
 <20210709220018.003428207@goodmis.org>
 <20210725050349.GA983@bug>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725050349.GA983@bug>
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 16:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a7deb4a-5405-4a10-6348-08d9504f79a0
X-MS-TrafficTypeDiagnostic: DM4PR11MB5535:
X-Microsoft-Antispam-PRVS: <DM4PR11MB55356803969FB43FFAF1840083E89@DM4PR11MB5535.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsXDJ/3T5TsKERkZkUY6OsqrtP2iPV1BYzJbA2CryBm30+YtJUkViH560jxM/iU3mNe4LFJ5WI6IYbKPdTLEonOQ0Qfkozuot+FmzRs8BWDgrlXq5rxFoNKQ3N7O7m/jm9ZdOi17P7WeJuU37NhGTjQbZqHPaHSm5A9zb/KdzC9/fC03/OPkIdfvPqQAgWqioR+8potH9ZRumsLdGUNW7tVnN2c827S6KSS3zIvmoe5r8Zne/S0n7tX9hBaDuH4m6lxDYe+cotNgXOXNcWX488sUALuNYBQIVEoJXrjKtfG/vUxBGxC2EgwZBLCxYhL0Bl8SZlfSlghk6G0f49PzYoFuE/r3q3r48AIhI2KPhJWgh/u5WVQy4EymSZacKlVWHMOqw+AlRUV+41ix7of6xxqdkJNmaQjTBGOcByIN+5SelM2dLTjYVJsxaJIZQ8eVFmEbKQyLVEBjsH/5nXycJXdqvKnwmnS+n6ANpIWKd9cwPLRb2rPNvoMwnqSTPFk+3b5E4+9mXWUh97lozGMdxLKSsxmmJPkiODTEehiyz/DNClnEVQNr/aod6bf856S4ePgDe13+K9q/CIsrLbR7qutXioFRRoLm+mV0XGx3uwDDnQGZTGvGxp0v4wSzvIDteUBq86XtQGNjZgnx7QaWK6wvXxIk3v0bmwEA+sveXsJggF0ddooDrvMCjh1XJXzkUsqTsRe38KBQsxi2TK/9ulilvKwHMAKnt+bp2eFBRkaldji0BANCbJFwSBLGgeoJSQXSdP9LqufQXCoctxEu2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(7696005)(86362001)(38100700002)(6666004)(83380400001)(26005)(38350700002)(33656002)(44832011)(52116002)(186003)(2906002)(8886007)(1076003)(8676002)(4326008)(66946007)(54906003)(36756003)(966005)(6916009)(5660300002)(66476007)(478600001)(2616005)(66556008)(956004)(55016002)(8936002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8l5Ng36BZ4M+Rgzb0epRkO3aSQ1xBiihhGTzJX8bGP1ZMiBLrTkBXjiSgsm?=
 =?us-ascii?Q?MAkRoDp3CJKFfLX1OOuPqyj3V4oCqWuUY/HZUBbbKOu7gUP/Buo//vzGqTa2?=
 =?us-ascii?Q?VMXWvckU0NcTXub0rEFysNbyCCA3xaCgl6AbY1cvFiqNN2xwEdkFLpnaWAcg?=
 =?us-ascii?Q?Z1+ud+H7k4h/o+9QHtU8YCbjJKrOUBlHveiruoz7eNd+4HwPOvp6zhcFuXOe?=
 =?us-ascii?Q?YY9mfyR+3su9GSLDCyzbUeToVof7SHjq2sINOyb7oQeDBONa7w7tbhQTElf/?=
 =?us-ascii?Q?Ur+4AkYuXH4iJ6r2drYNH2QBc9xyhQFdYon/GPFdqCAEDDEcFHaSMT/51frg?=
 =?us-ascii?Q?CAeJM37iHly2ttDmeui5hCRM5xWqByzItmogvMqccDDV6uyDhCEZJWGMFU69?=
 =?us-ascii?Q?tcB5Uo7erk5cTdy7eCT2WOhT+lDC/n82pN0vHMU0h+09eMi+39OYxpHH2zzh?=
 =?us-ascii?Q?0poAKcRS+UiricIbmSX1/brJSVsatS4N+nFZ0N8b5PlOJm1ySWhPVN5gcDUK?=
 =?us-ascii?Q?HnhCDBj5eRBSYtODa44WO9XvD9tmzAfhxPXkGP3jDAnlZWgC6d2XFEAyXSS5?=
 =?us-ascii?Q?U3RORZKbaPclzv/u4T5muWrQs4NHR4JB+sudqmo5PZpDXfb1ROYAJfvnIQ2w?=
 =?us-ascii?Q?037xgN8OE0L+ALWX0BhWg/hB6evClama0+LDRJAoA4GO9/nt4zFE3wMBxx2V?=
 =?us-ascii?Q?7DMH8/0ucMSyxq3ZhzRD/j97Cz0c/iB/1w3zJpqfN3veQxpMuTikmZbIwbew?=
 =?us-ascii?Q?EpgkGuBehssF+EgCxmuqd5Yi/3/HL7yVwi5S+kV2nuja758kJJ/98KuMipJT?=
 =?us-ascii?Q?BH/B5DPeJoUFAWanvdNMsDRYUhf1i05KKy9cEvir361RBlmTm0hS1O9IXhE5?=
 =?us-ascii?Q?r/k2JiwmfWeJTvB3z4KpLXC7v8MEi45ygN84teY0DdG4Ad/X2tNulSs50XBz?=
 =?us-ascii?Q?JeIMJ+EhxLqw9p5b/MWnMufYB5IlLh7iWQhudK80mXuTzSBwIqLEc5ulhsVl?=
 =?us-ascii?Q?MlMapX40jGJQUHYYBmbqZr7FIaF3Ck7sHqqZcSPpirexWfgfIpm8aFa/Ivyk?=
 =?us-ascii?Q?cAA5w61klDCbxrm0x0TOuZuBi2R2uMp5ZwxUM+HDajZq0QxPL9YkTorwwtDf?=
 =?us-ascii?Q?VH460AaNqQppfGgT+TjmpqHZvFxlAmFmgbw9kkuAfzYX96NKxgAD32rv8gJ9?=
 =?us-ascii?Q?dTfKLwlvNxxA+QCB8mLozZbTLnyA443R2h5G1VV6O0dt8eCEzGGHRagWwZYq?=
 =?us-ascii?Q?U0N0PCJWK+iMw17p75OVVyG2VPT0sEvjV6EUxg6HtyN8JGXzLPxtsK7C2ETN?=
 =?us-ascii?Q?NwfKXBlZTKLRwhyOMLF1fs7y?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7deb4a-5405-4a10-6348-08d9504f79a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 16:07:32.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+uxOix96hbIPe5W2eIe+QafOtJFmcyDSjH4MIa6DOGnuvGHFc8XZRXDcGKUqkFjNF1NLOkoSVqlAhHFDFq+DAGEQ5qwVTXOYIkAn82EtP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5535
X-Proofpoint-ORIG-GUID: zjpyMNgJ_uyMxb2WrXbUbw6j8XYzqW_J
X-Proofpoint-GUID: zjpyMNgJ_uyMxb2WrXbUbw6j8XYzqW_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-26_10,2021-07-26_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=874
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260093
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

[Re: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency] On 25/07/2021 (Sun 07:03) Pavel Machek wrote:

> Hi!
> 
> > 5.10.47-rt46-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > Add set_affinity_pending::stop_pending, to indicate if a stopper is in
> > progress.
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9cbe12d8c5bd..20588a59300d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1900,6 +1900,7 @@ struct migration_arg {
> >  
> >  struct set_affinity_pending {
> >  	refcount_t		refs;
> > +	unsigned int		stop_pending;
> >  	struct completion	done;
> >  	struct cpu_stop_work	stop_work;
> >  	struct migration_arg	arg;
> 
> For better readability, this should be bool, AFAICT.

Maybe you missed it in the context you deleted, but this is a mainline
backport to stable-rt, and hence is not the time or place to be
injecting stylistic comments.  Just like gregKH's stable tree, backports
are kept as "faithful" to the original as possible unless the older
surrounding code base forces some kind of alteration out of necessity.

Thanks,
Paul.
--

> 
> >  		 * and have the stopper function handle it all race-free.
> >  		 */
> > +		stop_pending = pending->stop_pending;
> > +		if (!stop_pending)
> > +			pending->stop_pending = true;
> >  
> ...because it is used as bool.
> 
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
