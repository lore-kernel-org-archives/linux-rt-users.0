Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC0C433E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4161D2312E
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jan 2021 09:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhAGJOX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:14:23 -0500
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:12656
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbhAGJOW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jan 2021 04:14:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8GwhculPBc9hj87YZ3YGGVGalV+cVwtU9JLnl4rqo/QKQuzyCDxnetL1BaEjXvNYFggwcddV23C1A1yS29n4uM68FPq2urMzBBsMwCDJZT/idztBelYpVJ1CttnKQR07mSKXNfjdKwRiv6DWeWUpbP1AZfLWVGgttj3ZH/OdNrJNDnaUOn91q4eqa1MOJvuXBAbNzdkmCaDnAnEc6ax26SXwiPIeSlPSin6SpnVqNjQvQLtRkSnD7nNntkgzcyHaSj1y0ObmsZBQSJ4yA/6mRlIwfJd4NnTaexG8Qyfodox00RMJ0iXJ6LpXxn3r+s/0ofYKYR0MEwft2CMR8dDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE55eZiEfVj6rDptRcACOzWpAe41Eq/OdkX8f9IEa38=;
 b=i7ONOwN7zLeMwvP9AawXelHTfravD4cbt5ejaRDElMWlTYG3tbk7YR99WTz5Udm0ROnOXS9q9Yuy3aVJgLAoMPfowiu6dnO+fCaybRNCH7VKeMMNP46P/bbwVBm/rYSZ0g784/q8EhH532HvUXpHBie+O8KZ9/pmLy+r3ysIx4rgeLaOdzrhaby1wre4WLAzD/66XfeaeUvINwbWzmhyKEV9EYQoWWzP3F0KO3WXu2TiYjUUWo3r76xWJ4+H1WxyQSkZ2+oemnRYr2ii9xaI74xgO8Q5UBuK6tVO3+owuXNXkyTkgx5TG0uaUlGemAYEsGXxsYCwmdhv//lXtsEy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE55eZiEfVj6rDptRcACOzWpAe41Eq/OdkX8f9IEa38=;
 b=Invde6y7mI5mqKehxbehGRC4xjDjqk8ckzWBWJtm6eIAHvWvs/jFQZIyQuztvS0hGDideCh/3P55RGWkRQPzCYllDGbu7/4sJjEjuRfK0xBKfWqxTQh/h0SYX4N0LXq1hCMMUDb5ctSKmE0LQwzer7ehT7vz2hFyms3gsrlhJiY=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Thu, 7 Jan
 2021 09:13:33 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::f067:a4a9:70e0:e910%4]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 09:13:33 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Ran Wang <ran.wang_1@nxp.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Thread-Topic: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Thread-Index: AQHW5NTeAJUSfO8HlkyY76riLvO0Vaob4B3w
Date:   Thu, 7 Jan 2021 09:13:32 +0000
Message-ID: <AM6PR04MB54138E0D36C60ECA1E44242BF1AF0@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
In-Reply-To: <20210107091841.19798-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0684029-173f-4b6a-c099-08d8b2ec81b3
x-ms-traffictypediagnostic: AS8PR04MB7671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB767177CA10359EC325CC096CF1AF0@AS8PR04MB7671.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roGLWtHLyk+SOxaRNPqgrymhXiD84uM2mCO9cfbu3tgghxHzSp045bpdO06CPUq3WL4RSjLFGhyfB6KPGiK5yNOam5qrcNCsDfhJWJHsRHorqVihnvvvpEgOlHziXmWcTdNeoKNDjwAEzcqo51s6V4mX5b5xTu3EtukVxLO5hLq8SMOOg3ESf6J0nKgGmRQTIZnC9E5QudK686EqqlcGXh04HYMm5tSVXUXZ3bVLvSbIacNlX5lRHfb+I0wUUz+daoBuqOI7fJWsJtVJa575PXert7eHSUYx11owNBgvoHY2PD+SuDg/CbqomUGEwjTITLu3DJkRh2rFpfh8iSLUvfTBSo+Gwl6LfB4f3xHFc6LPi+UxbyfKDgohc/n/vl2iCKGKwgytTSGwR/syziGX2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(8936002)(110136005)(478600001)(54906003)(66476007)(52536014)(66556008)(66946007)(6506007)(316002)(64756008)(76116006)(66446008)(55016002)(83380400001)(7696005)(26005)(9686003)(2906002)(53546011)(4326008)(5660300002)(71200400001)(86362001)(7416002)(33656002)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qJlZdLeE/x0ivD7FngGhlUU8izrdcECDpObwkese0Sh4I51njc4Y6swLI2lk?=
 =?us-ascii?Q?0l8g4qCfO+6jNHrkO/jHePpsWqbjom+lyJzxy12OJ8hNFL9WRPnpNZpJRibL?=
 =?us-ascii?Q?bIQLFZbvLIB9oKmCqf6KWC1HzZXPEPE1IlmYtvG/YZXjN3v4u4Tn0URaU+CY?=
 =?us-ascii?Q?CBgYXbPEx0yBB6asejn+fIaZxpCBUSS91KNCNEocqZcsgJo/bmgNnEF1JCpA?=
 =?us-ascii?Q?LSoXG774DzDI7dgy4HrALop0eENkiyDCyp3ItV417wKhDPsxukwruJvx+PmS?=
 =?us-ascii?Q?lU1GZtX2c0EwbnUdJaYLgUb05lFvO2B+5LgrsQpVeJ9cxbwyjGFz94e/CDEm?=
 =?us-ascii?Q?xM9NJ86svPULjugOz6pKENL4rv7peM9fsPKxq9mCoVkShSIc9znfWdNwOH4K?=
 =?us-ascii?Q?P4bdKW4VGhMJ8R2612rxi/GHgvJ0Anigiaj/HjlKNPuujume55D0gVdUBDcg?=
 =?us-ascii?Q?ZoCy3Il2whNE2YA7ZWW8e8DNqncDibzRvHL5ZXm4VeesS7nWhsk91eWOVUy4?=
 =?us-ascii?Q?Av4t6lWYdCRFXmXs9iBtjPY4hEpoBlbkMOaQOQGQx2ub+rXH60W5YMPg/Obe?=
 =?us-ascii?Q?PTV5kSDpM9g7koR5b/ev4yhplRAyE31qD+WrlD5BgdsOq4nUBnkZ08c/odzS?=
 =?us-ascii?Q?1cSB20Edr91jwgAKuM0SHFapA50gQKDhD9bONbK65VJN6/HfJ33MdbolPiSg?=
 =?us-ascii?Q?g4LK3r6tRUNL+0Qmt6s58pJTjRQ3H8hpkuxrTOVJin9z3Nm/2a1enS33yblG?=
 =?us-ascii?Q?4+ArLqJ+rshpCxvwwH7d8DXW6lYnAAHPtdDr4wZA7Owstc/SI/azlO4fU0K5?=
 =?us-ascii?Q?G/zQtVtTemPfvSvj22GBtz/78DfG9O65UVhIxjpC4Wbath1hO/TUGzQyKqo7?=
 =?us-ascii?Q?pvIf1zyXWfBG7Xoyfbw3f1OzNDqG6NF+KR1ZuVyz6sGR90e8lAM3bE2CNzZA?=
 =?us-ascii?Q?Obdpnt7WHSjdlmcYdLcHlry0fT0b67GsNlrqnAdZyqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0684029-173f-4b6a-c099-08d8b2ec81b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 09:13:32.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/iEDOeR3g68t2pCSW8jmE3B/sxnEnksd9wT3GAcfEwpeZwwZwDW7WNkPS5HrntD3clVwkwAcC1XwV9zd+PV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Thursday, January 7, 2021 5:19 PM, Ran Wang wrote:
>=20
> When doing CPU un-plug stress test, function smpboot_park_threads() would=
 get call to park kernel threads (which including ksoftirqd) on
> that CPU core, and function wait_task_inactive() would yield for those qu=
eued
> task(s) by calling schedule_hrtimerout() with mode of HRTIMER_MODE_REL.
>=20
> stack trace:
> ...
> smpboot_thread_fn
>     cpuhp_thread_fun
>         cpuhp_invoke_callback
>             smpboot_park_threads
>               smpboot_park_thread: ksoftirqd/1
>                 kthread_park
>                   wait_task_inactive
>                      schedule_hrtimerout
>=20
> However, when PREEMPT_RT is set, this would cause a pending issue since
> schedule_hrtimerout() depend on thread ksoftirqd to complete related work=
 if it using HRTIMER_MODE_SOFT. So force using
> HRTIMER_MODE_HARD in such case.

This issue was observed on LX2160ARDB (arm64, 16 A72 cores) when selecting =
PREEMPT_RT,=20
non-RT kernel works fine.And I could verify that fix on both linux-5.6.y-rt=
 and linux-5.4.y-rt.
But for linux-5.9.y-rt and linux-5.10.y-rt, looks there are other issues wh=
ich blocking
verification currently. Below is the steps for issue reproducing:

1. Kernel menuconfig:
CONFIG_QORIQ_CPUFREQ=3Dy

CONFIG_HAVE_PREEMPT_LAZY=3Dy
CONFIG_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_RT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy

2. Shell commands (Issue would happen within roughly 400 rounds of below lo=
op)
echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu8/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu9/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu10/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu11/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu12/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu13/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu14/cpufreq/scaling_governor
echo ondemand > /sys/devices/system/cpu/cpu15/cpufreq/scaling_governor

count=3D1
while [ $? -eq 0 ]
do
        echo "$count th test"
        sleep 3
        let "count=3Dcount+1"

        echo 0 > /sys/devices/system/cpu/cpu0/online
        echo 0 > /sys/devices/system/cpu/cpu1/online
        echo 0 > /sys/devices/system/cpu/cpu2/online
        echo 0 > /sys/devices/system/cpu/cpu3/online
        echo 0 > /sys/devices/system/cpu/cpu4/online
        echo 0 > /sys/devices/system/cpu/cpu5/online
        echo 0 > /sys/devices/system/cpu/cpu6/online
        echo 0 > /sys/devices/system/cpu/cpu7/online
        echo 0 > /sys/devices/system/cpu/cpu8/online
        echo 0 > /sys/devices/system/cpu/cpu9/online
        echo 0 > /sys/devices/system/cpu/cpu10/online
        echo 0 > /sys/devices/system/cpu/cpu11/online
        echo 0 > /sys/devices/system/cpu/cpu12/online
        echo 0 > /sys/devices/system/cpu/cpu13/online
        echo 0 > /sys/devices/system/cpu/cpu14/online

        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo 1 > /sys/devices/system/cpu/cpu5/online
        echo 1 > /sys/devices/system/cpu/cpu6/online
        echo 1 > /sys/devices/system/cpu/cpu7/online
        echo 1 > /sys/devices/system/cpu/cpu8/online
        echo 1 > /sys/devices/system/cpu/cpu9/online
        echo 1 > /sys/devices/system/cpu/cpu10/online
        echo 1 > /sys/devices/system/cpu/cpu11/online
        echo 1 > /sys/devices/system/cpu/cpu12/online
        echo 1 > /sys/devices/system/cpu/cpu13/online
        echo 1 > /sys/devices/system/cpu/cpu14/online
done

To be honest, I am not sure how non-RT kernel could avoid this issue. Could=
 anybody give some input/suggestion on this?
Thank you.

Regards,
Ran
=20
> Suggested-by: Jiafei Pan <jiafei.pan@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  kernel/sched/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 792da55..4cc=
742a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2054,10 +2054,15 @@ unsigned long wait_task_inactive(struct task_stru=
ct *p, long match_state)
>  			ktime_t to =3D NSEC_PER_SEC / HZ;
>=20
>  			set_current_state(TASK_UNINTERRUPTIBLE);
> -			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
> +
> +			if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +			    !strncmp(p->comm, "ksoftirqd/", 10))
> +				schedule_hrtimeout(&to,
> +					HRTIMER_MODE_REL | HRTIMER_MODE_HARD);
> +			else
> +				schedule_hrtimeout(&to, HRTIMER_MODE_REL);
>  			continue;
>  		}
> -
>  		/*
>  		 * Ahh, all good. It wasn't running, and it wasn't
>  		 * runnable, which means that it will never become
> --
> 2.7.4

