Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4917F0;
	Mon,  6 Nov 2023 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="b8l0Qa9p"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF00FB;
	Sun,  5 Nov 2023 19:03:04 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A61VPVJ008264;
	Sun, 5 Nov 2023 19:02:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=q7tO7PU/saZ4OfB3hMvTb2s03yxO8Re/Rur1ItaXTxM=; b=
	b8l0Qa9p+TuYhu+wHmPwO9Edx0VbOXVLTUdJVgYW8eTb+tuqgE+dR2xN+p6fIEVg
	K3TqpkU9m0iEjSGdpubyyOdruj2CfcvxvE7sRBeSmxap8RPVfvozTipVbQoj4Jja
	bM/5hhwyfk9fzMH6M6ZqvCGWm1lOtWo9kn9XcHjFV0KBDgypQZYhkFbs0Y5jLZ5E
	57qMoo6LxjYuwY2KVViBquQVgGkSGr8xuVXOpABY2gA86FOolHIbparVudH8HZLC
	OCdBQpi/fKFX9J6KwJ7Z+8kDCOgo+GLGBomIl25uMPffYCc4QY6Wge1ps7avMBJB
	N7OEB6UgCKShHXYJiXAr4A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u5h8092st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Nov 2023 19:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGxhJ4wZsgJMnQgnZkY9l1YpNjaRl27lA9tmFNoUeofJAQ0UH2QJMfVWcp1eF4z6MIAVFUy+A0VqJJooiEB7VdF4gQANfmeXmwEbFu8SSvZRdQl8Pxa3tfRcOuXelUV0WQ4W+akmXlD9TE/iL3Oe/eULgEDaWvpSYyGaxGvJQLdLkp3XuZFEKmQM9QYup1cSwNKvY6tVtDZfXo5JAWRGW7KjocFF5BISdJkxeHpb4rmu8aQDryEIPFlFfXmzhBMmEVl0eMgIH82zjdc4auz6C1hqQz4VtZQl4mitM9xO9cZzLcw5spx2AVPqAucCtekBvmRwIjLSKQ58/a0HYTpE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7tO7PU/saZ4OfB3hMvTb2s03yxO8Re/Rur1ItaXTxM=;
 b=LhTriVaEy8G8Kxjxqz9TH6eL1ZOGVwfUsuSVqtfqgRYO8M575e7Y4yLpWQURMpSW5Q286UPICzp3osY4Uv1ibe7wntBndslLAghT2jBcmjI6tHr33lZAEb2LnXRamg2k+CjmtZs8u08BVvZnN0sVS7WUCbpcElq5fy1mN08Mn91uDIpsAs4+e6LE9QvLiaAcco4xZkHcNFHrmvlKEtHzJLruqIxoLkUPnOdekIAU1j04YJ/JOkZEb/4VCcDDiMoEhx16mqo5WdhNGUEkamDBdUi5gRw94WMJNrwWh38IizviaD9hSsBY5PHPtxAVnXfVp4YoevUXwoRlg6OzFpMSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 03:02:43 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::41c:9808:690:f88f%5]) with mapi id 15.20.6954.025; Mon, 6 Nov 2023
 03:02:43 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Alan Stern <stern@rowland.harvard.edu>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        USB
 mailing list <linux-usb@vger.kernel.org>,
        linux-rt-users
	<linux-rt-users@vger.kernel.org>
Subject: RE: USB: add check to detect host controller hardware removal
Thread-Topic: USB: add check to detect host controller hardware removal
Thread-Index: 
 Adn9i9LFJguVckBOQnaI1KZe5N8FAAAbV+4AAJYf4gAABSReAAAOS6qwABjp6YAAHiq+0AAWuX8AACyeyIAABUsdgAAAoHwAACaVFgAAC20/gALBAh8AAApVjQAAcXa+cA==
Date: Mon, 6 Nov 2023 03:02:42 +0000
Message-ID: 
 <PH0PR11MB5191B5D71DBD450210E2BEDFF1AAA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: 
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
 <20231020095238.Z4m-M_oS@linutronix.de>
 <1f26049d-b16d-4db8-8b7a-ed93213faf76@rowland.harvard.edu>
 <20231103154624.WEWPMHTp@linutronix.de>
 <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
In-Reply-To: <a0116b73-2017-4f3b-a081-6d420b04b7d0@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SN7PR11MB6849:EE_
x-ms-office365-filtering-correlation-id: 74796ce0-5504-4e9a-7b84-08dbde74d84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jJeCe9cbnODQYxdvCiOBMGKGI1LkPyyIoawiel+wrty9+MniVHx4F/iITJo5+ImRMh9SsYUPokXBX2Lc7Xhbj6FGFS/2IYzGgu7bqs1ohhvPCZBiReo8YAuONCzpu+thqlxuUiQvv0n0ALSTTXBmb6naUCHelyYLHBGrdLcK+IvndmLQlQCa0JGMjSPj3ET8a4H/BrLKEBwRQNbojUrzb03Wzhh+xbTzpwgo5dsaIpvAOXQzG8MlxvdK1ksZIsRk6qvQmNbyOSGMsJrD8BEBizv8Sd4KvlivmcgwlNWBrwq3B8ai50M0P4zOBpLKoeasvYCXa8hd+ODYOZCi/j9uO1fo2S1yD8t8wT7hwaxNFojL1sdFmLW+vH271c6sm+1KHfsmVLcG9Xl/LPkNub3iN2y3thCez7rX+RiZhpLw8qpyiEzItWHv13QRERjrGEp/6NLB7kdtszqYkcBRFpMR/2l2cgfoPeDZQMN1gQ2uFRTJYuaBPZxrjeOo71l8PG68LZLoofxIRYK/ScLVFcGlOmpmJHhXJa5jvrYfdRyle+qWXSQGj9lUNL4PTxAqHuJhuXCtiwqI9zQh1n+U7tC0en9oLmHM0JVKNX81dLR2ssLfTnymVTNyXxE6FCDPZUsbNwoyQ7NZbocg9PH36/0FcMEKwJPIOY6nXcikZc1F3Co=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39840400004)(376002)(396003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(55016003)(66556008)(64756008)(66446008)(54906003)(76116006)(66476007)(66946007)(316002)(86362001)(38100700002)(33656002)(122000001)(110136005)(9686003)(83380400001)(2906002)(4001150100001)(7696005)(53546011)(71200400001)(6506007)(5660300002)(41300700001)(478600001)(8936002)(52536014)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SdSLk2/XfaGuSql4cvrT4eoAGeIjwKSH+1mEYcCgLh+OL29jRYinHRMZpxVx?=
 =?us-ascii?Q?1gOHhpcsJAATT041DJl/Xv9LuPvhUtrdyqumtRl6nmi42Vc/SMaIfAfKq+Nx?=
 =?us-ascii?Q?4LB0AjbHWcYjZh4zYA99bLJDGGbldlX6Iehwtw0mHd7n+OfbGfjUqkhZVmsL?=
 =?us-ascii?Q?DdG50HTHOZNoyFLVRkOSZFdbDWD9DNXHDjZzgnGyx7oJWyHWXI/d0TFEOG7d?=
 =?us-ascii?Q?aZBhSXsS0Ix3atqaA3T77tBqHoR3QlePOQ84SRUdORR9pyOp/ZQ0UysL2RlH?=
 =?us-ascii?Q?rwGizFstHeuQrsuMHnqzdLd2G1sRypxmgRZR2FIqUxFYuAmLfYrQ0oTKQmB+?=
 =?us-ascii?Q?eqpbwRoCONkCutBwWDARiBKceJ8yiECb4ZKfKnnjV2O5wMi8FgdBtoIL/ckt?=
 =?us-ascii?Q?W+awVvIqSZcg1nBDujnrnPynrk6Hrt+xLZHPcBQ0FBBRBHt+9k9t3cnb2n9+?=
 =?us-ascii?Q?Vvae/zsUe5bRhdqU3MtkDxdbnMsB+uS/gPAh1whKjRDRZEhGco2lhTUFstWs?=
 =?us-ascii?Q?Le0wn6RTbCgrvyXQf4yL/3V9lSIUWxK8AuO1X3LGMfdMMUvxooVbnXCrrsi4?=
 =?us-ascii?Q?tGdU/q9AN8Ur+ZZZYUj5rEHcB9v0cesEw7DtV5hmnId00aksMa4DMYRszfNX?=
 =?us-ascii?Q?6n/IpSdXqBFoBidpebQ5zmC7jjekLvcbhBXJUwRyFCPg76RojylStbfDzhE1?=
 =?us-ascii?Q?pJHRn5CJJbGOnlbjZz66ZFZ368/lM9mb9PjWtJmyJ1VEHXWvTVExCPlmQ/mc?=
 =?us-ascii?Q?5ecX8xkim6NlGp8yXD0Z78eF/EGiU89Pl3blNLYfY8C9yqtWzp3e3bxHF4Qf?=
 =?us-ascii?Q?ZWKCKFIQi+h4tTztT6tJyekit53TYZxVxOdsO6hezkhfXqv2foikly4VTDLi?=
 =?us-ascii?Q?kB5J223cVFPwMPwGqZbKmmozNBYISHorfjZ0LtlE4lvuLQAewHFx0YjBhKhc?=
 =?us-ascii?Q?e8wspRJ+dYx2pYqi5wHmYhQhvCePGYwOzhF7w9TawXQQjYgp3GCaEEdjreNr?=
 =?us-ascii?Q?Mdtz7duanGc9tH3vSdEhtU6FE/lUP+lXX3H+fMYvFIE0B7YLTuGLWhvZ4CCj?=
 =?us-ascii?Q?mmGVcz1bOjZTl9kTA48BkDdDKo2Wh5rbSqoEKCHIkOaIk4KBV2hzOwQ7rOHX?=
 =?us-ascii?Q?MHRDKnM7LXaqqn7r68i1ezCLhanQjv0Kws4qPwRr4n5sLbxRxQgTU4jmCww2?=
 =?us-ascii?Q?oxeR/oEHSmD89wGumWEEOAJWcKgcS/mEJuncB3c+2imAMzSRIcpZeq1KSCG2?=
 =?us-ascii?Q?vWjwLQ5M75vL5XGaw4PkO88VC3mwenPv+NgEiLLIDzKHonTrchSYj44zi6cc?=
 =?us-ascii?Q?CIEkh5hxpf45Pc/XR5QHALbOg02W8ZW0ngltyiOcue3Wp4S6FtiI+jl9hsAl?=
 =?us-ascii?Q?jX0nNUZHj/MFTtaYhNaUuA0Q3JCc779WS+Vm0wwIZt6Kj+MJpW5BfHDcuq99?=
 =?us-ascii?Q?PdmutiXLPm6XOQEy4Nw+EW7BGN5Q6kp45Lx3+hz9niZmOu9se9S529wLBj5o?=
 =?us-ascii?Q?pL3j5kYa4avEbvjwbWocqJPw/OQfJgMaPYJqN8XjNLmNfYUSm3NE+3GxHLHr?=
 =?us-ascii?Q?PWWbKtwPPySiNcNxkuU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74796ce0-5504-4e9a-7b84-08dbde74d84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 03:02:42.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLPtG/QGWWe8OPXDnFFBfmY6IMBT8iX+eTvD7NORJ2ei+mMleHgkUD3BI3kDEQELp5w9jMLNkmUW4uD2visPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-Proofpoint-ORIG-GUID: O7hsgCGeYG8PgMUFfnFORX2KISBmWIty
X-Proofpoint-GUID: O7hsgCGeYG8PgMUFfnFORX2KISBmWIty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_21,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=729 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311060024



> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Saturday, November 4, 2023 4:42 AM
> To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Li, Meng <Meng.Li@windriver.com>; Steven Rostedt
> <rostedt@goodmis.org>; Ingo Molnar <mingo@redhat.com>; USB mailing list
> <linux-usb@vger.kernel.org>; linux-rt-users <linux-rt-users@vger.kernel.o=
rg>
> Subject: Re: USB: add check to detect host controller hardware removal
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Fri, Nov 03, 2023 at 04:46:24PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2023-10-20 11:19:49 [-0400], Alan Stern wrote:
> > > Hmmm...  This turns out not to be as easy as one might think.
> > >
> > > Sebastian, if you can instead suggest a way to call drivers'
> > > interrupt handlers (i.e., simulate an interrupt) without causing
> > > problems for RT kernels, I think that would be a better approach.
> >
> > So there is generic_handle_irq_safe(). It should get all the details
> > right like incrementing the counter in /proc/interrupts, doing nothing
> > if the interrupt has been masked or waking the interrupt thread if the
> > interrupt has happen to be threaded.
> > It triggers the interrupt so for a shared handler it will invoke _all_
> > registered interrupt handler and for threaded interrupts it will
> > return before the thread had a chance to run (free_irq() will handle
> > it properly and wait for the interrupt thread/handler to complete).
>=20
> Good.  Meng Li, can you test a patch that replaces the
> local_irq_disable() - usb_hcd_irq() - local_irq_enable() lines with a sin=
gle call to
> generic_handle_irq_safe()?

It needs an irq number as parameter, what I should pass to this function, 0=
 or dev->irq or other value?

Thanks,
Limeng

>=20
> > > The fundamental problem here is that the uhci-hcd driver was not
> > > written with unexpected hardware removal in mind.  It doesn't have
> > > timeouts to handle situations where the device doesn't generate an
> > > IRQ to indicate completion of an I/O operation.  And since it's been
> > > ten years since I've done any significant work on the driver, I'd
> > > really like to avoid the need for such a far-reaching change (not
> > > least because I don't have any way to test it).
> >
> > I see. Don't over complicate or "correct" things here. What should
> > work is that the removal callback can be called at any time and things
> > continue work. That means it will purge all queues, cancel all
> > requests, timers, whatever and free all resources associated with the
> > driver/ device.
>=20
> The driver _does_ work under those circumstances -- provided the hardware=
 is
> still present and accessible.
>=20
> > If it comes to PCI-hotplug you have to have a so called PCI-hotplug
> > slot. This "slot" will let the OS know if the hardware has been
> > removed or added. If you don't have such a thing you have to maintain
> > the state yourself by using the "remove" and "rescan" sysfs files of th=
e PCI
> slot.
> >
> > I'm not aware of any requirement for a PCI-driver to check if its
> > device has been removed.
>=20
> That's the problem: The driver doesn't really support PCI-hotplug.
> The code that Meng Li wants to change was sort of a half-baked way to add
> such support.
>=20
> Alan Stern
