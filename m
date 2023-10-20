Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549213AF6;
	Fri, 20 Oct 2023 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufEyyP70";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45w3GMtK"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8F3D57;
	Fri, 20 Oct 2023 02:52:40 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697795559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha4WboQH0wvLWNZK27p4BBqM2/6N2Jm4CY4Yeuwv5qo=;
	b=ufEyyP704B+d8J05wxZVp0XRLeGnyXLi5No5e06yFsO2W9UT0ak67gi+wuodHSwEyCk5UT
	VJVr4pOzHk0jgGC9x6pUPSX21f9jX+1e7qlGXvx0iShNtZjKsVGSiWlplBTSnP6k/Mj9Af
	CLijp35Q2rg9nalfallcfJUioklTGM89sykHIm+4Nw6yZM436SIW7cSovmxKRgtN0mE09G
	c36B0XOk0T/WUBkYmWJyJzHcEZxfTEOaTIwwbudGTLkYxX0KlLTWLku/7m6HV0xGGFmUPo
	m0j8GbLDxxFHsRWsH7bBC9tbL9pRsok7bLThQkTZOGuLBAjJ5Zjs3Kpo9NjZ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697795559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ha4WboQH0wvLWNZK27p4BBqM2/6N2Jm4CY4Yeuwv5qo=;
	b=45w3GMtKSzYAvZ1o0l4bxkHBdRsK1lJAh9E6nRuyN+IyiFTnwOurLJIpk0AueqKPefNvp1
	HLSQ5O+SiSM+AEBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Meng" <Meng.Li@windriver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: USB: add check to detect host controller hardware removal
Message-ID: <20231020095238.Z4m-M_oS@linutronix.de>
References: <9a1074e2-c1ae-485b-b5e7-a34442c98c0b@rowland.harvard.edu>
 <20231016125624.1096766a@gandalf.local.home>
 <62fdcf97-11c6-4dee-8db1-74752d6949f3@rowland.harvard.edu>
 <PH0PR11MB5191924ECC92A8F67891D614F1D6A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <d6d9478c-585b-4f51-a076-dc2955c6b2b0@rowland.harvard.edu>
 <PH0PR11MB51911132F6CB7DF0C41F15DEF1D5A@PH0PR11MB5191.namprd11.prod.outlook.com>
 <1f8fe9f9-d8d6-48d9-8c7d-1215d10ece91@rowland.harvard.edu>
 <20231019123823.4fjUs8Rl@linutronix.de>
 <128e4bea-6064-4e46-b9c7-75296e9f553d@rowland.harvard.edu>
 <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55925f45-4921-46cc-81df-ac705ad7530e@rowland.harvard.edu>

On 2023-10-19 11:27:54 [-0400], Alan Stern wrote:
> 
> Perhaps that what we should do.

Perfect.

> Alan Stern

Sebastian
