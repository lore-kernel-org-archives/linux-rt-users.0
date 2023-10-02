Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88F6AD6
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 10:03:07 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB719F
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Oct 2023 03:03:05 -0700 (PDT)
Date: Mon, 2 Oct 2023 12:02:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696240983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+JwY/Zv1tfC24PpjG7v95bEOjOfUJWKpZhpSR68S08=;
	b=Jm2A5ab0h8o6Hi472ZTAlhiaQjQLOOFPCQpDNN70pVgxtIBnS2/ZikV2S0FK/RP91BPUDq
	R6GHZlwrJ3xdrHh/eosktFvol3zfV/1T5QnSEA2eZqmCCgAzStKV9JoZPV/27EBccAfwqj
	epp1BJHEFLC9DxrOtUoYoYmIQxNUmOqOBW1+jKMERq1giXc/a8QSi+HHLkMu4rY00Ty4SM
	r3BNyHb5VRr4J4ED5va/14kTgxTEuxNSYTgS7syicgHdqomT1uibos7nWAtR8WaKiYt61x
	DUWv9+U6v32Ue7Z3hfUFTPRfjQO5YJlJ8ULHeUAL73hLlZTcGG9cOEX6lVn/Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696240983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+JwY/Zv1tfC24PpjG7v95bEOjOfUJWKpZhpSR68S08=;
	b=mn1aQpBICNGnGZIBIyt/l0fp7yBGW4aTNj8+73n3Yw5Js1kDkNkTHlyqTebX+htm9X8ukj
	LBPugzpqg45pYiBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: g.medini@eurosoft.it
Cc: linux-rt-users@vger.kernel.org
Subject: Re: High latency of a system based on 5.19 rt
Message-ID: <20231002100257.FQFcIFo9@linutronix.de>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-25 18:30:44 [+0200], g.medini@eurosoft.it wrote:
> 
>    Hi All, I'm struggling with a realtime issue I have.
Hi,

>    Using trace I've found a problem related to CONFIG_X86_DEBUG_FPU that was introducing very large latency.

Do you have a trace and numeric value of "very large latency" for
CONFIG_X86_DEBUG_FPU?

>    Removing this I have another one where the solution is not so trivial.
> 
>    The problem I've actually seems related to i915 driver.
> 
>    With a particular load for the graphic card (basically using ALT-TAB to switch from graphical windows or pressing the Win like button to resize all the graphical windows to the screen) I see an huge latency that gives problem to an rt task I need for my application.
> 
>    I've tried everything to optimize the sytem.
> 
>    As expected I find little enhancement that help me to mitigate the problem (core isolation and so on) but the basic problem remain the same (it happens with X11 and Wayland also).

What is the latency problem? The wake up trace shows a wake up from
gnome to irq-work. Is the graphic/ i915 lagging or something else?

>    Hoping someone can help me.
> 
>    Gianluca
> 
>    Cordiali saluti
>    Best regards

Sebastian
