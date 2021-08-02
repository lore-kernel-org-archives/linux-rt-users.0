Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614BC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 06:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7124360F9F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 06:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhHBGI4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:08:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:42989 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhHBGIz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 02:08:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="213121282"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="213121282"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 23:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="440442988"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2021 23:08:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 1 Aug 2021 23:08:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 1 Aug 2021 23:08:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 1 Aug 2021 23:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW3WOWFaWDn/mvFuGLC8HAPg9YWoWoZVbrX7zTVUYN3tExYP+ENd9i4wp+Ud9mg1Yc/N9Gl/wXmqGPJE3GrX0BFXFvRmQB9HLCDYWZ7VGLtbsMGeEwJyRPewV8IsJl65/MZmhLI5ZVmew1Zy3yGgSOP3UHDvwbKy20ZBmU9BhNgehUSnzkLBil+Ms/9inzGTd8XTOPCYouWcGNHHJTe5wXAOQzdGhpRyMfAFwqTsDtqDXv724+CEw4LBcBWFJBERTWNYqbBg1w8G8Ku1sjXYd//ZkjKEy7JHnzPow2vNOGHCDfVtC/7rrHXglFfl2QZ1T6a7LMlddw3bLpw516Vh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MelHppGwvS9v2HlOYyRfLoVYrH4ZXRAQXky9phcn0w=;
 b=TMmfVnfT00/t58p1PNY7O72bIfsG0xKkdMtJkYLIzs3f6w/tMR50JW4dhndqnFKn4Mmp5a84JLo1WUziybgEnxIJEr1Z5aqG12H1049Vj3fwZG3vFO2YpVtRj3hRVlPu0dvS/X/nvHUwySWsZgKON4A3k5u24YyMO5YLG7VtOCNoQ6UPY/tjuMpXOghwI1HTeuoXR0yclRJSDOU5w8R20gRIPQGGAS28TkC+i5LuAlBFIKbvuRHjZkYhR2RBKtJcojp+pN6m3oUzauwZzhJN0kswLv07rhpwhgUJTJzVSfy6e222PyXoEDbUugMvNjoHcVSKu9ZgXvBiPqPbguGxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MelHppGwvS9v2HlOYyRfLoVYrH4ZXRAQXky9phcn0w=;
 b=B7CDuVNj4/p9ospmUwfw0lQyYtV/U5dBurnhIhKT7HE7PU9RcPcN8vSrW3WhI988/9MV4V6dE0SctmbZePJzLDFr1RuumMW51APCusX43t2HQOoSl/ORVjJEiWgP0ioGiuQRvQradeDj5hZVeb6QzhnVcW2cd7mfnemdBDzu2ZE=
Received: from DM6PR11MB3802.namprd11.prod.outlook.com (2603:10b6:5:143::30)
 by DM5PR11MB0025.namprd11.prod.outlook.com (2603:10b6:4:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 2 Aug
 2021 06:08:38 +0000
Received: from DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37]) by DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 06:08:38 +0000
From:   "Qin, Chao" <chao.qin@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Mei, Paul" <paul.mei@intel.com>, "Li, Lili" <lili.li@intel.com>
Subject: RE: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep
 in pr_flush()
Thread-Topic: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Thread-Index: AQHXfEaHiU7PgYfePkWUMKzzHnOuTatKY8eAgBE6hoCAAAyRAIAEJD7Q
Date:   Mon, 2 Aug 2021 06:08:38 +0000
Message-ID: <DM6PR11MB38028688CCDB34E3A2100DEA92EF9@DM6PR11MB3802.namprd11.prod.outlook.com>
References: <20210719022649.3444072-1-chao.qin@intel.com>
 <87mtqiuzd4.fsf@jogness.linutronix.de>
 <20210730140143.53wls2g7xf2ktdgv@linutronix.de>
 <87k0l7svu5.fsf@jogness.linutronix.de>
In-Reply-To: <87k0l7svu5.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97f2bf89-e6a7-4a06-95b2-08d9557bf842
x-ms-traffictypediagnostic: DM5PR11MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0025412D46D7E341941FF9C392EF9@DM5PR11MB0025.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/6DHBqfPZD/7S76EaoYbeUVgu19mcyfZKyLSCWJYGk10izMpVyeDKOqfEb9NZ0Ng+lV87oULomPciBnhxdByQ8jQ/PQ5gdWeXTmMLLtTLOYPvFrw7Ks3SmzPsixjWQh0sgsgiBvPdqh9KVKbGn60mpk3TVWZw/fimrtyMeQTwsOTWLiwXT6ioJAH0/TiVKjx8MQl96I3fS0/g9JFYD0cFgpVTBwLFMIc98vPDsRgMv3jbbYCz47pKW4hIk9sdePPoYQnnHVzguynXHH6d8zT1EOxh4H/GbD8y6/MlrahgOd2DkPv1KuI70mG5+k/F+p4b/upqQGQcueXh/pQBVzkuSJ4pSfOKbxxArs1zDoL3/lK3wxh6AmGDUUTMqxcXawkoUxxjx5sIDg4aRGbiJoxN2OZR8pzONlY1paKbCxhrPD9j1MjNMjo4T4AE+acCJqngwnwbDntqXaTG5pP/pY8n1MiVQUGN5AU3uYgfjKKvq+9jJvFUr7VGt5FKXBWszx/5+32AB5P3H6hARvW0SzmqlF4/EdSEaPdp4f0Z6C19NdnW7lfeQBVb7U0Eh780pBBQNhsl/QYcuwLg1YchVv2Ybmczhzy54HHQroCJFIuT6Yr525zg9yBCF9hHrNXjim2IrT30XGjTB7qBqmIWxPRBKK9kaC87p1z9gkr+lmCmSOB6cLCietCR2MSOvz93kRjpljjnqk5XNBOiOtIhmJuDbNsTkTnU5YaHQDWYW1LQQbgG6h0n3lepHe6slzsxezetN/Fq3nGvfLFGnkB5SC9oaIdNWEOAR6UO8KDg6C/g8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3802.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(83380400001)(86362001)(122000001)(38100700002)(7696005)(4326008)(6506007)(8936002)(26005)(8676002)(76116006)(66946007)(53546011)(5660300002)(54906003)(66556008)(2906002)(9686003)(33656002)(55016002)(66476007)(64756008)(186003)(478600001)(110136005)(52536014)(316002)(966005)(38070700005)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gHmebVQ9NmhRrZYmBg1ASFrkSIXK7rMpjrpgQghl5XhO0x3TRiQtpB7+Kcna?=
 =?us-ascii?Q?9usJHyir02CIuvP2vIHqUOtClPkstT4Geyl4YW8EMf6I6pLD4FuM4f8Tfw8l?=
 =?us-ascii?Q?CFJZzzsAWTkDk56TDJdPKO0iIOMgAaRPKZIgAp/CMphmnr0cyLHGlST8hgCN?=
 =?us-ascii?Q?8JErAU4U7ggetcjJmMVYyZoJvH+hkoLsZaiHlJ4SSez+Erw3adakacySBNCy?=
 =?us-ascii?Q?zrIT/tVC73NIIGT9t36frtAjHnUfrhqEWV/0+L5uHWPtoXTTu3ekKWVaheHD?=
 =?us-ascii?Q?9bR/zHwdnpJSmki03ob0VJ1nZ0BAjJoDENPIviVgkfezao9vH5CGeQJpoTTo?=
 =?us-ascii?Q?IGcYR7XuMoT9knT95RDvF1dEegUF8pkA5G970RJ8tVi+8sD0dtyYfKsmk+2d?=
 =?us-ascii?Q?daf/SlvVBxivDK4Qv8f8zgUC3FRwT/W7kJ13T4Kh7l/5H957YHo2Cz2VczLI?=
 =?us-ascii?Q?tyxemYijkNvwajtpy1sLzWka8eZXdL81umnaeIG/E0GLvH6mkXsAjT0fJfQ7?=
 =?us-ascii?Q?EWp34PL4GoR6MNmLcdkAQ4UT0g7/6QmBz8HIAeiMHqaPb5wvQmltExBw7jXb?=
 =?us-ascii?Q?TNTRqQChNcsZmFHvUwEMZ57GKekH/G9P1EA+2L1yOvrxIL7mMmta/pWxl/9U?=
 =?us-ascii?Q?9FOXGh3wTujliMJQV5Vd+9oBcjWMnyrldRwogl/4kIojD/mIKd2YrcQBKEzQ?=
 =?us-ascii?Q?QLRwZV2pbJNAxm2pO0MpRrut+Odil9CaqWKS5gbF3on7ef8tvD76B/qlBdVC?=
 =?us-ascii?Q?C9xqDdeGVpujmIUHiFzO70uwfquqzlQDJ7T78kEJRMJ3JC4GEP5rJA7E3I7S?=
 =?us-ascii?Q?OY3lwtXH8ekBbg/BGmGUe1iUGCCGqwhnkN0Qt1MciTTTLxcIR0mjAEssdanW?=
 =?us-ascii?Q?+sjSZxX6K+DOyBYkVw0ZSOUibKSYbLl+Ei3AXOnzRG6md70Y0PI3qfvrXiEb?=
 =?us-ascii?Q?aKY49Scl8nOU3HTBXzlzDxdiGb32uBg7D77qyKjJ8IR9n3svVCVBujU1rjPo?=
 =?us-ascii?Q?QJ5Bz9dIO6LiTY8EHVBCN5NoCi5Pm2bR048A6WFW+Idbc/Fu8O6O5BQAscFs?=
 =?us-ascii?Q?3kB/ZfLTgqrzcr43pnNyfQ7OQtVaLBdZF365Qmy7Ncvj2hi/aq9UHu/zzPJM?=
 =?us-ascii?Q?NR+rthL1A8CnHnzagrHDB9yey7H0c9W0jp0a0wslF6xyqy1wc1ELyd0utraF?=
 =?us-ascii?Q?EG3vplGE6ihlipHChu76IE6R0nMrhmgJC4TKUO0ZF/X/kB2nn/W/0ty1sOSs?=
 =?us-ascii?Q?CHNlsbXSMoAqvxKbJQZaRVp21/qRy+GPX9MYZNXtS8esyUOL9dHVfxmS7tyR?=
 =?us-ascii?Q?UTpbfQJ2PaNajlGQDsG0sFoe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3802.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f2bf89-e6a7-4a06-95b2-08d9557bf842
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 06:08:38.3307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEDWmjn2u9S+sfVHtrS7tUCjQ5K3kuyCb8clzNMmp1rvSCuu7jnticmtdG/+NpDv0BS8psmOkocaBDelNchvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

As John Ogness commented, I also found it would hang if sleep when >=3D SYS=
TEM_SCHEDULING.

 And as in commit https://lore.kernel.org/lkml/20170516184736.272225698@lin=
utronix.de/,  it should enable sleep right when the scheduler starts workin=
g(>=3D SYSTEM_RUNNING).

-Chao.

-----Original Message-----
From: John Ogness <john.ogness@linutronix.de>=20
Sent: Friday, July 30, 2021 10:47 PM
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qin, Chao <chao.qin@intel.com>; linux-kernel@vger.kernel.org; linux-rt-=
users@vger.kernel.org; tglx@linutronix.de; rostedt@goodmis.org; mgross@linu=
x.intel.com; Mei, Paul <paul.mei@intel.com>; Li, Lili <lili.li@intel.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msl=
eep in pr_flush()

On 2021-07-30, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2021-07-19 17:01:51 [+0206], John Ogness wrote:
>> On 2021-07-19, chao.qin@intel.com wrote:
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -3620,7 +3620,8 @@ bool pr_flush(int timeout_ms, bool reset_on_prog=
ress)
>> >  	u64 diff;
>> >  	u64 seq;
>> > =20
>> > -	may_sleep =3D (preemptible() && !in_softirq());
>> > +	may_sleep =3D (preemptible() && !in_softirq()
>> > +			&& (system_state >=3D SYSTEM_RUNNING));
>
> I don't have more context but scheduling should work starting with=20
> SYSTEM_SCHEDULING.

I also thought this, but a quick test shows that is not the case. For examp=
le, init/main.c:kernel_init() is called in preemptible context, but
msleep() will hang if called at the beginning of that function.

John Ogness
