Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83443C636C8
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 01:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE6C611C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 01:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhGUBCI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:02:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:58419 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhGUBB7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jul 2021 21:01:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211414929"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="211414929"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 18:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="414968960"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2021 18:42:25 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 20 Jul 2021 18:42:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 20 Jul 2021 18:42:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 20 Jul 2021 18:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwlvbTeoEbe5wO5FWcbschSD2yubh9ZYRzUJr44nDVI3DA1Wiym341PougQKjPzYyXdPrXXi8IlOnt2T9RSEXf+D6UscuFmir/83ABmP4nk6xiCHNlrEerxysUSSjiFjNNryRcmdevjGNQgfRFpAfwONeB5gu4lkTipDwNXBvPEgHjH2ELr4dNwuKc+8BRLt5OKrJeALkCG0wr2mxpuN8t4SGcQy3o7h/S4cqDqi3zBnAzGay78eZonb8HojbcyE3ne2rkD1+Qoo5s+tcfpiaHLulLSAoKwSmz+oFgs+XSsloPSPEspcBxX4CdCxN0XDVjsGHhIqadoUOsyPEAzCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMqd9K80LQDCmRl6MqHjzZL38aiy2BBUhiA3PAOfs9g=;
 b=d//hbLCniVD/bFmB5qM3xiqxyhM9tBbXBBV66BLU+n6zGTCY8SbUy96Ece42XN5Dg1vEP0/7yWWlE5LXp7uyLAl9QnMk6RgaJWpj3CPwitD7nxMdi+sywaFb9PtfGqQarDWUtOxARmbgBA1/vBUEDL35n/2ctY6oEJZZU+ZH3uCCBMQ8h8fYhMX2pMTKwFm5mewUytpt1Ld9drYLQR8JXkmaGe2VtWFlJlzNuC1xo15z37M1O0Fnki3SuOitCXojK4jDKhtXSWOwBLOe/rGVj5q32Gesa4atR016RxcEOE0cvgY1IYAbnhApHD5WpsyVsnR5xWzhAt9MfhLDlqappQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMqd9K80LQDCmRl6MqHjzZL38aiy2BBUhiA3PAOfs9g=;
 b=oxYzJborw1FSnNnnmIbtsnSHeCxghsXKgAc0imC1yM8GIu01A7O35uPOSAoQyM579CiQVi5lzXgjPoXdO8dgbKqXUkcuJ/vwkSCviHmZ9h9aKInzUz8pCpImMFIj8guDvU8CaQMlF9zBL7fL3torpc1Rh+hC14evWITwNa1Xos8=
Received: from DM6PR11MB3802.namprd11.prod.outlook.com (2603:10b6:5:143::30)
 by DM5PR1101MB2187.namprd11.prod.outlook.com (2603:10b6:4:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 01:42:23 +0000
Received: from DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37]) by DM6PR11MB3802.namprd11.prod.outlook.com
 ([fe80::69c6:1b3c:1597:cb37%6]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 01:42:23 +0000
From:   "Qin, Chao" <chao.qin@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Mei, Paul" <paul.mei@intel.com>, "Li, Lili" <lili.li@intel.com>
Subject: RE: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep
 in pr_flush()
Thread-Topic: [PREEMPT_RT][PATCH] printk: Enhance the condition check of
 msleep in pr_flush()
Thread-Index: AQHXfEaHiU7PgYfePkWUMKzzHnOuTatLw7eAgAAjuoCAAMICMA==
Date:   Wed, 21 Jul 2021 01:42:23 +0000
Message-ID: <DM6PR11MB38023473B7954887A059728992E39@DM6PR11MB3802.namprd11.prod.outlook.com>
References: <20210719022649.3444072-1-chao.qin@intel.com>
 <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
 <87o8axm6ae.fsf@jogness.linutronix.de>
In-Reply-To: <87o8axm6ae.fsf@jogness.linutronix.de>
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
x-ms-office365-filtering-correlation-id: 12ce4598-b40b-48bc-9ac7-08d94be8c9c0
x-ms-traffictypediagnostic: DM5PR1101MB2187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2187CBE042E5AC9BE4830BE292E39@DM5PR1101MB2187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHY4ubxOLASQ/QxywF8aDrMEj3RLq+S6xogaoqZnrkdS/SBzlSnZYl9XBTPUXW+ELIXle3KrmmkUIPNAGgPxa1QyKBB64iAsKSXBr2fKozbC0+eCrxN0l8Q1ieuYVsllomEk1toqVh5HbVeOV2jeeD3BCX4jCEFE1XfiH5D6fRMRvGyWLg8N8iRw8l/ebZsuCYFpzhCzKQTggskvkyBWgYTmgw/H0FvRhOt6MAQ6nrl/nVhUrsFEDtRRT1Q+jC1WWtagg3X69bvw1wigNjIdWlO9vApRQ8bw4b14errMxQ0baE7pCW8vXbIclsM2lHdAr/jfk+N/ucmd2jaLuGU1GPeoo0TC6uLn+j9P1n5Nu38nLputMgGYwSFe94R5YipVzUkXI7eBI6EunJyMwJqIbgdU/VY36Tda/RgJeegbTvKwgFVjbDKTrup1FQ0YSo2W9r5Kg8I+mwDwnLQ2HL3LEMxZhbFBTFpYjeU3uCosp/ejQtjos+qWRT1munz4ItYtdgw5TWWLjuEaIABne0/ILgX7cnxW8Sjivly6KABmFv+30DhuUixytbhix0lb86p3503W84NsuDr7PXl5GDBoONqa7L1mLRYYM/m6VdySplJBxmEAjg0Ose4uZWqKHU586rDZMIO0qx68LmmO7D6L9Z9J4CseryS7VHqq4qZxWxBXeM1UgWOIPJCB6nU2n4Au8PeRZEspxdUT5vvaO370EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3802.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(83380400001)(54906003)(316002)(66556008)(508600001)(8676002)(52536014)(5660300002)(122000001)(8936002)(55016002)(4326008)(9686003)(66446008)(66476007)(53546011)(110136005)(64756008)(26005)(71200400001)(7696005)(33656002)(76116006)(86362001)(186003)(2906002)(6506007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xoVaDifoWmVKAuFmQV8KrxZuzWoUu0PcFf9i1AyQUW6Ujz0iGfbSklAh6mcv?=
 =?us-ascii?Q?iKvSKzHqBdjdIuAL3+30bi6kP3Js3Scn3FAOLcun3z/HpIh+icskn90V8ewQ?=
 =?us-ascii?Q?biJTClY9AOuHAgGFao0QFKTTb+EXW2WXIiaBar3jk3r6xmc3cW49UejDSzWv?=
 =?us-ascii?Q?JaZAzw+5Mc3HSc8QuigaCL088edbedE5mfnYDI5+s5CwV5canKYeSlgIfZ7A?=
 =?us-ascii?Q?iw2m6y+qFcYKtEKRdpwQ/mxdXudc5ntQGHnUvk717EwhJmEEaZS6qnDtVhDr?=
 =?us-ascii?Q?ySjRiz0zolfrY/dKQXqtgGfJkm4BVtLaAwg12nFr77zm2jzCTy19Ec9XGsc7?=
 =?us-ascii?Q?WW2P3fkXU3Aa3LmrnNKzRyQ8w5uMLiWDDxcyhVhr+PPORh66pxMXaTCkcRbY?=
 =?us-ascii?Q?te3m/RBqTAo1IDCzK0o8NGEcSWChSp5Al6yffYB6NnVZvZS5vUusmhnasBtU?=
 =?us-ascii?Q?0CZFKoFtUfZf/eau3PFD2zfLpOXEbLaJFyWeXFm9/t/CtyIXFELHVw+QtFMr?=
 =?us-ascii?Q?5M4wKmXgAsR6ERowPi5PbGQdRsgpumgWxXtkS+JvCRRqK8g99IaxeuCbpGwu?=
 =?us-ascii?Q?sOb9uAlWVt6J+1/UW+1F5K0dj5rURujjoty4OUp/VNUVTHWlPGwG3/ovNBHH?=
 =?us-ascii?Q?ii5vsSe8biRbwpDPxNhJddGnuEFVgtLkFqmL/o4W7GmfZ3GByTFp/r9E/N/Y?=
 =?us-ascii?Q?PL+8qSv2V7XHbOhcHYdFe7u7dQwCopQfngK/Yi6Ys2Sbcqd7xVjNvvLv1AKQ?=
 =?us-ascii?Q?9zfOSXeYJhj3BhyQpJPzqZRVUmekaq+7ejvMIykud9rOwiY8QD6LE5lAACe7?=
 =?us-ascii?Q?Ryz4d4V8iWlSoVwuUKJ7Mh9RXV5Lodvq2KXoGrI5f0R7tL/4V0eflYKZNQ5M?=
 =?us-ascii?Q?mVQOCAnUk8D0BzRjprh7N0wJLHdUyIvVxpWDnGGdm8GBbhwpE/YXzIBrIvU5?=
 =?us-ascii?Q?SozAE/IrTsiyUIFwxC9vByLqh+V4mywVYOrukOvZFJohe6LNA1MpsD7IoAUN?=
 =?us-ascii?Q?3p8egtCmgkfODQR5QoQVQLcjJMNBFAJ62TEXkBwyBnG+IPmCFhVxT1KQ8X0H?=
 =?us-ascii?Q?ouXrn3V4E1S8QWx9hIOqlwcYqKIaUn8ygEHVz/uzDpJrScSfpbo7lalSWPrd?=
 =?us-ascii?Q?RBxV9Fp4AgyYCkslT7I4xiyjDiPyN0uF13PNv7YTWjo/VS7G5omP+MlQVEe0?=
 =?us-ascii?Q?jwBDFJygQjW33rWSsagGbMnrzOfNmgrxtDmK3/ttBNFp8xS9WQeKHl5AXLCA?=
 =?us-ascii?Q?w2kaUDLvYZ0z2p1vWANstMOQtel2C9vyVK8z/T+x9k5OfbCDNh2lERykMs2l?=
 =?us-ascii?Q?ZWst3wV0LH2ZPgbKymUytOOX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3802.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ce4598-b40b-48bc-9ac7-08d94be8c9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 01:42:23.7455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N7oFv0U6s8towe5KoG9FQ4PGXkOMLostg0kp/pCBVsCb6f26QlcrmIoxdk5FrdLjfy+K/6yMyRVT26tnxNL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Noted. Thanks for your review.

-Chao.

-----Original Message-----
From: John Ogness <john.ogness@linutronix.de>=20
Sent: Tuesday, July 20, 2021 10:03 PM
To: Joe Perches <joe@perches.com>; Qin, Chao <chao.qin@intel.com>; linux-ke=
rnel@vger.kernel.org; linux-rt-users@vger.kernel.org; bigeasy@linutronix.de=
; tglx@linutronix.de; rostedt@goodmis.org
Cc: mgross@linux.intel.com; Mei, Paul <paul.mei@intel.com>; Li, Lili <lili.=
li@intel.com>
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msl=
eep in pr_flush()

On 2021-07-20, Joe Perches <joe@perches.com> wrote:
> Logic continuations are typically at the end of the previous line.
> And there are few too many parentheses for my taste.
>
> Maybe exceed 80 columns in a single line
>
> 	may_sleep =3D preemptible() && !in_softirq() && system_state >=3D=20
> SYSTEM_RUNNING;
>
> or align the continuation
>
> 	may_sleep =3D (preemptible() && !in_softirq() &&
> 		     system_state >=3D SYSTEM_RUNNING);
>
> or use individual lines
>
> 	may_sleep =3D (preemptible() &&
> 		     !in_softirq() &&
> 		     system_state >=3D SYSTEM_RUNNING);

The kernel now has a 100-column policy, but I decided to go with this third=
 variant for easy reading.

Chao Qin, your patch will be part of the next PREEMPT_RT release. Thank you=
.

John Ogness
