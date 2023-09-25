Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB51D526
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 17:08:28 +0000 (UTC)
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 10:08:24 PDT
Received: from mail265c50.megamailservers.eu (mail1450c50.megamailservers.eu [91.136.14.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCEB107
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 10:08:24 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
	s=maildub; t=1695661330;
	bh=TO2uLul8ab5bLAlQrsihDV2/TnziiaKP1BxnhulNOVI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=CDxe/k6fNQHM9TdEq/3W50YMi6aOeDgnbfMh3k/4MRKEAmnSyyiEXybqVDPcSHe/C
	 JwjzsWijpJPxSnqWUB9Iiss1IhQSiUwMFppnZRNJRqZpTE4W0UDtSuFo/GscIiwULp
	 vuSnBUJmpHPwlLAbP4ApR7ryBrKUHVcUSa9Rjrgs=
Feedback-ID:ralf.mardorf@al
Received: from [192.168.1.4] (dynamic-093-132-142-254.93.132.pool.telefonica.de [93.132.142.254])
	(authenticated bits=0)
	by mail265c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 38PH28Km110297
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Sep 2023 17:02:10 +0000
Message-ID: <21545cbee0cede97a05cda2e41e1b1ec98376cd0.camel@alice-dsl.net>
Subject: Re: High latency of a system based on 5.19 rt
From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To: linux-rt-users@vger.kernel.org
Date: Mon, 25 Sep 2023 19:02:07 +0200
In-Reply-To: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
References: <S1JV78$805284328FE38E68AC9E7D23F35846D8@eurosoft.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: 0
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffuvffqrffktedpqfgfvfdpgffpggdqveehtdenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeftrghlfhcuofgrrhguohhrfhcuoehrrghlfhdrmhgrrhguohhrfhesrghlihgtvgdqughslhdrnhgvtheqnecuggftrfgrthhtvghrnhepffdthfffvdfgfeefjeeftdegkeejueeffeegveefueefffevkeegkeellefgvdehnecukfhppeelfedrudefvddrudegvddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelfedrudefvddrudegvddrvdehgedphhgvlhhopegludelvddrudeikedruddrgegnpdhmrghilhhfrhhomheprhgrlhhfrdhmrghrughorhhfsegrlhhitggvqdgushhlrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqrhhtqdhushgvrhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Origin-Country: DE
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-25 at 18:30 +0200, g.medini@eurosoft.it wrote:
> The problem I've actually seems related to i915 driver.

Hi,

I don't know what kernel versions and Intel GPUs are affected, let alone
that I don't know if it has got any impact on real-time tasks, however a
while back I migrated from

Driver      "intel"
to
Driver     "modesetting"
and added the kernel option
ibt=3Doff

to get rid of Intel graphics issues, that IIRC were not related to real-
time tasks. I only want to point out that Intel GPUs and Linux don't
play well together, since Intel doesn't support Linux anymore.

Regards,
Ralf

--=20
Disclaimer: By sending an email to ANY of my addresses you
are agreeing that:

1.  I am by definition, "the intended recipient".
2.  All information in the email is mine to do with as I see
    fit and make such financial profit, political mileage, or
    good joke as it lends itself to. In particular, I may quote
    it where I please.
3.  I may take the contents as representing the views of
    your company if I so wish.
4.  This overrides any disclaimer or statement of
    confidentiality that may be included or implied in
    your message.
