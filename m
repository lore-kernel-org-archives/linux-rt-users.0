Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECDC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 08:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiC2Ivo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiC2Ivn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 04:51:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28C4C795
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648543800; x=1680079800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xDz9H0SrFB4u/oCpGilJavsesiP1dIvnliiUk+fZ/5w=;
  b=etYjfNQrqvivE6AuFQ/esQ6ltgJ8V47t+E9LsF+wU2wV2ttiN8n5NH86
   3xzANcCS87h5Ao4N0vb48ZX/ro++Rf1H5mSXL7Ta54Wu516BILQUVSMDQ
   WUChPh8Z3vjWzEZm4F4UvZ/GLxx8rm3r3VkPuD9Z9vfii4z5VCwWcNFKu
   d5pqyqAUQRW2QZECntyfVrf+T0tucfPXrQTr67o8ruyZqUQd7RDQ9biQf
   saGKbgbRqJxqc9FVOW5T5QggEfHedaI7JjaBkpxCpMaIq3vaVA/Ay7+Ls
   EDbhk5FCk5RmD7hQls9FmLicqyGYuVV4dQ+Uo3Sa7OEL5lyx6ykQ/hrxw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259169114"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259169114"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 01:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="518792674"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2022 01:49:49 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 01:49:49 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 01:49:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 01:49:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 29 Mar 2022 01:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MttmWeXDz9foNBQHAlbxpv0zK8XSZ4AcPKWseAzyRJ/RhDOidyAlnBXLFg4ENxIBFwFGAJXJ8ATVEcWzJ8C0jOWmkvF+atMGbffUoZ3MftJo64dz5HykC0mztkEAsWTyow2l32Zn/Y2xZSBCvssZpwQ24li6SYVQV8g039fMDRYHsoYHhJuu9nrLFwA08loVZxIEXAoYb9XHjL+bP0Be3UNR53yNhKlrB6IH0cWFCvupn5iQOUx58TfbtwxKurAr2CPP6zGegMo+4YsoNIK676LTovsbKCtr2HRja9Z0ynXHGp7E5ix7CkewwI0BRT8kcfmCPdkAchvGDp2Z0mWqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlTs3rJQANtvOvv5fSyco5CrbPqAM+W7e3cwu+o9asQ=;
 b=HHp7RCFVSYwkDOAJd/ey4BUJunC2kRc6LKxHgP3v98eM76wNO5k92ov7nxjnIKDV4ui0kQTUMUJf1dlYYd3kjLUlkJAFrQoqPMODmXD+Ct0b379tvjlD3pugKxI1ZV+eXwTZgKHlHs1y0VgLVZh76e5TV948VhKqBmMPogQI2ULuR3ggKmvjtcz6sIMAnsyPbc7GKbbIxiMbCRlZ1v8fNBJQhk+Kv7SE+ELYgakWmfh48w/X1snlmQTzUkzj6Ki5A/2GfgO4ku5CA9zVsMCR45hmaHXljqpLtH611eAAlowWt2hyA1BDGmEmKrNwuCPqfX2Q7kxUp2U1qWbRSx9udg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17)
 by BN6PR11MB1764.namprd11.prod.outlook.com (2603:10b6:404:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 08:49:47 +0000
Received: from DM6PR11MB4596.namprd11.prod.outlook.com
 ([fe80::5a0:cecc:2762:cb1]) by DM6PR11MB4596.namprd11.prod.outlook.com
 ([fe80::5a0:cecc:2762:cb1%3]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 08:49:47 +0000
From:   "Chen, Angus" <angus.chen@intel.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Ung, Teng En" <teng.en.ung@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: RT  kernel video playback issue (screen freeze)
Thread-Topic: RT  kernel video playback issue (screen freeze)
Thread-Index: Adg/WV4r+S4DvCwuQSuPzVnN6R3xtwDt8mxAAACHFvAABmp6AAAGSm0Q
Date:   Tue, 29 Mar 2022 08:49:47 +0000
Message-ID: <DM6PR11MB4596B054753D1CFD3CF0CB908F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
References: <DM6PR11MB4596027F97399B46BCD7681B8F199@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB459605ADA58FBEAE43EDD3468F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
 <YkKXfiwl+CJvAswz@lx-t490>
In-Reply-To: <YkKXfiwl+CJvAswz@lx-t490>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f4f56a0-1139-4317-2d67-08da11611400
x-ms-traffictypediagnostic: BN6PR11MB1764:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1764E3A3C20E726B2BCA55CD8F1E9@BN6PR11MB1764.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YjMlD897+NZ2jZh4oVYpImdc2/L4czgbNmumTCljVkd34YodaOZMXEE8obr3w88SdBsw/foSvtUVxQvJDj8tZyyeORiTKVUnDEMreNU9rIWfzCJ85oXp2z0eDWspLDvmd6pl0IdXWI4jO/DzMBv3JBXR65dvZnSya2/3yCrkOqIbimRJpTtD3ajctWGdk69e3IRwJt0rWqaC/VtXr63kHYLl13nEeM5sLWzbj3oXKW4nBX5OvlpM7fF3bQTbYzdns+sqRSkWNa9Zj6fKyHRw8kS9ESv9tpKratW93z7AObJPl3bEmxoB10/Jxu+JiKOOVzOnOxlrnRPCCiLY0ncTVWf2kUz+XZzxdYABhgfVSXgAJuFkRttTSSjjm5ZXq4JUo0DowfVd5NYOld+h7jtfV4ZpdOkKw8ddDypOEA+U9MA9nTNmdWznWixrrMtjXFZj79sQfU1a2lgaWFHrpa43OA346S9quSAKMPOiSvu6bf/FS2f6W6FrzClc1hliiBlX9v5/OwXGSL8tXT+mwnoXas5E1ETazMEbL5+YQqaZfRSo/QtvbEUDOf5d4buhWLQPkkdXUvyajTEYF7PKf+leoN8HovKdIj3kzeD8bQw4B/sojN3EjkoOuuf49aTh4ktEvfAjUjDMUXnTJqrswALd/Rf7+bNxcQZpjHP03ehGzZDs47jpMtp0JOLnQ8Gny1/PzcV0bwwQrF4MuzUeBnhAhaHFj9/zjgHw/8hdkUlcPAzm/Bk9KXUaCvAHbk6DNVBEuyMISNFb74wHEEkH06TCIvRmzb108VpCCKr20Fo5+R83CymPds/hOvJITpnyWB/gmV0QYc4SI/IF1IOD4okBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4596.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(54906003)(4326008)(6506007)(8676002)(9686003)(316002)(66946007)(66476007)(66556008)(7696005)(64756008)(66446008)(6916009)(76116006)(86362001)(33656002)(83380400001)(966005)(2906002)(71200400001)(8936002)(38100700002)(38070700005)(508600001)(186003)(26005)(55016003)(52536014)(122000001)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R2n9dgNSo27l0xt96lkDz6rEEEjteu/mDBoiCHj7ajQG2IBYLwzCKZ/bZ0?=
 =?iso-8859-1?Q?MS6UXCoO4ShRXkjrBm5oj1wo/xFys+1SlAgpKcKdsvNZgufwZ27xOEIl1j?=
 =?iso-8859-1?Q?mPwwAGlptCWlKJG3ytI1Pez8cofXw3XIibDxLwnompR1EwruHJ+OGclAsN?=
 =?iso-8859-1?Q?PzcUWnO9mvrNwp4oW3RLVqyLb+omCoaAL1Zn9dweQpT2tke0vFJNdxu2mP?=
 =?iso-8859-1?Q?/hK7frbT5Wmdt36P2budClqkVVGrahnjPvEZcioPHD5X88gb/7tauiq6SH?=
 =?iso-8859-1?Q?9m8LUA2Mcx9HAQBaBV5ZeWpaNpzy3FFcIMrPV1cOWeGT2zBpJ36KcS3ttx?=
 =?iso-8859-1?Q?aXtivFQ3assVY8H4zRydUIPSvU8MpKFPfD1p/f96OaMibPrFcAkz1LuHgm?=
 =?iso-8859-1?Q?fSYQB97jJKAJRB6n/VK6agiT0oGg/AHg06Ms8Fks5pa0PfsxgZaVd8Zkeq?=
 =?iso-8859-1?Q?B+YDikanKDzDHuFSk8YvKqNv/lW7RfkPQTakBC7pc0GykEGUdAAgtyISOY?=
 =?iso-8859-1?Q?rJC0jFyABiCxx0kVUeBMoOcj7cg+v04MbmkvOo8Nfzl6lh3+BPOGQiul2s?=
 =?iso-8859-1?Q?eXE2ZYnW682M0b15nzIK08z8SGV5a9WYLz9/RiRRPIeSQ3TVGmLuK8IGlz?=
 =?iso-8859-1?Q?kn4zte/xVdUCSVI3X2PufBio0K3wgjsin3wmbO2Bp/JTQoOzr/MatAU1ly?=
 =?iso-8859-1?Q?D+qAI5UhrgNDo2ez3SPHqUCPHDKq2/KcBloRhgWDiH2CHo0yzXlUzSkzCv?=
 =?iso-8859-1?Q?pwVmac+ciVnk9nU88Qd0blbgTK9Bm+RpR/CXWrUAVUGEL/1AqmCx5E4B3H?=
 =?iso-8859-1?Q?wn2KnGDjaKyrv062YU9gsO297JHZoqySwRLb1cWjtBfHgGNZAToM0JRu4C?=
 =?iso-8859-1?Q?r1fPt52n3Ou4sk7ReHuHYLSzN5F9LP4FpY/i96pGENipDEjefBVTK1uk8B?=
 =?iso-8859-1?Q?i2ABkI/dn7Pu+J42bgih2iJ1cvTSoWsQ2JAgC+C+uaoMR3eMb3E3UDIkBw?=
 =?iso-8859-1?Q?BddxMdi22WYqXvkLNcw1eeQ8zBsGdNzsouGJ3z5o6vuqAHDwBAhvoSCP+7?=
 =?iso-8859-1?Q?WZqvwwiW0gPYoPZZkiZ4wtOAaFCeo9lkFj+lCc06nQJbg2Vgttioy+C+Mc?=
 =?iso-8859-1?Q?3xeYcwWiCriMqyywWG1ExIWn834LOFvkl2DW5h2L6P+Nv0RrU3HfECEBHk?=
 =?iso-8859-1?Q?JiAlJx/1feRZiI7x0KD5FYeZon88UkxKIWQXEMIC6l2Dkydmwnfuotqqg1?=
 =?iso-8859-1?Q?v3gtoK1SKUsv6+6o0uYpJNdx6CN6Wi6YN9mtjU0uZyANWbTbjHSyCSwWwU?=
 =?iso-8859-1?Q?mmUyV+nosPnbquM6kuvNYF4p2hyWkDQtu4gDRLkycbELTZRq2Aq8XIxPPH?=
 =?iso-8859-1?Q?c+FhskjfYJ/d0rezneKGyxU1kBTtqsFU1qx3YLf1Gog5Gpnu8Z76vEfFpd?=
 =?iso-8859-1?Q?kUY9RRIMRJmatealUbbfWtMk6M5o7pFE3/H48s74lOVrEjVnGaSSWpQaNL?=
 =?iso-8859-1?Q?3pGrqp2W7bobgSXaxaMvLxfUiwuLZSxo04rhm53AEjRukNrYGNeAiEx4tE?=
 =?iso-8859-1?Q?4bDEinOcCy9KZ06qNRMisxIF9LkeVA6+zY4ve4ZyAp/ADjwkM3jc4jFq03?=
 =?iso-8859-1?Q?u4tLoCHGMXbwKop6R5fNGyrOkzx0hHQslWtm45Tod8yyNJFJldjKdF0dUd?=
 =?iso-8859-1?Q?Dgye2HuqoehMvYAHZv2uyjWtf0zHWCGGWHi+G11dyFMr/yQkng9oFxq5Us?=
 =?iso-8859-1?Q?v8Ka2vsN06SlvOLpDJD8VsCoqS8RF9PPrIYEMqbbAp5iP0h19rlW9sCJFt?=
 =?iso-8859-1?Q?jg3WSw3JWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4596.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f56a0-1139-4317-2d67-08da11611400
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 08:49:47.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R70aMadkOQoW+KutlVXZ0nvpgbm8GhNXzhqKNpE5UNwg3ny2WDNuUbU9MHKJRohvOwn78xSD3mUN1S4kXqp5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I think the patchset is from https://lore.kernel.org/all/20211006111852.151=
4359-1-bigeasy@linutronix.de/


Now we use RT5.10. So we port the patches from the v5.10-rt-rebase. But it =
only use 3 patches compared to original one.
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/=
?h=3Dv5.10-rt-rebase
irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT	Sebastian Andrz=
ej Siewior	2	-2/+9
irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT	Sebastian =
Andrzej Siewior	3	-43/+106
irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.	Seba=
stian Andrzej Siewior	2	-1/+19




In V5.15-rt-rebase, it uses 4 patches.
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/=
?h=3Dv5.15-rt-rebase
irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT	Sebastian Andrz=
ej Siewior	2	-2/+9
irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT	Sebastian =
Andrzej Siewior	1	-12/+106
irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.	Seba=
stian Andrzej Siewior	2	-0/+13
sched/rt: Annotate the RT balancing logic irqwork as IRQ_WORK_HARD_IRQ	Seba=
stian Andrzej Siewior	1	-1/+1


But I also try port those 4 patches to RT5.10. I also can reproduce this is=
sue.



After I try to set the value -1 to sched_rt_runtime_us and run the test, I =
got the same result (screen freeze)

root@intel-corei7-64:/proc/sys/kernel# cat sched_rt_runtime_us
950000
root@intel-corei7-64:/proc/sys/kernel# echo -1 > sched_rt_runtime_us
root@intel-corei7-64:/proc/sys/kernel# cat sched_rt_runtime_us
-1




Angus


-----Original Message-----
From: Ahmed S. Darwish <a.darwish@linutronix.de>=20
Sent: Tuesday, March 29, 2022 1:22 PM
To: Chen, Angus <angus.chen@intel.com>
Cc: linux-rt-users@vger.kernel.org; bigeasy@linutronix.de; Chang, Junxiao <=
junxiao.chang@intel.com>; Ung, Teng En <teng.en.ung@intel.com>; tglx@linutr=
onix.de
Subject: Re: RT kernel video playback issue (screen freeze)

Am Tue, Mar 29, 2022, schrieb Chen, Angus:
>
> When we playing a H265 file on our Tiger Lake platform (OS : Yocto,=20
> CPU : Intel=AE CoreT i7-1185GRE Processor (12M Cache, up to 4.40 GHz)),
> =A0we encounter a system hang/freeze issue (without enabling GuC
> submitting)
>
> We use the following command to reproduce this issue.
>
[gst-launch snippet]...
>
> We also can reproduce this issue on upstream v5.15.27-rt35.
>
> The dmesg log from UART port.=A0 After the log showed "the sched: RT=20
> throttling activated", the screen freeze.
>

First, are you running a custom RT workload that has gone rogue; e.g., your=
 RT application got stuck in an infinite loop?

Second, were you by any chance running gst-launch with RT priorities?

Anyway, before running the gst-launch snippet above, can you also try first=
, under root:

  echo -1 > /proc/sys/kernel/sched_rt_runtime_us

and see if it helps?

>
>
> After bisecting, we found that it was related to the following=20
> patchset
>
> https://lkml.org/lkml/2021/10/6/367
>

In general, please avoid using https://lkml.org. It's a private service tha=
t obscures the unique email identifier, Message-ID, within its URL.

Use the now official "https://lore.kernel.org/" instead, which keeps the Me=
ssage-ID field explicit.

Anyway, I always got a Cloudflare-404 when accessing the lkml.org link abov=
e, sorry.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
