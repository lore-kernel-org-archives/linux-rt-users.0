Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1215FC433B4
	for <linux-rt-users@archiver.kernel.org>; Sat,  8 May 2021 02:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC7E61059
	for <linux-rt-users@archiver.kernel.org>; Sat,  8 May 2021 02:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEHCt7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 22:49:59 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:52250
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229775AbhEHCt7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 22:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwM+pRt4QhqnJUC5qUPLOZ9r969GglE0OVM2y2XIp2f5f+4NSorFb2brcPL9XalK0CVjuOReBR0fBcNP+O367qxTnV6aIt2POg4ZUf1XXNaaI9qG7CuJ/gY613ketHWqq8JBFk5IRgc2+L31fMBmaA5PG6k57Qu0Sq2l88506uppJPulQjgr3jJZk6y82oXyhiJJvULEeJ788COq6VGtxTbhQnLaQUERdyQESyBmRdetMdyXM4UziYmIUZw/y3tcnQztORcPVFglrBV81WnrUd3LEEmoMEoaFfUzSBvJlB1Di0Xlq+VLgG1yRNRQeu5O9bglxQzxDR8uETfog1qjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg/ondR7e7LXhYnp6AOqaHpBLOl7HMEaYvbqgQpVQFs=;
 b=ZxEKUILQL9KhuGURU77huO2sV0vVnR5ba5H/hyZWmTEkS1AySFprAeETE4JUd04elFLhYoRRVuxoUs5SNdlGIdEo1bK+gMnJ2J/Y9z8mRZZQkCI2CW0JGJKn9nV4FZ9AOHHpcvF3olfxwGl9DRduBYqb1Iuk4Fv1cfjKF8NUn3r/tmwv+OOnLG8BDJltXcoqpssMA2+dRyAiprcnm0gZTXJlv7tguLyGENd7QL9WWhvUGSdGtvUdJVACyypIS5qY2LEg0uhB2n4Gc6dabAesMvvqTsdNgG+NXR2XX3fo3COms+dlvmeE6upwJkHHuchayiMPmtJ5ORDK2vF1O5tpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg/ondR7e7LXhYnp6AOqaHpBLOl7HMEaYvbqgQpVQFs=;
 b=sPszvUnI23c+w8WBGo3VUkJ46F172czLiewvWB0n5Ixy2nMK4hwBTohclMhLUoBZLqtxmA6vmZER4bzDVFYqArsp8x8b9CZBhfaiEnkLP1+mPUXysp/ssgJtfxcPVLEQJmBpfju5S1PLP9T6W3vZvSSlsGGeNZGSwvW6HkBw/fI=
Received: from AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 02:48:56 +0000
Received: from AS8PR04MB8182.eurprd04.prod.outlook.com
 ([fe80::180d:50eb:d42c:4e5a]) by AS8PR04MB8182.eurprd04.prod.outlook.com
 ([fe80::180d:50eb:d42c:4e5a%5]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 02:48:56 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     John Kacur <jkacur@redhat.com>
CC:     "williams@redhat.com" <williams@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] RE: [PATCH] rt-tests: pi_stress: fix testing threads' smp
 affinity
Thread-Topic: [EXT] RE: [PATCH] rt-tests: pi_stress: fix testing threads' smp
 affinity
Thread-Index: AQHXIiM8CI5/gVWxU0eUxagcYXlpjqrXzlAggACh5QCAALHWcA==
Date:   Sat, 8 May 2021 02:48:56 +0000
Message-ID: <AS8PR04MB81824EE9152FFBEABDCCF2398A569@AS8PR04MB8182.eurprd04.prod.outlook.com>
References: <20210326094404.18110-1-Jiafei.Pan@nxp.com>
 <AS8PR04MB81825DF5E1C40EEED0C2DC2C8A579@AS8PR04MB8182.eurprd04.prod.outlook.com>
 <bc53c555-a9ea-d9b5-e756-959e4f46990@redhat.com>
In-Reply-To: <bc53c555-a9ea-d9b5-e756-959e4f46990@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b223815-0e04-4fc6-d659-08d911cbd2bd
x-ms-traffictypediagnostic: AM6PR04MB6165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB61651B5136112144EC1CA1098A569@AM6PR04MB6165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9UhLDE/Uo7F76JP2eYkA5T9lWd6ZUxHG1N6dEUHRaIVdN78QY/Hjv/vwQNJt0IICt4cHDWKuo8YfcGIB6GPiouNbeOlVeQZPsOi4N+cS3TPnYeQ19j40R3H9oySSDw9v6s98IqBZrhF0yPBS/606a4IWEZus0Os6L2qvkyHgAmj/1t/Wl1ogv2O2WgKG89AxwSHrUGD0WJb++NS728RCbpUtky+xfxGkd7GujdgLhwj59R/kLzSiC8AtFurzgrK2jpl377s6OtUV+QXx9hnwif6pMi+z0Ysfcaz0AIIAGfxy/zuk/LOIwKgxkq0F46Yu6yiHIj2wwILBOrpT9UB3OiE16m1RzDohuU23vM38cV52MKi0r9kTB3I+t1FUE5uNF8dHZiHDAE+lykejVjF2nnLJSvpB6UiI+tkCiPYbMkus3dJwPY9sJHqJ2OvSZ4R035RluzXTe8pLNyxjlfKKeqanV67/G1C/vWRNLKRv9k3UeUoW/7pJC+IV9yXargDI3gBwANjB8iVcI7t06LBe8XZ1LiQ9+iIiMmTGmYASqKj8I5036avvzN85/Drh4dwOB710mN3zzqR5kyjVlykCL9kVi7WZwqvlRuMKCm59+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8182.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(83380400001)(2906002)(7696005)(4326008)(76116006)(186003)(66946007)(5660300002)(86362001)(316002)(55016002)(8936002)(66556008)(64756008)(9686003)(66476007)(66446008)(33656002)(6506007)(26005)(8676002)(38100700002)(71200400001)(122000001)(478600001)(6916009)(53546011)(44832011)(52536014)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2mb+HmGH0bsSEGyWVrINSRlXfUW1ouwU1DNflVNovhTzxpu1veF2cE63/Nmx?=
 =?us-ascii?Q?MtXYzNgDkt1utGQ68fgHwYIYv587pu0TGkKr3Hle2VfuTLHd/wl0Jcvkjq88?=
 =?us-ascii?Q?gxXUzGb0RIp8fgmX81M+4u5X0AFZxp+hwaT2M1nX7e50VpanF29YaHpfqYaO?=
 =?us-ascii?Q?XfFIxdlhZyVDqaKjYeqvJ+TXfXK6XhN94OUfbB/S2y31KWtVnw+tGiHiA/pz?=
 =?us-ascii?Q?CKNeJyg2s7wqbejmz+RbZUT2pYKif9IxYNKBI2rA3/wj7Og3VNudrGJWtPNt?=
 =?us-ascii?Q?FwRcYvs6PNNvwuPhtjm3q3C3+w3kxACz7/HQd4xWf9NIoMNANzSA2nCwsGic?=
 =?us-ascii?Q?Li6BWU+XW/mWfi1KYQGTBKS5ruyPqhh+6BozWJ7hq7cDt8M4QQOYv4Oq5JvX?=
 =?us-ascii?Q?7lftAP9+/CIMmLUBQvP54t/j/TDvTq+zZzNjv1OnEPyzdKai6AC1IBOOjfud?=
 =?us-ascii?Q?1XbeybV8O49J3oO8f/AjB6o8VzStFLpRbte2TeCpEOMnnLuGgDY0RyWYffNS?=
 =?us-ascii?Q?AI2gNPKr1Bng8QMQ+VXzv7zqoXAirRohtzmylIdu4Mko+tL6eqoMlDJI0AUl?=
 =?us-ascii?Q?LQw3r372sqPIf7wL+DSo/wuFfIQZBgS0bbFQC2V9twkv8M9eigNvAqcTAguS?=
 =?us-ascii?Q?Blfp/miYklGGzfdvm3MtFyzpjd/RfJmD6b7xreiPTkzLAMgKHg8EGKnjI0Tn?=
 =?us-ascii?Q?xHR7JoFYi1LE1bQnATy/mOOKCUYkQwyhdCPggAPerT+SqPDQKiiJYjbnUD7A?=
 =?us-ascii?Q?/+UuVoOkIhLIz+8lCbLFcpZby9g8BDJedodKSRzxfYaavynwQ102bJaGrhQc?=
 =?us-ascii?Q?GLzW4k/iuc7hEYSxZ8HRoplbLvBe/iHQpbi47HxOWdJee0NhB7NOBYt2oscY?=
 =?us-ascii?Q?VTAv+FpMYqi5ezJUOnXrCMFYlk3TOBvqjZgtXCFMfw7A2kjIgLo4VQXRvDQP?=
 =?us-ascii?Q?G0fgh6Tm1iYQARWGnxlT2k1zlJGa+AcpPOPXdNpPGXnokRCH79kgd2u4hkvK?=
 =?us-ascii?Q?SPJl9IYg9gdKICsTh6KTjg3qflfpbZ/wBzV222U2mh7y3CIrBaNvTiM1h2Vj?=
 =?us-ascii?Q?Sttt8ly2knZ5diXJVCMEAw9BuaYsl/vhargmoSdPNze7BQngnE8q6OBzqjML?=
 =?us-ascii?Q?ZqkBeWryqJPBEk7FGuVNWLJqrFUGUMFwHufC4Cjnbe0y8oBX3xjnWjoYYfyY?=
 =?us-ascii?Q?Tt1gAT0M/2AKpGtcTFqI7H77W/BordXuDkT8jgyLZ5higBdY++e/jnhd2tEa?=
 =?us-ascii?Q?GzCemlEO1Zlf3LZd5YHv7+ZqxVTFWt6jiLpw0K9I9rEBIQ3s29sQrBt05D+x?=
 =?us-ascii?Q?maAFgE/3rqkSasQ1oLU6BDUh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8182.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b223815-0e04-4fc6-d659-08d911cbd2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 02:48:56.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlrjUA09C+ShzxP3q8Y3YQaviCI7Oau0yUyCh8tVtFLsPaG9v0KJaKjnkkHEcrgpwY+mSL9FXDRbn1hGeOTxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


> -----Original Message-----
> From: John Kacur <jkacur@gmail.com> On Behalf Of John Kacur
> Sent: Saturday, May 8, 2021 12:02 AM
> To: Jiafei Pan <jiafei.pan@nxp.com>
> Cc: williams@redhat.com; linux-rt-users@vger.kernel.org
> Subject: [EXT] RE: [PATCH] rt-tests: pi_stress: fix testing threads' smp =
affinity
>=20
> Caution: EXT Email
>=20
> On Fri, 7 May 2021, Jiafei Pan wrote:
>=20
> > Any comments? thanks.
> >
> > Best Regards,
> > Jiafei.
> >
> > > -----Original Message-----
> > > From: Jiafei Pan <jiafei.pan@nxp.com>
> > > Sent: Friday, March 26, 2021 5:44 PM
> > > To: williams@redhat.com; jkacur@redhat.com
> > > Cc: linux-rt-users@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>;
> > > Jiafei Pan <jiafei.pan@nxp.com>
> > > Subject: [PATCH] rt-tests: pi_stress: fix testing threads' smp
> > > affinity
> > >
> > > This patch includes the following modification:
> > > 1. Make sure test threads and admin threads don't run on the same CPU
> > >    Core if uniprocessor is not set or not on single Core platform to
> > >    avoid starve admin threads.
>=20
> Doesn't the code already do this? The one exception I can think of is you=
 are
> allowed one group of threads per online processor, so if you have the
> maximum number of groups, then one of those groups will run on the same
> processor as the admin thread. Even in this case though, the admin_thread
> has the highest realtime priority.

Yes, you are right, but I am not sure why system hangs while running pi_str=
ess
with 2 groups on 2 CPU Cores platform, but it has no hang issue only run 1 =
group
on the same platform. Will dig more.

Thanks,
Jiafei.

>=20
> > > 2. Force to use SCHED_RR if more than one Groups running one a CPU
> > >    Core to avoid test failure because threads in different Groups
> > >    are using the same priority, SCHED_FIFO which is default policy
> > >    and it maybe trigger deadlock of testing threads.
>=20
> Like a lot of things in realtime, we give you enough rope to hang yoursel=
f. We
> are trying to create a tool here that purposely triggers deadlocks that a=
re
> resolved via priority inheritence in order to test priority inheritence, =
we're not
> trying to create a robust application that has safeguards to avoid this s=
ituation.
> So, with that in mind, why would we force the teste to use SCHED_RR if th=
e
> user wants SCHED_FF ?
>=20
> Trying to understand what you are trying to accomplish here. Is it that y=
ou
> want to get rid of the limitation of only allowing one inversion group pe=
r
> processor? If so, why is this useful?
>=20
> Thanks
>=20
> John

I want to limit only one group per process, not sure whether there is some
Issue or not when run two or more groups on the same process because
They have the same priorities for each group.

Thanks.
Jiafei.

>=20
> > >
> > > Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> > > ---
> > >  src/pi_tests/pi_stress.c | 23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> > > index
> > > 49f89b7..8795908 100644
> > > --- a/src/pi_tests/pi_stress.c
> > > +++ b/src/pi_tests/pi_stress.c
> > > @@ -237,6 +237,13 @@ int main(int argc, char **argv)
> > >     /* process command line arguments */
> > >     process_command_line(argc, argv);
> > >
> > > +   if (ngroups > (num_processors - 1)) {
> > > +           printf("Warning: One Core will used for administor
> > > + thread, the other
> > > CPU Core will run test thread,\n");
> > > +           printf("\t it will running more than one Group on one
> > > + Core (groups >
> > > num_of_processors -1),\n");
> > > +           printf("\t it will force to use SCHED_RR, or change
> > > + groups number to
> > > be lower than %ld \n", num_processors);
> > > +           policy =3D SCHED_RR;
> > > +   }
> > > +
> > >     /* set default sched attributes */
> > >     setup_sched_config(policy);
> > >
> > > @@ -285,9 +292,17 @@ int main(int argc, char **argv)
> > >                     break;
> > >     for (i =3D 0; i < ngroups; i++) {
> > >             groups[i].id =3D i;
> > > -           groups[i].cpu =3D core++;
> > > -           if (core >=3D num_processors)
> > > -                   core =3D 0;
> > > +           if (num_processors =3D=3D 1 || uniprocessor) {
> > > +                   groups[i].cpu =3D 0;
> > > +           } else {
> > > +                   groups[i].cpu =3D core;
> > > +                   /* Find next non-admin Core */
> > > +                   do {
> > > +                           core++;
> > > +                           if (core >=3D num_processors)
> > > +                                   core =3D 0;
> > > +                   } while (CPU_ISSET(core, &admin_cpu_mask));
> > > +           }
> > >             if (create_group(&groups[i]) !=3D SUCCESS)
> > >                     return FAILURE;
> > >     }
> > > @@ -1143,7 +1158,7 @@ int create_group(struct group_parameters
> *group)
> > >     CPU_ZERO(&mask);
> > >     CPU_SET(group->cpu, &mask);
> > >
> > > -   pi_debug("group %d bound to cpu %ld\n", group->id, group->cpu);
> > > +   printf("group %d bound to cpu %ld\n", group->id, group->cpu);
> > >
> > >     /* start the low priority thread */
> > >     pi_debug("creating low priority thread\n");
> > > --
> > > 2.17.1
> >
> >
