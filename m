Return-Path: <SRS0=yFsm=AH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85196C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528B42080C
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="04WIqjKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgFZNGC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:06:02 -0400
Received: from mail-co1nam11on2094.outbound.protection.outlook.com ([40.107.220.94]:46560
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728274AbgFZNFx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTyew+7cLGf7/4kTloalOykv0tu0TfAm6Y8McumCyZIR3CH3KnBhq4VVoumniMjNK5thJK3UCPwPUmJGaEJnkXp95jzS9tTC5dwDD+G2EyPn3kZXpxf3Ifg4z6K3iU8pMjNJsAHUT1ES1qZF4gNRBcU14Yi9FoLg7f2jrAmHgQLAlC+1McwKR7y0ubAJjU+Y4JzOnasKlY2v7zohxkfSSimBuRhZpTNBPHU4HaCJlT46I+VOuRsAa8lUxgAgRzCsVwOKcmEmzgfAWXZ8IZUE0mn4mf+YMzePvF+SQkR13plE4nnNjgG2ekiF3g8ke0FtO0LinVjcZDS8UWfhRwBW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imhWnry19+VnigQX0RpaiN2o7EbE8iQcJwja8Pj1IE4=;
 b=nUQQ2OWWYWmyOFlGvUdyLpRAGldOVZiYed+hOUSt4vcepOiBsEjyuhAIxJ20pCzHE+z1Zb8UsrqyejiUMYfOovSIOnV22z/EOUOwuRAET//3P3BvTUQDK8rBzP/JuCdSB0htVoG/d2ONT+UmU/p/dHwCR1SdK0BgkqxlS43tLrzJOgEwu+xATsQ95Uva5YtwXswY/Y7UlxHFKvB29Z0qxz630Beekepti+5NTFPnPINU06SlaFkCueJqXqp45P0aSi2hnP5diYRXu+mQjC2vjomuhOCmL+cf5VgkNffVJk4H2WIqRLpVgEqCa87eLxTiKxeuiODuEFsgKIIAVhpjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imhWnry19+VnigQX0RpaiN2o7EbE8iQcJwja8Pj1IE4=;
 b=04WIqjKepyixEzlpsfA9HO0U7iBw1P5tnZpUcxGat7HxdxxLqzUNtrWHusmkul7nilfbC6T+VRRqVunzLUdkHl7D5SDSl7u9Gmm7nY8ywrsp2EnRH2dqsr+PMdP+cHwBpWGy8Jthpy/bo2T5V8whvh8LHiue+DYc73s6BcW31tw=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19)
 by BYAPR11MB3061.namprd11.prod.outlook.com (2603:10b6:a03:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 13:05:49 +0000
Received: from BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557]) by BYAPR11MB3398.namprd11.prod.outlook.com
 ([fe80::283d:cf10:8dc9:a557%5]) with mapi id 15.20.3131.023; Fri, 26 Jun 2020
 13:05:49 +0000
Date:   Fri, 26 Jun 2020 09:05:44 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [5.4-rt] kdb: push 'bt' command output to console immediately.
Message-ID: <20200626130544.GA37967@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <20200520151613.GA54006@zipoli.concurrent-rt.com>
 <87zha2hb96.fsf@vostro.fn.ogness.net>
 <20200526164449.vrytnvdch2l4g4da@linutronix.de>
 <20200526165502.GA36846@zipoli.concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526165502.GA36846@zipoli.concurrent-rt.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:404:8c::32) To BYAPR11MB3398.namprd11.prod.outlook.com
 (2603:10b6:a03:19::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR07CA0022.namprd07.prod.outlook.com (2603:10b6:404:8c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 13:05:48 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9549590-d860-4c3d-36b9-08d819d1a5b4
X-MS-TrafficTypeDiagnostic: BYAPR11MB3061:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3061E56B8AAA3AD5B08394DFA0930@BYAPR11MB3061.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iBwDhbWJcKPneQFE9DRp3VFPCqWyOQUz3ww7ecRm/sAbSuuNUygKPq9hVld7UG5WrASXs/lQbk66qY4JY3gPHO7rEDSfwrwGwoPcQtLCgXBnt7c6eUmyxqr5pEOgpJRwFH1I0evbS/On1cpRiyX8mBp6VACgAEUIxlJz2PTlVVPNG4SyDyFmIuaqqEOwaHdfXKy8vQbyls4ZNKMhUPTWDXUTB6vtZbqkWCBAIwSZz/xKhve7wS+8Ijl6upOvXA0akWcTz28erzRIwDKDXjZJKaqY6OAfV9+KCq9AMnilLTOGRD7b05lsQ/3iVm4e/O+iIqmprAEzr62Y03jxpxQVwVbrSIQjbDLbmjEDufdaeozZfycUcFRQRL1ww/dB+/8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3398.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(39840400004)(136003)(396003)(6666004)(5660300002)(316002)(956004)(508600001)(16526019)(55016002)(26005)(186003)(4326008)(53546011)(52116002)(7696005)(86362001)(8936002)(8676002)(1076003)(66556008)(66476007)(66946007)(2906002)(83380400001)(3450700001)(44832011)(33656002)(6916009)(14773001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lN9F7NAzEXBvlYwQ9Jy8Raq6/86OUJq63fTkJfvInm+qX7yCqfLH31U0C71A1yNAUybjoJ4qRL/GnpZs3MYzYKxXSjRFWqXafnlMjOqiqyUvA9xyI8TSu6Ll0Q1rMZVjckWCiEnRlfnFPab4eJ0jXSJXRl4NkwjrWdW3hfhmCQQ+q7h7m75+7YLArgGrMm5344LmxLXBC6y88ILIVh6b4tZHgMR8evNfGnAHKhJcRA7g0NPalYM977abixEDKUsAX18YGZiGSOTHrDyPjYwR+tFXb+OTxuOjLV9DhrgwDbgLVR0a0Bywh+bL/PIjLPMj5xHZW/wbyUtLsxaclt4zP+EBk7qL9AxTMzVx3S6eXQEXffPwxDVcnWlSLWxal7vMPW+iUM4qHt/K1xsz0Rjemivi4vY+151UlL9XnGQY8/3UaQXhUYF7XUfTlj26Id1GeSfPyWRu3ADU5tEGvhxvo24ZUF03n1r+b7eoYx4ZLWo=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9549590-d860-4c3d-36b9-08d819d1a5b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 13:05:49.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLu8fqT2WDMbjWEEMKyY5dXUFSoRM9jTlvdEgMilutp6jxupqAgKNNg/O/vkbcAfltXnqPXht7girfHrp60lCSW0j8vc7U3tl2lRsFKl8L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3061
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 26, 2020 at 12:55:02PM -0400, Joe Korty wrote:
> On Tue, May 26, 2020 at 06:44:49PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-05-20 17:33:25 [+0200], John Ogness wrote:
> > > On 2020-05-20, Joe Korty <joe.korty@concurrent-rt.com> wrote:
> > > > [5.4-rt] kdb: push 'bt' command output to console immediately.
> > > >
> > > > The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
> > > > 'bt' command now prints a single line then returns to the
> > > > kdb prompt.  There is no stack trace being shown.
> > > ...
> > > >
> > > > I have attached a small patch that Seems To Work.  It
> > > > taps earlier into printk than the official tap does.
> > > 
> > > On LKML a similar patch was recently posted[0]. It would probably be
> > > better to follow that (patching vprintk_func and using
> > > KDB_MSGSRC_PRINTK).
> > 
> > Should I do here anything?
> 
> Hi John,
> Probably not.
> 
> Since the bug is in mainline, not rt, ideally rt should
> just wait for the fix you so graciously found for me to
> enter mainline and propagate down to the various stable
> trees.
...



Hi Sebastian,
Oops, my mistake .. the bug is in rt, not mainline.  The
status of the long-term rt's w.r.t. this patch is:

       5.6-rt    -- already has fix
       5.4-rt    -- needs fix
       4.19-rt   -- needs fix
       4.14-rt   -- needs fix
       4.9-rt    -- needs fix
       4.4-rt    -- needs fix

For your convenience, I've attached the needed patch.

Regards,
Joe

> From: Matt Fleming <matt@codeblueprint.co.uk>
> To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-rt@vger.kernel.org, linux-kernel@vger.kernel.org,
>	Daniel Wagner <wagi@monom.org>,
>	Matt Fleming <matt@codeblueprint.co.uk>
>Subject: [PATCH RT] signal: Prevent double-free of user struct
>Date: Tue,  7 Apr 2020 10:54:13 +0100

The way user struct reference counting works changed significantly with,

  fda31c50292a ("signal: avoid double atomic counter increments for user accounting")

Now user structs are only freed once the last pending signal is
dequeued. Make sigqueue_free_current() follow this new convention to
avoid freeing the user struct multiple times and triggering this
warning:

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 0 PID: 6794 at lib/refcount.c:288 refcount_dec_not_one+0x45/0x50
 Call Trace:
  refcount_dec_and_lock_irqsave+0x16/0x60
  free_uid+0x31/0xa0
  ? schedule_hrtimeout_range_clock+0x104/0x110
  __dequeue_signal+0x17c/0x190
  dequeue_signal+0x5a/0x1b0
  do_sigtimedwait+0x208/0x250
  __x64_sys_rt_sigtimedwait+0x6f/0xd0
  do_syscall_64+0x72/0x200
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Reported-by: Daniel Wagner <wagi@monom.org>

Index: b/kernel/signal.c
===================================================================
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -494,8 +494,8 @@ static void sigqueue_free_current(struct
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
