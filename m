Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45B4404;
	Tue, 17 Oct 2023 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="EUbaHPXy"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CAA1;
	Mon, 16 Oct 2023 19:23:26 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39H1qFgd002691;
	Tue, 17 Oct 2023 02:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=q7mUWYo4QXLD7MMqnawGC2u9rO6b+Zeae7W0uV19Rsk=; b=
	EUbaHPXyhHjaKdZNAGV3lR+H/xReMbvlKRUipyLwYb84wp7UgkwLROG4V3kj/5nG
	6Cq0KyAfMjVg2qakxFFHQXnZb2J6VaQhaNkUlfqOK+VBwsmdyfqMLL2PhGgtYMR+
	PvuzoOD9dyO4VVS7Rav+1P6L/MYGfGpxwuXgKJObHVZFSHrDRU7MAaBk/odlFOb9
	8E5X1vX7lA9eJcs7KIeyO+EZcJNqXWoFikzZTnylurMCjkliVNHX/mDUIq9Vw+CK
	xSxOt0hGhq0pvtiYSd0KeQYkNzoTYH52GVopKcabLSYQgTV8sH1KuUKM3LvPsHH2
	RSBaSLaw7xnWKsN1+IT5zg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqg6xajf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 02:23:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciAalzOqG+AB1+F063QdhtvyKt/kPocDhT3tKBZgzMtxfE+kvQvow3X8f30p/tys9E7HMW6oR37eNYdozaqFV+N1yrExLYOZDnzc3BtzHvkmhHX/gTLwcXsbtJR2Wsh93rOWHUWD5iSZstn4t+A0K+uJHqe5NYMh0PpPVO628HB2ZXh2FVsfPXyweKnVpiL7irElbOpV+krMPm148F5mHQn9pJjt2PVcb8nsn3Ecob2l5SeKAkBIq9k7/eRYyx7mNPGu+bz7U6vkDWT9eIq1SFg4mw+KEo7cx6HWp1snYMJ4vzfXKkHDTuVdUp8y+gkdMEBjxwUJ0K+NNZX02Wl5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7mUWYo4QXLD7MMqnawGC2u9rO6b+Zeae7W0uV19Rsk=;
 b=UdBLKi1j3yrQ7COEa82Y8o3F2lFsje1doNPG0brBepbwNZPlH2mNOa3ZbIVp+MiTPHPXTj5ITCp9ABHMfTbvL9pxGsbNUaGJi7ccUo+//G8On5PNylsZUdGV0uqa8/4AxWX28e1g1g0SIg3eMKrCLLUp1HFo2bCIsFABDda6dqOn7z4nnwRzInb/KAugo+m7NK4QTIeYoUTCKJHxNXjyC67hU2RwYer2J8hQ1beW+SBqKjNSEdB8eFNCTIjfSMKvi1Jzw2ac1DmBJE9Rku/WNptJhm8M7ScWFgjEMgQcCgblDiI8qK8VkDYBmSC78hBkll4Gre6WDPmtc75H8EU1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BL1PR11MB5221.namprd11.prod.outlook.com (2603:10b6:208:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 02:23:05 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df%7]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 02:23:05 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>,
        USB mailing list
	<linux-usb@vger.kernel.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: RE: USB: add check to detect host controller hardware removal
Thread-Topic: USB: add check to detect host controller hardware removal
Thread-Index: Adn9i9LFJguVckBOQnaI1KZe5N8FAAAbV+4AAJYf4gAABSReAAAOS6qw
Date: Tue, 17 Oct 2023 02:23:05 +0000
Message-ID: 
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: 
 <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
In-Reply-To: <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: 33065244-b49d-42d1-fc4f-08dbceb7ff06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LUevcWd8zDl/RBtSo+gTpGOKrj4tHmINjUDJARaplFkCBG15r6L8ZnRYAfxCWozuSFlpU6gBiOa/EPx7JejF/s98vdbmXVnEzOGPwgZmDxfW6zt21BLz37I8Fn7EB2YYejlPX7b7phn7wakZIcD8d2Ze0mAYmzro2+FwarackEHMCAHn5nT+1lONIKoXuhxBAFiuzbZ77FCRJHtjbjSJ6FSOCE2O+YPsSbqkaVT2Lf3lv2pTzmCu7IDREhiqr1ZG2t7NmWBZIZhhha1LfhpGeMQRsg7CrbNcSfUAHRa1sTaau6G6YGbGlWGXS2/hkaSm1hyoR2hcN0jCyAD6dJ0A/458ob/1ShDaaGNfQ9AvNzYiV6QZAOH10Ah2pTfiIm9sfuOFgHKEpY/7LtOIXRhyy09tt+v+nFaBwdMSkVTTl4DYpvhuJgzcWGVjuLiHbGMboUwJNAdLnA5evZaugUq+mMdC0Wz2P9G8F1IJE5x6jJeDOkMvqFnApYdN4wiRhqWzwisf4srApLk1ncHqJg+1wmQEnhy4sG5HXPA4dVtoaoXNHw27J1AcxzpsH5JNTor8yoeUALflvjHmSUDDyln6K9JW883r9dUBuZp8i5QxX6beqOxSmr1K+sI0JnSR/w96
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(55016003)(66476007)(478600001)(110136005)(76116006)(66556008)(66946007)(66446008)(64756008)(54906003)(71200400001)(83380400001)(38100700002)(9686003)(316002)(26005)(7696005)(53546011)(6506007)(33656002)(41300700001)(5660300002)(86362001)(38070700005)(122000001)(8936002)(8676002)(4326008)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WuktMY/9WONFK4DgyE7H2riHFCF+9hFwAt1lYcbpvqOSYG1KCNPZd5OApDeP?=
 =?us-ascii?Q?Npxq8Xi/10d+H9nuhZBl86gCDj/IRakUYX9zgs1UCcHY5lQ8nN2TyMaVMzrD?=
 =?us-ascii?Q?EhgsORxNWP9apYn/JrYQ6cClsU0bKMhvqxr97Nko4at2fIV9/aJDmvJtAyhN?=
 =?us-ascii?Q?0yrO6RW8/3WVuEPtiKvoROcwddwYYzeHA2NIdB2AdCKckmVRd+kkiyWHUrIG?=
 =?us-ascii?Q?+lPb6OEe7jDnmSX0r95Jt15b33IMfKZzmNc7GUJv5ZSKEwta2QfjQD2EHBxz?=
 =?us-ascii?Q?jrFDN+vzvcryUC2P/Rv0FjtEscF6ZkN6NWF842u8tN968vnqcTgWET32qfMF?=
 =?us-ascii?Q?YkHPu393KcXzaDNwaC/NUUX00JnrpxjtsCIqAY7HXa2OT51PjuDieyAXvVOX?=
 =?us-ascii?Q?0uZO0leI+BbJkRu78HLf4FjDwD+IPv8TUHxC5MGyM6/LTaO4aojyMO3iiI8d?=
 =?us-ascii?Q?UD0N3KfinDFsTbYZr+z/j064bq0mNad7kxrXVQBJdIKCZa3DI5NvqTgvgqQL?=
 =?us-ascii?Q?vzg0qXEC4bShNGlda/iDrMzBZy3wzLysgdhHHfFStMAAnpMyFyg8Zy3ZOuwG?=
 =?us-ascii?Q?IfyO0j4nF8ayMRIZ1tPs1LB3NPlVeVv3PrS7VmuNQiWXcyGh++2MTE17KEw5?=
 =?us-ascii?Q?CaWHfjX8yTCHstb5v+6qJ/l8jtbmH7OTv6vysPJpV4/MhDpwxP84tDP+h6Po?=
 =?us-ascii?Q?PFzMk0cdsE2SvJdjqlsOVf9LkTNfZIR5E7rKu7AUckeJUQtA8dQdI5Igz6ig?=
 =?us-ascii?Q?/4zIn9SKuO3FAsZdwnkr31gdDXEQUnaiIM84howYGueTw4UzgpuI3EZOIozz?=
 =?us-ascii?Q?fEHoTUNfG5QkVxOp5E3z8+MHD6Cjv/jc+Id1Pw4h4yXuUaii8jmvx/LWMoib?=
 =?us-ascii?Q?AdmONdw48hCkPGlvSeX9oZZXkokkUewUCyXl0jXI9ELJx+GmGiOo2cS619Je?=
 =?us-ascii?Q?76oWQJhrnKGrD2SSVhb6Q3WK06btCoxcmU/RzCMXp/B/acsREyk205t5KR+H?=
 =?us-ascii?Q?RhH0evSxUciFqgCL6eMgeJqXkkko7EOdBJjtLMXj4hrTjAWCjSQI8wL5E2YD?=
 =?us-ascii?Q?FqIaXYWE3mVX1RWjO5nodR/zcTrA0DyghbvB3IrK+mIEvyI2vS0IOoJ3a2Xw?=
 =?us-ascii?Q?m+dx6olvG1gZ/0GAMPhLe2d9iOWu9vSTwMOY5EQlE12L5/MWtA5Jb+7ybDzD?=
 =?us-ascii?Q?G8i86Z3dmvSkQ0urr6p3M75ArZYieZ+WyryAMWigiAU7IF5VOlk2gDfD00CR?=
 =?us-ascii?Q?aTn2itLwPlfjo5WaSxACOS3+0BTDJhCUKQbrDXGX6IHB3zDjYHSTIrggCVsX?=
 =?us-ascii?Q?1+M4nroBNisWD6YhCRgths2XVfHPwmco4HmCy4pU4GSu9Ui9LCuFLAM2kuGx?=
 =?us-ascii?Q?pOvL7TT7hMVqVZXphsIgS0P9ryRnAWvLm3D+1stWUrFcc/5CwRTID0NVYyeu?=
 =?us-ascii?Q?37OovTPvhmwWG6YhEMT8o+l8SSvZ9Lu62KFkuxXtebDkcKMTDgsxPq13VJkT?=
 =?us-ascii?Q?9URYVi3vDdkWozdRSUh/4IUFPGVK6vlDhkD3tuxI38AODrKXLXIfEg2yPYTj?=
 =?us-ascii?Q?X/0xxwli8aw3I+5EPO+rYFZ3IVVetB5uszj51W0v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33065244-b49d-42d1-fc4f-08dbceb7ff06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 02:23:05.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUtjEbwSmVnQ8C1D5JXJoU15vaYN+Xa4sZ6q0gkEMMVTXlxbuC2J9awtZeNLXUSnadhYLevIg8avYGRa57X1Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-Proofpoint-GUID: kX6m3FqhlPQV_Uim-bTAgKZxzrkI1FqV
X-Proofpoint-ORIG-GUID: kX6m3FqhlPQV_Uim-bTAgKZxzrkI1FqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310170019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Tuesday, October 17, 2023 3:24 AM
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Li, Meng <Meng.Li@windriver.com>; Ingo Molnar <mingo@redhat.com>;
> USB mailing list <linux-usb@vger.kernel.org>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>; linux-rt-users <linux-rt-users@vger.kernel.org>
> Subject: Re: USB: add check to detect host controller hardware removal
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Mon, Oct 16, 2023 at 12:56:24PM -0400, Steven Rostedt wrote:
> > On Fri, 13 Oct 2023 13:17:52 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > --- a/drivers/usb/core/hcd-pci.c
> > > +++ b/drivers/usb/core/hcd-pci.c
> > > @@ -292,6 +292,14 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
> > >         if (!hcd)
> > >                 return;
> > >
> > > +       /* Fake an interrupt request in order to give the driver a ch=
ance
> > > +        * to test whether the controller hardware has been removed (=
e.g.,
> > > +        * cardbus physical eject).
> > > +        */
> > > +       local_irq_disable();
> > > +       usb_hcd_irq(0, hcd);
> > > +       local_irq_enable();
> > > +
> > >         usb_remove_hcd(hcd);
> > >         if (hcd->driver->flags & HCD_MEMORY) {
> > >                 iounmap(hcd->regs);
> > >
> > > The local_irq_disable() is there so that the irq handler will be
> > > invoked in the state that it expects (i.e., with interrupts disabled)=
.
> > > Apparently Meng's RT kernel doesn't like it when the handler then
> > > calls spin_lock(); I don't know why.
> >
> > Because in RT, spin_lock()s are actually mutexes.
> >
> > In RT, interrupt handlers do not even run with interrupts disabled
> > (they run as threads), so the assumption that they run with interrupts
> > disabled on RT is incorrect. One hack would simply be:
> >
> >       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >               local_irq_disable();
> >       usb_hcd_irq(0, hcd);
> >       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >               local_irq_enable();
> >
> > But that's rather ugly. We use to have that as a wrapper of just:
> >
> >       local_irq_disable_nort();
> >
> > but I don't know if we removed that or not.
> >
> > Sebastian?
>=20
> Thanks for the information.  I guess a simple approach would be to add th=
e
> wrapper back in, since it's not present in the current kernel.
>

I did some debugs on my side.
Firstly, the local_irq_disable_nort() function had been removed from latest=
 RT kernel.
Second, because of creating xhci-pci.c, the commit c548795abe0d("USB: add c=
heck to detect host controller hardware removal") is no longer useful.
Because the function usb_remove_hcd() is invoked from xhci_pci_remove() of =
file xhci-pci.c in advance.
I am trying to fix this issue with getting register status directly without=
 local_irq_disable().=20

Thanks,
Limeng=20

=20
> Alan Stern
