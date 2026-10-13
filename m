Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0301513561
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Oct 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905386; cv=fail; b=ik0HorZCszXCn+TptORYtEY3QfqQk7vcK5JRvKi4tO7+1xDf4k4S7KMmHFDLbwbjBcANZi6PdOhvk5doPYOVmxfkiSQVQ4oL5Oz22FynSy/bzrkEh3cYIz9fekjxZkae2ludSldW/qPVr2dopaObEkRUPVe2UPAcNNSqy226dho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905386; c=relaxed/simple;
	bh=1ibwlD8TYpUZerc1RmaJo/z4cNS2izb4twtLoXm2RM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ain+6TSLmjwY0J4AqJKvgnxo+5/XlW7+H7uPNev+W/owblmmEjgffMEEUBDLCIjxZfZ/2aK2CHGRa4sK1u0HDWRB1VECIiQwveBTxdDAM7g5W5tabKyArWHRgkksxSD0iru201hFSxOozG1esg1iG7tbgvUA5ohTzsL4Ak5i26k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com; spf=pass smtp.mailfrom=eaton.com; dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b=ZicFtaNC; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eaton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eaton.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eaton.com header.i=@eaton.com header.b="ZicFtaNC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8YdhsK+rTJ6a51Iysw1nrT/FzO4CBQzAStc6qq4SXpTSNmjeYHdb47BzGaAgy6jB0Avm0lSxvUoINonIe9QwzF0Jo5DmvP6AhewuKj/mqsH0mzc/CnGji+2TYLwiRJ/sLMl5P9gDw7M1G3aTq4VEHaHmCh4cPmN/yC2H0WZSS6gUk3Z+z4ox3GwmJOuIs1eXIvuaHBp2mBTcjKMPBSodzMIRSPwxFcOHVBn5nVd3S2h+Wz85Dr4LtL7vau+63qKdZTeBV841tMH/giA5owez3/4zOHb6h5EoyLp5gAdFSc4HbRz1mZvu+Ori4D0b6f2waAFLk//IjD5X6h5Ezu6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9aeymBV04Ikps8mC9ClfMEg3QN0cbrkiX/+z+wbyHU=;
 b=HaVLCnh01l+e5uW1UC/Bc4suHJcZmFmREJSArCFQO92ebHCBuJ6mpP+dp9LggLtGl9cCIgKOFMVuVmo5WSOZW7e9Kb84v+utPCWK3JgnufDk3wvYoW0XlTZirp6M8UXH0t0zC5+nYHCZliKyNxME4YxAPmuUJ2KLHBXya/9zftGMrtH/4rpZ5fjjDho49dlYjmyf7b0mrVqb9M7rWEaDxMz1rGXoZ3i9WcTE0jJgqIhnlgxY7oEytT5yR4ERkWLkl3Ll/5uTYSQlKb0exr2bK8G38YDF7Es0dAChpo41iBoWxzM8CpEW2DdGb5/snAVrTJnpTtcWbAMFGDAv34829g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eaton.com; dmarc=pass action=none header.from=eaton.com;
 dkim=pass header.d=eaton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9aeymBV04Ikps8mC9ClfMEg3QN0cbrkiX/+z+wbyHU=;
 b=ZicFtaNC4xNIZXL+O32DezGaE4IJEovFmnTHLlgxStAlJvjMhSicICp6Clyr701BmBDKoNkyjO4TVZ71LQDBs3psy5sMQI7P2bvb8lj09pgmmE8jkp/GQ6lfDE1aBCMMx3vWtVUWf1W0Yxb9AOWOOZ6quUGlkLPXzZnN4nNkNQ4e4CYew5IjDZ+8AwvzTsipLeGVmXWa3KbjDn8SA2Qmi5XZz3U3k75EIrMEURmTLtLlWY2myo6zQD/y5zd9B7UHlqDEe6D9N7jg3KP7F084D2VSsF+VOjF6mHX2akEB3H2eyYU4hzF3VU0QNzXPnZCqIseYvEb3jYo5+SfgUndEgA==
Received: from PH0PR17MB4277.namprd17.prod.outlook.com (2603:10b6:510:a::15)
 by SA1PR17MB6549.namprd17.prod.outlook.com (2603:10b6:806:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:29:39 +0000
Received: from PH0PR17MB4277.namprd17.prod.outlook.com
 ([fe80::f000:695f:be77:9fd2]) by PH0PR17MB4277.namprd17.prod.outlook.com
 ([fe80::f000:695f:be77:9fd2%3]) with mapi id 15.21.0496.019; Tue, 13 Oct 2026
 15:29:39 +0000
From: "Naulls, Peter" <PeterNaulls@eaton.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Btrfs PREEMPT_RT transaction-waiter livelock:
 experimental mitigation in kernel 6.6.78
Thread-Topic: [EXTERNAL] Re: Btrfs PREEMPT_RT transaction-waiter livelock:
 experimental mitigation in kernel 6.6.78
Thread-Index: AQHdV/zYoCdqLEUpiUCMf474Lb+SQbb7kdeAgAAE6Fw=
Date: Tue, 13 Oct 2026 15:29:39 +0000
Message-ID:
 <PH0PR17MB427717FB56C49D194444AB6BBB9E2@PH0PR17MB4277.namprd17.prod.outlook.com>
References:
 <PH0PR17MB4277167A37B20340B231443FBB922@PH0PR17MB4277.namprd17.prod.outlook.com>
 <20261013144119.-2EEqlL-@linutronix.de>
In-Reply-To: <20261013144119.-2EEqlL-@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_Enabled=True;MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_SiteId=d6525c95-b906-431a-b926-e9b51ba43cc4;MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_SetDate=2026-10-13T15:29:38.362Z;MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_Name=Public
 (IP1);MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_ContentBits=1;MSIP_Label_8afd4f73-fada-4b37-96db-6e01034f2850_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eaton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR17MB4277:EE_|SA1PR17MB6549:EE_
x-ms-office365-filtering-correlation-id: 879030d9-4b72-45ed-724a-08df293ecbb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|10067099003|22082099003|11063799006|4143699003|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 Vd+9/JzCvkUb1TmPuRI1tYl9iHpDUvvBZ14ieWrV1y9xQ9sroNVDm5YI4w5vmO0zpgPaIrKJ0d8B5snziXYvXGHlGkABEq9RH2/AwytqbVVxdyQhjHmHyX1VY7AdGel3K940jbYCIbVXEcOAk0gVznFY+2bf+fCcj6JHDx7HfqMTR6uC1sOcCxQp6bNQiVMnPIU8nS9oK/Ob/DEiRaPoIkXgZLtRnz3WUAkDynXzxRyo2bKyEbS1Unq77dlLhLJ1GTV0w/FG5v5/PHv9vCkujmATKbEyVfOEFVKmrlF61rtMfFalRhE8xs/7rICLjFZP4XiNVcPW1Y5F/fl1p3WrhJwKETtbMyrtXz8m4nk6fl7eYGE8cU+a+Ec5VuJxXLAyYEWjjVfZq8y/PG5CYFJ13Fm+V0sl+H2fxi3PYxvLW2NBd9yIwJRruf3TfX4ImNuxX9lDS8WQt+8Tq3pKiijc+JBximQQppc9DGnUEqYau9HhTUGfuzEkG4aBBHkaTm6jehSnEK7AoNl5Pj9e/ock+SMgm9cj1n2LN+JjuMOBVGQ+To0vorG9p0OmcMo3w/Ep3nFKIXy3r24bC+KeOSshaFcNMAOOsUy7JmJkuKNxiFzvvuXKtqzE+2ceAEVzqU7ZxYFEJOljRszfqDSNMz21N7jeOBtj1SX7HHX1LW41C7zQ1itfqnbflgDatpKpKOXE0LQJt/a//8sBhT+6enOGDQR2mGjceDhkhPd/gDgIPaY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR17MB4277.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rPxPlwZQBYxHwBjOLwhAAA3imNY5oyP4Hk6rP0enU4O6u7a1OfzMoISXOI?=
 =?iso-8859-1?Q?JRtjJU8kdbNcTMe4IqIncZkpUaXrQHEKyUl/V9OEJp0tog3aDAW9Sj6LKs?=
 =?iso-8859-1?Q?MEd6zT/t2o91tbxLuPXwMklBRhtnaRSLYe6RJwIvVEDSwag+Qe58UMff5n?=
 =?iso-8859-1?Q?xyQlBvIW5QcrY4zXYh96ELmMKwWk/oDk0ApaZfkXVJWQ7UIbwxUAdMRgSU?=
 =?iso-8859-1?Q?clCMuMcLiVzITxy263TdmDvqfUrWbd2Ra5LnOXSsnq0BpkspQ2E8Y0wmBw?=
 =?iso-8859-1?Q?GmLr7f6xkvv1Dg8Fx4adwVdge8RqswiHU0M5GVmVy2EPLIUM3Qckhem+fz?=
 =?iso-8859-1?Q?+2Lpi8mPS6kuUQcJBl4ZA5Mc68cVAJKNDww3i3MvilouoQv4/Z6/xCvb87?=
 =?iso-8859-1?Q?aXhzzbhGl8MSoaODSG5MR/eTJGUvEwppRr1CNiPl2WNdup4iGf9XeGpBbU?=
 =?iso-8859-1?Q?KExUotsVZdM7Sh7AJnKN1lOZLsbJwb7b+0JD0fx/HlhByAe5xZY1/+Aq08?=
 =?iso-8859-1?Q?gN1FxhwIV+s+CExvDT2Ych0tL+A7X63DnG1hACM/vNhpZAJhWBYpgu8gVq?=
 =?iso-8859-1?Q?O2f8NsXOrCZ+/VA36FUp/2K0NIZHlFvrT1fNO/f3cuHg58xyHyXBdO+Tls?=
 =?iso-8859-1?Q?pdYanVeBGJbZqD2Kmkb3yu2iYIdjXvtK5E5ovMq4alngPNi0r/xTrguwgq?=
 =?iso-8859-1?Q?RHywMbslkdSdbVMFCfCbf4vZq6OqOWYge6yESNLMn6Il34WH4ArymlHbt1?=
 =?iso-8859-1?Q?mQa8M7YjCCwfONaqWb6hJnqxeERWRZy8neUQxtEm9l9mjvxETTNCq4n8Na?=
 =?iso-8859-1?Q?vJ7Z/o8LFT6XVsd/Qs02boWpprCHAGKyvsNPfK9XLsCGLRViQE9uFQ1ddn?=
 =?iso-8859-1?Q?AKQAEKtW7iYrPwMgXrWYjVYXZbAyZgTOgYMJXhv2Vc616VmQBvz5aAgRuZ?=
 =?iso-8859-1?Q?YVMwg31Pf43YwPjPXYWSMjS8sw/w8hkoV3FKvrlQBKiI75rMWmdSijZZwL?=
 =?iso-8859-1?Q?rNYHH6ZsF2n8Xsa1+MfjdEJ5+7S+Kfx6q754AQMhyAed8Ca5crkj/vHVWa?=
 =?iso-8859-1?Q?DtDZDLg3zEGNwtxWHIvjpyMt7nhGXY5qTfb7rGRNbBdvctcpANSyJQJu5I?=
 =?iso-8859-1?Q?w58WjJDzLFztaaLYfpsxByL8lOfjumsR1dHqgaJxh/q5XsM9LlGxTBWmq5?=
 =?iso-8859-1?Q?nsbDsHa1Cn6rEFaEHMrtmx32yeklbVPpkT4FzB+SXD5eOh7PyGIXM0fFrm?=
 =?iso-8859-1?Q?mPBUbu6hBqOADl8Mbsg1edumDxJJ2RJVAL/DsCWq+pJCzfh/NFe21LhGLh?=
 =?iso-8859-1?Q?o6LDSR/rKF5iER0HxwkSY4cSbeZZ9pgACUbbeldRTHVO8gWkFeNL4ISmRL?=
 =?iso-8859-1?Q?fQsmNOa9B3CqKTalJV7rvX8SbRvMmqxo1IsWj7D0VA9+uczNOFWTDPHOhG?=
 =?iso-8859-1?Q?dUCBfE1XIgc1SxHhmwmWaHE4cbHUTqrMhJG/77LwCI5YqSimIW+AWXUZeE?=
 =?iso-8859-1?Q?A95M5sQDsBzcPErtz2UQHJc1SYNkNyGVnYMPxNCL0rrPid1kdk9qqS8Dm0?=
 =?iso-8859-1?Q?mm1UB4vI5tmd/JpJ/amVktT4n/BJrkHiLPcclQi4M4uh0FcEIM9juSxwdo?=
 =?iso-8859-1?Q?q5oAjUnDt/waP+AV9W5NN7K/RV2xzobY/cXCF9Pvh0jOsPKDVqB1FnL8EQ?=
 =?iso-8859-1?Q?k7Db3Fx/GpzrFjHQhXCpJlBTT5l4aCo57iZ3JL0TctGo08co83RxGatXo9?=
 =?iso-8859-1?Q?S8yG/DPfzFGhGnCF2RTVMtOYS/e7JHV2qA2NGQuXEEjwi8ELazF9F0wqlK?=
 =?iso-8859-1?Q?RqFURT9zvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eaton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR17MB4277.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879030d9-4b72-45ed-724a-08df293ecbb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 15:29:39.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6525c95-b906-431a-b926-e9b51ba43cc4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w3biV3VyjLahUPmhKnAU/jFBWpXsdLN7sM14l9Nb3qfiwdFFP3PaZ5e0n36VpQLrSGGzsDWPs1WeouGWCclog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB6549

With apologies for Outlook formatting, it's not my first choice. =0A=
=0A=
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
=0A=
> This sort of sounds like the state is TRANS_STATE_SUPER_COMMITTED but is=
=0A=
> not making progress after that. Are there any tasks involved that run at=
=0A=
> realtime priority and would block other tasks from making progress?=0A=
=0A=
I won't say it's impossible, but it's not likely. We have a monolithic app =
which is disabled for this test. There =0A=
may be other subsystems writing to the log. To the best of my knowledge tho=
ugh, there's been no adjustment=0A=
of priorities (we are experimenting with this, but it's inside the app and =
wasn't turned on for this test)  vs default =0A=
Linux setup - it is Yocto using a largely standard setup. =0A=
=0A=
> PREEMPT_RT shouldn't do much different than !PREEMPT_RT. Do you have=0A=
> tasks with different priorities? If that is the case then it might be=0A=
> that one thread is blocking another thread that should make progress.=0A=
> Your changes iterates over TRANS_STATE_COMPLETED so it seems that it is=
=0A=
> not cleaned up for some reason.=0A=
=0A=
As you say; this is not my expertise. =0A=
=0A=
> Could you try if you can reproduce this with v7.3-rc7? This one does not=
=0A=
> require any additional patches.=0A=
> I'm not sure if this report would help the btrfs folks to recognize if=0A=
> this is a solved problem or where the issue might be.=0A=
=0A=
Trying a later kernel is not impossible, but it somewhat time consuming, I =
will have to strip a number of things from the build, =0A=
and Yocto doesn't make this particularly straightforward, and might even co=
mpromise the test. We will update the kernel =0A=
in due course, but you'll understand I'd prefer not to commit this time wit=
hout some degree of confirmation here.  As things=0A=
stand right now, it may be that we just run without RT, but it would be goo=
d to at least verify this, and have a record for =0A=
other people. =0A=
=0A=
As for brtfs, yes that was my next follow up, I had been just about to do t=
hat before your reply. =0A=
=0A=
Regards. =0A=
