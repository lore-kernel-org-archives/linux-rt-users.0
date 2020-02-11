Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E87C35242
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C5F206ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="JV9ZVNOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgBKSkL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:40:11 -0500
Received: from mail-mw2nam12on2119.outbound.protection.outlook.com ([40.107.244.119]:58177
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728375AbgBKSkL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 13:40:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7OZ5UODjf/d7bJ0Ozgxl6MfWtEQTpjuRlmd/XUR/LOu7uqrW/vH9lJFfe50fsFiCKstLDAhEMsih22N7Gw6qAhrshndQANd2HoDbFvXtAFSOVJtQVCb5uR2U6Uh94sTcw5QoL7MiHqFOmyt/yT2CK+oYQmAs3jWkKz4ZxXHROk5w7yygOgxh9LB6iCmYhYtATOJfkGSU98GHZ70dDyfCUFdxZ8PzJcYdY7C57Jj19/AJj0Ik4H++YnVSwuKu0aI1m715BnwZdRzqUJ3tAGLXgqsXSCibpTbRjN1V6OYC2lLwNI8tCFJ9AY/jqAAY6rCi7UQSRu/x+ZErJZxvscrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EuddkGhz9Z6r+JisddCcR8DrxtbbPlgG8jfP7JE3ro=;
 b=GGoVcLU8Hod3LZj8NQ5gAPaoTY99X993mN3TCP53YoE+Z+xPYutHiJRryDG3cUDC4zDWLo1WU7QMOqY3yf1fhM3DCHLP+mp0kOQ8l+W8XN2Knklb3DlfGceAw9G00y3gsyHutJo3FcF4AUwkzTQDkwmgDFGkxLkI1qSBt6zenoXTJgcDniw42G4g1IZv7NbTN7F/9n+ZU3mi9su4z4SyJSWUdE0zHwZJdVvyhiYyL1sADZn5DuMGezMsqASeDdzh+7NgSyKlx1i7MybfBqD59pw7mq6bzBRklcdbfaqLEwcf7uFfeHi4F2/t8r7qnnE4pM4Z1oq4UPeEoc4zpH4hHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EuddkGhz9Z6r+JisddCcR8DrxtbbPlgG8jfP7JE3ro=;
 b=JV9ZVNODrHw76qQJxDz8dH61KqV3hK0gk6Qv7A5h3JLMNRpJdSK6H9LAR2Vg7Zc9IxWR8HX6JpRL2iTHNwfaei55jfviy5OCF6EvDBBNs0Z10KziPIp2sSk4f4ASUIrXmw1yoNHhC1yShc6/mcJabl02Qb28J98Gh87cvzLEL88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from DM6PR11MB2570.namprd11.prod.outlook.com (20.176.103.17) by
 DM6PR11MB3097.namprd11.prod.outlook.com (20.177.218.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Tue, 11 Feb 2020 18:40:09 +0000
Received: from DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::4b5:8365:6cda:8f8]) by DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::4b5:8365:6cda:8f8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 18:40:09 +0000
Date:   Tue, 11 Feb 2020 13:40:06 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4.14-rt] Fix wrong-variable use in
 irq_set_affinity_notifier
Message-ID: <20200211184006.GA53490@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200211140007.GA6791@zipoli.concurrent-rt.com>
 <20200211174915.mh5bntkysztjmjdd@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174915.mh5bntkysztjmjdd@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN8PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:408:60::49) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:ce::17)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 18:40:08 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90180941-ec3e-436a-99f6-08d7af21d207
X-MS-TrafficTypeDiagnostic: DM6PR11MB3097:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3097360EA0B65EB0C04A81D9A0180@DM6PR11MB3097.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(396003)(39840400004)(346002)(199004)(189003)(3450700001)(16526019)(55016002)(1076003)(6916009)(26005)(508600001)(33656002)(956004)(2906002)(86362001)(4326008)(44832011)(66946007)(66476007)(66556008)(8676002)(81156014)(81166006)(186003)(5660300002)(316002)(52116002)(7696005)(54906003)(53546011)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3097;H:DM6PR11MB2570.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9bMiMur1kj4Ikc+7iSC0eHpkchJBCHjfZXayZeaZG+4bB2eFSNzOWG/Z7ITZzl+T6+YrahWU4bx4gtn+/sfYIDdzekBdzMw3W1iWidfG/dkKhfRT1+dsFUd+Evec8TAB/LliQW0Erz6xqTUz8xJZ/wvFJJEKZSvLattjJf3/2uZtNzB/HMVrzl9M4AE7RsfO5Jy8ZJ3PLMkEsRKY/xlVijCJZa7Fjl5dpWjIQ1gtaEzwhLk/c4rGeXpPIFd5e+awqKQgnSPPh7859HAV4rJu0PZHBuuaopgDMhR5NrSkDCXRlL2k4TYH44Hzr926J/7XV41LFsP9GHz+XFKwNoi29uUFUpqYw4wwGdmdcKT6dAGbW3Y1wOoJLuSh1eiOub1f2NkrKDu0nYiRuanVrls+8y1NwZjC3l+Alvi9xanGLUbxWWv3vzKkRSkdMcYSECs
X-MS-Exchange-AntiSpam-MessageData: Gb+TVgiB3Sjy5zTPXno4bE2csWsKevU/9Re+7z32s6SKKtT86mPA2EbMK5y02DnL773KkaaITU4I7LgrzTSreFPAJ9RBU8VbHaQdTTAr7220KFxzfObkh8MiGiPnIRCoJtwkykaCIgPMR1Nau6d5Sw==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90180941-ec3e-436a-99f6-08d7af21d207
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 18:40:09.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu0fgzJpFGVWMcHYVqpXkvb/KDHbg6gPfYfUn2G2hJ2+OOhAPlwVcTTYFQR5UXEG+zQVM3Rdln2saFduLqc/HHQE6wgVMA7zxPiQdJHW9Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3097
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Feb 11, 2020 at 06:49:15PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-02-11 09:00:07 [-0500], Joe Korty wrote:
> > 4.14-rt: Fix wrong-variable use in irq_set_affinity_notifier.
> > 
> > The bug was introduced in the 4.14-rt patch
> >  
> >    0461-genirq-Handle-missing-work_struct-in-irq_set_affinit.patch
> > 
> > The symptom is a NULL pointer panic in the i40e driver on
> > system shutdown.
> ???
> > 4.19-rt and above do not have this problem due to a refactoring.
> 
> That would be Tom's to pick. Is v4.14-RT the only one affected? I was
> under the impression that we fixed it already in each stable rt tree.

A quick grep of all the -rt patch files in kernel.org/../projects/rt, newer
than May, 2019, shows that 4.14 is the only one needing a fix.

    patch-4.14.170-rt74.patch.xz:
    +		kthread_cancel_work_sync(&notify->work);
    patch-4.4.208-rt191.patch.xz:
    patch-3.18.18-rt15.patch.xz:
    patch-5.0.21-rt16.patch.xz:
    patch-5.2.21-rt14.patch.xz:
    patch-5.4.17-rt9.patch.xz:
    patch-4.9.201-rt134.patch.xz:

> 
> > Signed-off-by: Joe Korty <Joe.Korty@concurrent-rt.com>
> > 
> > Index: b/kernel/irq/manage.c
> > ===================================================================
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -353,7 +353,7 @@ irq_set_affinity_notifier(unsigned int i
> >  
> >  	if (old_notify) {
> >  #ifdef CONFIG_PREEMPT_RT_BASE
> > -		kthread_cancel_work_sync(&notify->work);
> > +		kthread_cancel_work_sync(&old_notify->work);
> >  #else
> >  		cancel_work_sync(&old_notify->work);
> >  #endif
> 
> Sebastian

-- 

Regards,
Joe

_________________________________________________
Joe Korty
Concurrent Real-Time, Inc.
2881 Gateway Drive
Pompano Beach, Florida USA 33069
Phone: +1 954.973.5262
Email: joe.korty@concurrent-rt.com
_________________________________________________
