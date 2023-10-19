Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E3225BB;
	Thu, 19 Oct 2023 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+NDV373";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfO34BnV"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD991;
	Thu, 19 Oct 2023 05:38:25 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:38:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697719104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTOgvvgFPD5ufvV7EQ4wtiesMfWF1h3o5jKZf9gNXU=;
	b=k+NDV373QwVvGeZ4Q/jjpVz5K3HyK4r5qTJKPfuq3hFqGbzUTlX3YX3Yy60FC9A96l1v2E
	2jk6hZxnxJIwTdaJG3UVGhUTeo5TcSCo4L7E/HPJTZgqkLH3ufik7p6eF+tZO38Z35b1vB
	6r7S6hdxjF51MBNnwtFgNiT6qoFYnbbvw8mOUvO/x16mHJq1PYiNuetX7LzC999QtZQpak
	4oE+8wVLIPgs/8u9E0kuX+OanApLMr/tL8NLT409hIdRb0I0PwtMEoPzbkP5Ouxnw67YAr
	bajQHCqdWejF0irmD7S3IK/GSEN1c/+J0je+n5Z4g6ozrJK8BM1+tKy8VzJD2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697719104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LTOgvvgFPD5ufvV7EQ4wtiesMfWF1h3o5jKZf9gNXU=;
	b=OfO34BnVcotF+4StcSrq2xZ7lSzDa+Bf6v2CRzvsrEP8ZhQ2UE8UDLRoz9qIuCRttO+9RU
	UNGFAA+NsxmEd7Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Meng" <Meng.Li@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231019123823.4fjUs8Rl@linutronix.de>
References: <PH0PR11MB5191464B2F01511D2ADECB3BF1D2A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>

On 2023-10-18 11:20:46 [-0400], Alan Stern wrote:
>=20
> If you hadn't removed the card suddenly, the exception would not have=20
> occurred.  So the logical conclusion isn't that we should get rid of the=
=20
> usb_hcd_irq(0, hcd) call -- the logical conclusion is that you shouldn't=
=20
> remove PCIe cards while the system is running.  Not unless your computer=
=20
> uses the special hardware from Stratus Technologies.

So the card was removed and the kernel complained that it can't access
the memory behind the PCI-bar?

How odd=E2=80=A6

> > so I think we don't need to add usb_hcd_irq(0, hcd) on the logical path=
 of unbinding pcie driver.
>=20
> What about cardbus or PCMCIA cards?  Removing one of those cards=20
> suddenly, while the system is running, is a perfectly reasonable thing=20
> to do and it will not cause any hardware damage.  So I think we should=20
> keep the usb_hcd_irq(0, hcd) call.

Don't you invoke pci_driver::remove in such case to properly let the
physical device go? This can also be tested via unbind from sysfs.

> Alan Stern

Sebastian
