Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BEE7495;
	Wed, 18 Oct 2023 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Y4Bcp2As"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E9C6;
	Tue, 17 Oct 2023 22:01:20 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I4duJr005684;
	Tue, 17 Oct 2023 22:01:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=0b/EI9KJgSZc7jpYh1gz2kKE91klK+7BzdoLQ+chHTs=; b=
	Y4Bcp2As6MbnK2dfSZXY39EQog9Px9K+3J4+KbeCv5UhWAr1H7gqzN4kslVHCTv7
	R/ElrCdm8hYcwqprXBekCvfZzJ7OgKeU+Eq1KK/TqbyK/wt7OELNe+OdcK9kQU61
	XXZQ+oE+9JfmWilp90hwTriDWO8OJAdqAhxp7by2TRN6WuzS6PCuumrdUf89aOVF
	ckcBWt4dbLyAoEsaVIFCIL9a5kTA+beELBpqMlsmAeIs8XJmIEhIEp885t0H9FaG
	9hFCAWphydOH6UrrxH4MiEH9F2ae+wsaRV6VC8etoUE6jJKYvaBXoOi8OdgE3Vrl
	fCbrbXu9Em5sX6eY7GnCqw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqtgfkkdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 22:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcp9OLn8/6KYN732weT3Fh86xdAhASNMcqwLgrlRz+JC/mbsKHi1m3Sx1Fl8hbf9E3ppTwkJoIjwZVu2RqZCX5SkuI1L6U8njYu5eXy83iMfKUD7LTbm88CypErWUe/kYJubSRPoiDdatZl3KcVXKNvu5i6teKkYCA8d2Lr96U3KkWucmqCZUEYYIgdKMmfZPJXXDwYMvannUqrwrenIVso/3yHeXVQKZNXxO+rKd5Qy7hhv7aLPDb7v4Oh7UWHVJsEhleQaZrgEftw9vQHQaeWQbMkiwL1xPZ/6tocJ85sNulFpZnZQL1L0faRfNukmOifj8ebfucAZfS9E+XNf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b/EI9KJgSZc7jpYh1gz2kKE91klK+7BzdoLQ+chHTs=;
 b=HLLoiTYcKnSzp9g/LO4j6avA3oEfbsa/wGyRqHiqX1bS8hiKu6+CSUCdmECKXKRZYqDQGAXCN1RdzxD6tzoP4ohqNEW2sVYUvUeh5IO5k0lpVTBYzsNDE9iT4tWt1w8+FmWxn6iksGx0jd5cyvYDqdwd0NJ/HDqf3jEZUq6+hoy/hc+rI/AtC8maDO+JEj9YTn69AQPkIVTfV/d8W8lkguU0nYXG1khN/3vapZDg/ng4RUSTAsn0HNaG0WTgtPJd8xjpoIWroLS1+sE2s7pz375+chiuz0IpmWley/75IdRS0ZaWkLL9O90UwunkyMqdriEhMSeCxqoRTqhA+urDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 05:00:59 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::6eff:bf87:e13f:40df%7]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 05:00:58 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        USB
 mailing list <linux-usb@vger.kernel.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: RE: USB: add check to detect host controller hardware removal
Thread-Topic: USB: add check to detect host controller hardware removal
Thread-Index: 
 Adn9i9LFJguVckBOQnaI1KZe5N8FAAAbV+4AAJYf4gAABSReAAAOS6qwABjp6YAAHiq+0A==
Date: Wed, 18 Oct 2023 05:00:58 +0000
Message-ID: 
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: 
 <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
In-Reply-To: <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|DM4PR11MB7256:EE_
x-ms-office365-filtering-correlation-id: c3975d1f-5550-47ce-8c9a-08dbcf9737b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 C91DGiaS1/wHheglGLUWzohurUd6AsYzGtxWeCZEByZlW8n+xmoiO/QLDZZ8+JGnnTi0B/MkdTm3OdSnPEKfbluxD6bbKIfOZcw6DAMRdDFpO7SbtZqiuLcaTyiG03+doBWaQ6FzX1TY5xOp8m3q86PulQlL1vtFBzgF8lAn7RUvs02Eql8ufpFS1vT0kYfi7PcVNuUyvvRTiiGBmyewUDNn+gyrGqeaskQi6T3tI9vDIGSzM/8VrESFC4KEDydUIiePy/0LH8PA1/YSnATreUSG0hvGLs5OLhBSRtyYr5UzEgQz7d5SeCRrSbcZev5hwCoEgQvcPx+yPDPpOOkJzsQpsaaxwS887ZmDPJo7AwJFckNTIXcFSXVha9SerXhEr7XZQykZEIEztmfAF/AOZjHGsvg7iBXjiGCL1+AKtNe19fpabZwmKpNr4Q4tGW5XGCA+5LO0DLlqkCoSCX8SrH29bQyNodgwqUBzhhggPwCBE5ir+ox+AuIY9xML7o6qJ7lMoaC2CRmTlE0MD1iYD0XyVw4FOcrGngC0CeZytTgXKx/hgjm6WuGcwPX0odWP0ER3iv4glMCOYqGGwCbz1G3U5ln3aCg7Tro4xn7IZ+M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39850400004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(52536014)(64756008)(66446008)(66476007)(316002)(54906003)(66556008)(6916009)(4326008)(8676002)(8936002)(71200400001)(38100700002)(38070700005)(26005)(122000001)(9686003)(7696005)(6506007)(508600001)(76116006)(53546011)(966005)(33656002)(2906002)(5660300002)(66946007)(41300700001)(86362001)(45080400002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?d7sQbDAFVBvTRunBEyOWFS3hGsyAIkVMX1itxG/V1vD/izGkAYBvHav3Fmwy?=
 =?us-ascii?Q?I8O3Qt4nqiLe5OJnsHb+xT86YzF/v+8KmEI5ULpwJclK5cuW0Rgb02JkdpNQ?=
 =?us-ascii?Q?qsgAdvVWQsd4EVTKbiMMAlVQuF3MzDu7nbBhpfbaiYolofoX6u8HAiAi8dPs?=
 =?us-ascii?Q?h9XM45Ab0iHl75vU7+LC+krAeuF1MJietkI34LMj0PIRti47KpdPIZlekdls?=
 =?us-ascii?Q?u5BzvXwLzxAJu03tFRVMIoc58PIATttIIBQIlKNYw+vi9Vn3o4VnHCGWJSqd?=
 =?us-ascii?Q?SbllfBYs+4zmCOnVQkPAwJ4rjjbU7vTxKf7RIXJTPYcgZqgWoqY5gpLAZMsr?=
 =?us-ascii?Q?d/EAwVAB5S/Mgp75lIpv4k6RLgDSew85fcGxC3boB47jCHRMpItsdSH3mqhk?=
 =?us-ascii?Q?gmsEF+giuv4bvW9jkhhTXwK4c0tgPSECLvhscMYV/wF+QaNfR4N+WFZjfQBa?=
 =?us-ascii?Q?gO25q0tKJO2rhWrzXKqdQJ3u4pGBp4kRc7minTmojQlYF9qQGxrSnN+YkuOV?=
 =?us-ascii?Q?4LrbX6FPBjVx3mGZnuwfNBvgnF8b+3ZuMqKWShMlURZ5qidD7KVelsXplVM7?=
 =?us-ascii?Q?/H9BiCKEK0zX4VbV1gp+fr09i7wiaDeuz7nhAFbIpKAETPfhQ3kECYbKKzmK?=
 =?us-ascii?Q?ewtVlhYc1fy1AyZOzO+Hk8eBwJ5Cz4qwN7OdYe6pyXKg4voegJ6wuFBI8rxN?=
 =?us-ascii?Q?vHE9tYc5t5mi8aAw4K8lZedGBqLzQE3cQPJ3jA3vDXIMCi+2YhMDxXtmpxj8?=
 =?us-ascii?Q?mJJwhLdYy8+RyHd4ak1oywRDmF5AVjItWO0nPIDD6PZVr3zzmXU7FUV6ydvp?=
 =?us-ascii?Q?AliEF96X+zpUT5sLxH6eVxoVdRkbZ2bf33/OOt2pER4ybn1E1N2x/9zF70aV?=
 =?us-ascii?Q?nIFDWfiolnx9Vc3o/keEXCpLc/Gs34MAsLJEcI51rMav/OV9/+ddjlO42UvY?=
 =?us-ascii?Q?9nJNaOkRksjlzKAghyq+5CmAs/VxWNPZ6JGP9SK8GNL+kmpIm5iSgZqNnidP?=
 =?us-ascii?Q?v4oNpVUaCmfg+hfKpTwT9Hv0fVHPpKHYivM0NXHzk1rvyFoNJyqJMOuB/blk?=
 =?us-ascii?Q?hOMOYRAeVqA4OIQ1vOnY0Mc616P9k5Vf0/5eBGY0yKRJIAQGK83wOz68kaqk?=
 =?us-ascii?Q?ZAN981/XtiBJErKJf129u4mliQL/9Z8EJO0lEXgKE7YB8Xw4+rvpRSPm2etg?=
 =?us-ascii?Q?d9nXVy5OSSw2Uxb4Lt4XrC9ihTS7GFOsMBNINqM+HCQWRuYZAbTIkm9pXJNa?=
 =?us-ascii?Q?hMdUGzN+4Uupg7YdrvU/W+thCUdRDzDph+v6zWDTF5sJ51JXRuECJz1SASw7?=
 =?us-ascii?Q?NbLrEc3p2DH/wOlxyMxEVyN2HGEtljuLqOKxM3PE4uef8e8lIW2TcYQBMV3j?=
 =?us-ascii?Q?HlJuJYY5rW3ISv0VP+EtmoHgcnjlYOfiXLoKonapH9soQvYcHfI3sBmp1IPH?=
 =?us-ascii?Q?D6Ddw/dNK08IhYikHE35quqGCjF2IckoQIeEvNlmCJHYNXlL9Q9ResZOdmYd?=
 =?us-ascii?Q?kyhQoInmn94p+AgcKLUvNq39OO94EEvuwtBWQoaHCujMIDv9mUmxLd9BsvSz?=
 =?us-ascii?Q?Tsp3WEkDzARCtr7H3PYtHtJ/rw9GkAe9XNLzYBJN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3975d1f-5550-47ce-8c9a-08dbcf9737b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 05:00:58.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfvqCbsIHAMRsOLWxOtf9n6/tvKeZBjLsScfJJh9ok9Uo+hsYHQYVDqEANTzt93wSwDcbGmlfTot162hZPnKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
X-Proofpoint-GUID: hyk7OGzkOUrxmkwRu0T4iHljt7iZYMLg
X-Proofpoint-ORIG-GUID: hyk7OGzkOUrxmkwRu0T4iHljt7iZYMLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310180042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Tuesday, October 17, 2023 10:06 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Ingo Molnar
> <mingo@redhat.com>; USB mailing list <linux-usb@vger.kernel.org>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; linux-rt-users <linux-=
rt-
> users@vger.kernel.org>
> Subject: Re: USB: add check to detect host controller hardware removal
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Tue, Oct 17, 2023 at 02:23:05AM +0000, Li, Meng wrote:
> > I did some debugs on my side.
> > Firstly, the local_irq_disable_nort() function had been removed from la=
test
> RT kernel.
>=20
> What's in the RT kernel doesn't matter here, because the code you're patc=
hing
> belongs to the vanilla kernel.
>=20
> > Second, because of creating xhci-pci.c, the commit c548795abe0d("USB:
> add check to detect host controller hardware removal") is no longer usefu=
l.
> > Because the function usb_remove_hcd() is invoked from xhci_pci_remove()
> of file xhci-pci.c in advance.
>=20
> What about for non-xHCI controllers?
>=20

I will try non-xHCI controllers in later if I can find out one on my side.

> > I am trying to fix this issue with getting register status directly wit=
hout
> local_irq_disable().
>=20
> Were you able to locate the original bug report?
>=20
This is original bug report
https://bugzilla.redhat.com/show_bug.cgi?id=3D579093

my latest debug information as below:
when I removed the PCIe-USB card, there is below exception calltrace when o=
perating host controller register.
Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT_R=
T SMP
Modules linked in:
CPU: 3 PID: 329 Comm: usb-storage Tainted: G        W          6.1.53-rt10-=
yocto-preempt-rt #1
Hardware name: LS1043A RDB Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : xhci_ring_ep_doorbell+0x78/0x120
lr : xhci_queue_bulk_tx+0x3b0/0x8a4
sp : ffff80000b0e3960
x29: ffff80000b0e3960 x28: ffff000004ce2290 x27: ffff000008e71100
x26: ffff000005718a80 x25: 0000000000000421 x24: 000000000000001f
x23: ffff000008e71108 x22: 0000000000000000 x21: ffff8000099e5100
x20: 0000000000000002 x19: 0000000000000004 x18: 0000000000000000
x17: 0000000000000008 x16: ffff00007b5cfb00 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
x11: 0000000000000001 x10: 0000000000000a40 x9 : ffff8000089b0b50
x8 : ffff0000057c9a00 x7 : 000000000000001f x6 : ffff0000056c8000
x5 : ffff800009714ca0 x4 : 0000000000000004 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff8000099e5108 x0 : ffff000004ce2290
Call trace:
 xhci_ring_ep_doorbell+0x78/0x120
 xhci_queue_bulk_tx+0x3b0/0x8a4
 xhci_urb_enqueue+0x274/0x510
 usb_hcd_submit_urb+0xc0/0x8b0
 usb_submit_urb+0x29c/0x5c0
 usb_stor_msg_common+0x9c/0x190
 usb_stor_bulk_transfer_buf+0x58/0x110
 usb_stor_Bulk_transport+0xdc/0x380
 usb_stor_invoke_transport+0x40/0x530
 usb_stor_transparent_scsi_command+0x18/0x24
 usb_stor_control_thread+0x20c/0x2a0
 kthread+0x12c/0x130
 ret_from_fork+0x10/0x20
Code: 540001cc 8b140aa1 d5033ebf b9000033 (b9400021)=20
---[ end trace 0000000000000000 ]---
Because of the exception, the xhci->lock in xhci_urb_enqueue is released no=
rmally.
In this situation, if remove the pcie device with below command
# echo 1 > /sys/bus/pci/devices/<PCIe ID>/remove
The code will hang at the xhci->lock in xhci_urb_dequeue() function.
Even if I refer to commit c548795abe0d, move usb_hcd_irq(0, hcd) to functio=
n xhci_pci_remove(),
there is also an exception calltrace("Internal error: synchronous external =
abort") when executing readl(&xhci->op_regs->status);
although the code doesn't hang, the exception causes that code is broken fr=
om xhci_pci_remove(), the flowing code is not executed.
Because usb_hcd_irq(0, hcd) causes exception, I think it should be removed.=
=20
In additional, removing PCIe card suddenly is not a reasonable operation, i=
t may destroy the hardware.
so I think we don't need to add usb_hcd_irq(0, hcd) on the logical path of =
unbinding pcie driver.

Thanks,
Limeng

> Alan Stern
